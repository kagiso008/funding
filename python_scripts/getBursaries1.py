import requests
from bs4 import BeautifulSoup
import csv

# URL to scrape
url = 'https://studytrust.org.za/bursaries/'

# Send a GET request to the URL
response = requests.get(url)

# Check if the request was successful
if response.status_code == 200:
    # Parse the HTML content
    soup = BeautifulSoup(response.text, 'html.parser')
    
    # Extract headings and URLs (adjust selectors as needed)
    # Example: Extracting all text from <h3> tags and URLs from <a> tags
    headings = soup.find_all('h3')  # Example tag for headings
    links = soup.find_all('a')  # Example tag for links
    
    # Open a CSV file for writing
    with open('bursaries.csv', 'w', newline='', encoding='utf-8') as csvfile:
        csvwriter = csv.writer(csvfile)
        
        # Write a header row
        csvwriter.writerow(['scholarsship', 'scholarship_url'])
        
        # Write each heading and URL
        for heading in headings:
            heading_text = heading.get_text(strip=True)
            # Find the first link within each heading, if applicable
            link = heading.find('a')
            link_url = link['href'] if link else ''
            csvwriter.writerow([heading_text, link_url])
    
    print("Data has been written to bursaries.csv")
else:
    print(f"Failed to retrieve the webpage. Status code: {response.status_code}")
