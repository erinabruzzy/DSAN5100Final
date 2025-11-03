from datasets import load_dataset

# download from hugging face 
ds = load_dataset("felixludos/babel-briefings")
print(ds)

# initial cleaning 
train_ds = ds["train"]
cols_to_keep = ['ID','publishedAt', 'instances', 'source-id', 'source-name', 'en-title', 'language']
subset = train_ds.select_columns(cols_to_keep)
print(subset[0])

# break into chunks for upload to github
split_size = 1000000 
for i in range(0, len(ds), split_size):
    chunk = subset.select(range(i, min(i + split_size, len(ds))))
    chunk.to_parquet(f"data/original_data_{i//split_size}.parquet")

print("done")