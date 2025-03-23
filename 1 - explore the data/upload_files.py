import sqlite3
import pandas as pd

# Upload csv files in to database through Python
# I will use this to initially clean the data, then will review the table structure through SQL, and will add any additional cleaning needed

# Load data files
df_users = pd.read_csv('/Users/amandafowler/Documents/VSCode/Takehome_CSV_files/USER_TAKEHOME.csv')
df_transactions = pd.read_csv('/Users/amandafowler/Documents/VSCode/Takehome_CSV_files/TRANSACTION_TAKEHOME.csv')
df_products = pd.read_csv('/Users/amandafowler/Documents/VSCode/Takehome_CSV_files/PRODUCTS_TAKEHOME.csv')

# Initial data clean up, take away any leading spaces
df_users.columns = df_users.columns.str.strip()
df_transactions.columns = df_transactions.columns.str.strip()
df_products.columns = df_products.columns.str.strip()

# Create / connect to a SQLite database (this is the same for all three tables)
connection = sqlite3.connect('takehome.db')

# Load data files to SQLite
## set up to replace the table if it already exists - this will reflect any additional cleaning in the updated table
df_users.to_sql('users', connection, if_exists='replace')
df_transactions.to_sql('transactions', connection, if_exists='replace')
df_products.to_sql('products', connection, if_exists='replace')

# Close the connection
connection.close()