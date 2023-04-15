import pandas as pd

df = pd.read_json('/home/shreyasb/git_workspaces/Krishi-Guru/openai/data/training_questions.json', orient = 'split')
print(df.head())
# df.to_json(orient='data')
df.to_csv('relevant_ques.csv')


