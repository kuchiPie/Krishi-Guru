import pandas as pd

df = pd.read_json('/home/siddharthb/Krishi-Guru/openai/data/data.json', orient = 'split')
print(df.head())
# df.to_json(orient='data')
# df.to_csv('relevant_ques3.csv')

# df = pd.read_csv('relevant_ques3.csv')

df = df[df['QueryType'] != 'Government Schemes']

print(len(df))

df.to_csv('cleaned_relevant_ques3.csv')


