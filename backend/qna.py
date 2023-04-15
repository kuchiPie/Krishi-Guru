# Note: you need to be using OpenAI Python v0.27.0 for the code below to work
import openai
def res(messages: list):
    try:
        if len(messages) == 0:
            messages = [
                {"role": "system", "content": "You are a helpful assistant that helps farmers. Today's weather is {var} the farmer's soil type is {soil} and the crop type is {type} "},
            ]
        response = openai.ChatCompletion.create(
            model="gpt-3.5-turbo",
            messages= messages
        )

        return response
    
    except Exception as e:
        print(e)
        return ""