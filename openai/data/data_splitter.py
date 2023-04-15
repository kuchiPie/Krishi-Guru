import random
import pandas as pd 

# Load the dataset
df = pd.read_csv('openai/data/agricultural_sections.csv')  # Replace [...] with your dataset

df = df.sample(frac=1).reset_index(drop=True)

half = len(df) // 2
df1 = df.iloc[:half]
df2 = df.iloc[half:]

df1.to_csv("data_splitted1.csv")
df2.to_csv("data_splitted2.csv")