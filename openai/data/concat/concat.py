import pandas as pd

df = pd.concat(
    map(pd.read_csv, ['cleaned_relevant_ques.csv', 'cleaned_relevant_ques2.csv', 'cleaned_relevant_ques3.csv']), ignore_index=True)

print(len(df))

df.to_csv('merged_cleaned_relevant_ques.csv')