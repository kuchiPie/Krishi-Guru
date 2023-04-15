import pandas as pd

df = pd.read_csv('relevant_ques2.csv')

df = df[df['QueryType'] != 'Government Schemes']

print(len(df))

df.to_csv('cleaned_relevant_ques2.csv')

