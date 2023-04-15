import requests
api_key = 'd92bda7a25e6494591e164815231404'


def realtime(lat, lon):

    # api_key = 'd92bda7a25e6494591e164815231404'
    # lat = 37.7749
    # lon = -122.4194
    url = f'https://api.weatherapi.com/v1/current.json?key={api_key}&q={lat},{lon}'

    response = requests.get(url)
    data = response.json()

    location = data['location']['name']
    country = data['location']['country']
    temp_c = data['current']['temp_c']
    description = data['current']['condition']['text']

    print(f"Current weather in {location}, {country}: {temp_c}°C, {description}")

    return data

def forecast(lat, lon, day):
    import requests

    # API_KEY = "your_api_key_here"
    # latitude = 40.7128
    # longitude = -74.0060
    url = f"https://api.weatherapi.com/v1/forecast.json?key={api_key}&q={lat},{lon}&days={day}"

    response = requests.get(url)
    data = response.json()

    print(data)
    return data

    