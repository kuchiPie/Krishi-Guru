# Note: you need to be using OpenAI Python v0.27.0 for the code below to work
import openai
from weather_api import realtime
import pandas as pd
import ast  # for converting embeddings saved as strings back to arrays
import pandas as pd  # for storing text and embeddings data
import tiktoken  # for counting tokens
from scipy import spatial  #
# models
EMBEDDING_MODEL = "text-embedding-ada-002"
GPT_MODEL = "gpt-3.5-turbo"

embeddings_path = "embddings.csv"
df = pd.read_csv(embeddings_path)
df['embedding'] = df['embedding'].apply(ast.literal_eval)

openai.api_key = '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'

# search function
def strings_ranked_by_relatedness(
    query: str,
    df: pd.DataFrame,
    relatedness_fn=lambda x, y: 1 - spatial.distance.cosine(x, y),
    top_n: int = 100
) -> tuple[list[str], list[float]]:
    """Returns a list of strings and relatednesses, sorted from most related to least."""
    query_embedding_response = openai.Embedding.create(
        model=EMBEDDING_MODEL,
        input=query,
    )
    query_embedding = query_embedding_response["data"][0]["embedding"]
    strings_and_relatednesses = [
        (row["text"], relatedness_fn(query_embedding, row["embedding"]))
        for i, row in df.iterrows()
    ]
    strings_and_relatednesses.sort(key=lambda x: x[1], reverse=True)
    strings, relatednesses = zip(*strings_and_relatednesses)
    return strings[:top_n], relatednesses[:top_n]

def num_tokens(text: str, model: str = GPT_MODEL) -> int:
    """Return the number of tokens in a string."""
    encoding = tiktoken.encoding_for_model(model)
    return len(encoding.encode(text))


def query_message(
    query: str,
    df: pd.DataFrame,
    model: str,
    token_budget: int
) -> str:
    """Return a message for GPT, with relevant source texts pulled from a dataframe."""
    strings, relatednesses = strings_ranked_by_relatedness(query, df)
    introduction = 'Use the below articles on the Rice crop to answer the subsequent question. If the answer cannot be found in the articles, write "I could not find an answer."'
    question = f"\n\nQuestion: {query}"
    message = introduction
    for string in strings:
        next_article = f'\n\nWikipedia article section:\n"""\n{string}\n"""'
        if (
            num_tokens(message + next_article + question, model=model)
            > token_budget
        ):
            break
        else:
            message += next_article
    return message + question


def ask(
    query: str,
    df: pd.DataFrame = df,
    model: str = GPT_MODEL,
    token_budget: int = 4096 - 500,
    print_message: bool = False,
    messages = list()
) -> str:
    """Answers a query using GPT and a dataframe of relevant texts and embeddings."""
    message = query_message(query, df, model=model, token_budget=token_budget)
    if print_message:
        print(message)
    if len(messages) == 0:
        pre_prompt = {"role": "system", "content": "You are a helpful assistant for farmers."}
        messages.append(pre_prompt)

    messages.append({"role": "user", "content": message})
    
    response = openai.ChatCompletion.create(
        model=model,
        messages=messages,
        temperature=0
    )
    response_message = response["choices"][0]["message"]["content"]
    return response_message


def res(query:str, messages: list, soil='black', crop='rice', lat=26.2006, lon=92.9376):
    try:
        # if len(messages) == 0:
        #     weather = realtime(lat,lon)
        #     messages = [
        #         {"role": "system", "content": "You are a helpful assistant that helps farmers by giving relevant information on agriculture practices. Today's weather is {weather} the farmer's soil type is {soil} and the crop type is {crop} "},
        #     ]
        # response = openai.ChatCompletion.create(
        #     model="gpt-3.5-turbo",
        #     messages= messages
        # )
        print(query)
        return ask(query = query, messages = [])
    
    except Exception as e:
        print(e)
        return ""