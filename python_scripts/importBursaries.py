import csv
import requests

# Supabase credentials
supabase_url = "https://aistpwwncfmkrhwyeuat.supabase.co"
supabase_key = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImFpc3Rwd3duY2Zta3Jod3lldWF0Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3MjUzNjk1NzQsImV4cCI6MjA0MDk0NTU3NH0.zdX5DF-DM2BFyXRgv2B2OmlQRj8k1nh9HpCtcvEuQS0"
table_name = "scholarships"

headers = {
    "apikey": supabase_key,
    "Authorization": f"Bearer {supabase_key}",
    "Content-Type": "application/json",
    "Prefer": "return=minimal"
}

# Path to your CSV file
csv_file_path = "bursaries.csv"

# Function to upload CSV data
def upload_csv_to_supabase():
    with open(csv_file_path, newline='', encoding='utf-8') as csvfile:
        reader = csv.DictReader(csvfile)
        for row in reader:
            # Make POST request to Supabase API for each row
            response = requests.post(
                f"{supabase_url}/{table_name}",
                json=row,
                headers=headers
            )
            
            if response.status_code != 201:
                print(f"Failed to insert row: {row}")
            else:
                print(f"Inserted row: {row}")

# Call the function to upload the CSV
upload_csv_to_supabase()
