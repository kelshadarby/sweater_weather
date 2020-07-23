# Sweater Weather

Sweater Weather is a back-end API built in Rails. This API consumes weather and travel information, allowing the user to view a weather forecast by hour and by days of the week. This app also allows user to create an account, log in and create a trip allowing them to view trip duration and an arrival weather forecast.

## Getting Started

Clone this repo onto your local machine
Run the following commands in your terminal to get the code up and running on your local machine (make sure to run each of these without the $)

```
$ bundle
$ rake db:create
$ rake db:migrate
$ rake db:seed
```

### Prerequisites

What things you need to install the software and how to install them

```
Rails 5.2.4.3
Ruby 2.5.3
Bundler version 2.1.4

```

### Local Environment & Getting Responses

Follow the steps below to view the JSON repsonses this app gives

Step 1:
    Download the [Postman API Client](https://www.postman.com/product/api-client/)

Step 2:
    Start the local rails server by running the following command
```
$ rails s
```

Step 3:
    Write a request
    - Open Postman and enter a request similar to the following
    <img width="934" alt="Location Forecast Request" src="https://user-images.githubusercontent.com/55028065/88312997-2557db00-ccd0-11ea-948f-45ac253a2cf8.png">


#### Here are some more sample requests you can make using Postman

__Forecast for a Location__
```
POST '/api/v1/forecast'
Parameters:
  "location": "denver,co"
  
Response:
{
  "data": {
    "id": "1",
    "type": "forecast",
    "attributes": {
      "actual_temp": 83,
      "current_time_month_day": "11:03 AM, July 23",
      "feels_like": 83,
      "high_temp": 90,
      "hourly_weather_forecast": [
        {
          "time": "11 AM",
          "temp": 83,
          "description": "Clear Sky"
        },
        {
          "time": "12 PM",
          "temp": 85,
          "description": "Clear Sky"
        },
        {
          "time": " 1 PM",
          "temp": 88,
          "description": "Clear Sky"
        },
        {
          "time": " 2 PM",
          "temp": 91,
          "description": "Clear Sky"
        },
        {
          "time": " 3 PM",
          "temp": 92,
          "description": "Scattered Clouds"
        },
        {
          "time": " 4 PM",
          "temp": 91,
          "description": "Broken Clouds"
        },
        {
          "time": " 5 PM",
          "temp": 89,
          "description": "Broken Clouds"
        },
        {
          "time": " 6 PM",
          "temp": 89,
          "description": "Broken Clouds"
        }
      ],
      "humidity": "35%",
      "location_info": {
          "city": "Denver",
          "state": "Colorado",
          "country": "United States"
      },
      "low_temp": 78,
      "sunrise_time": " 5:51 AM",
      "sunset_time": " 8:21 PM",
      "uv_index": 10,
      "visibility": 10000,
      "weather_description": "Clear Sky",
      "week_weather_forecast": [
        {
          "day_of_week": "Thursday",
          "description": "Light Rain",
          "precipitation": "0 mm",
          "high_temp": 90.5,
          "low_temp": 78.75
        },
        {
          "day_of_week": "Friday",
          "description": "Moderate Rain",
          "precipitation": "6 mm",
          "high_temp": 87.91,
          "low_temp": 72.45
        },
        {
          "day_of_week": "Saturday",
          "description": "Broken Clouds",
          "precipitation": "0 mm",
          "high_temp": 91.02,
          "low_temp": 70.41
        },
        {
          "day_of_week": "Sunday",
          "description": "Overcast Clouds",
          "precipitation": "0 mm",
          "high_temp": 85.5,
          "low_temp": 74.16
        },
        {
          "day_of_week": "Monday",
          "description": "Light Rain",
          "precipitation": "0 mm",
          "high_temp": 92.28,
          "low_temp": 71.64
        },
        {
          "day_of_week": "Tuesday",
          "description": "Light Rain",
          "precipitation": "0 mm",
          "high_temp": 87.33,
          "low_temp": 73.56
        },
        {
          "day_of_week": "Wednesday",
          "description": "Clear Sky",
          "precipitation": "0 mm",
          "high_temp": 95.22,
          "low_temp": 72.79
        }
      ]
    }
  }
}
```

__User Creation__
```
POST '/api/v1/users'
Parameters:
  "email": "email@example.com",
  "password": "password",
  "password_confirmation": "password"
  
Response:
{
  "data": {
    "id": <ID number>
    "type": "users"
    "attributes": {
      "email": "email@example.com"
      "api_key": <Generated API key>
    }
  }
}
```

__Login__
```
POST '/api/v1/sessions'
paramaters:
  "email": "email@example.com",
  "password": "password"

Response:
{
  "data": {
    "id": <ID number>
    "type": "users"
    "attributes": {
      "email": "email@example.com"
      "api_key": <Generated API key>
    }
  }
}
```

__Arrival Forecast and Trip Duration__
```
GET '/api/v1/road_trip'
Paramaters:
  "origin": "Denver,CO",
  "destination": "Pueblo,CO",
  "api_key": <your API key, given after user creation>
  
Response:
{
  "data": {
    "id": "null"
    "type": "road_trip"
    "attributes": {
      "origin": "Denver,CO"
      "destination": "Pueblo,CO"
      "travel_time": "2hrs"
      "arrival_forecast": "74 degrees. Mostly sunny."
    }
  }
}
```

## Running the tests
__To run the entire test suite on your local machine run the following command__
```
$ rspec
```

Note: You may need to prepend this command with `bundle exec`


__To run a specific test file run the following command__

```
$ rspec <file_path>
```

Note: Your file path may look something like `spec/features/items/index_spec.rb`


__To run a specific test within a test file run the following command__
```
$ rspec <file_path>:<line_number>
```

Notes:
- Your line number should be the line of the beginning of the `it` block
- Example: `spec/features/items/index_spec.rb:15`

## Built Using

* [Rails](https://guides.rubyonrails.org/) - The web framework used

## API's Used
* [Open Weather API - Current Weather](https://openweathermap.org/current)
* [Open Weather API - One Call](https://openweathermap.org/api/one-call-api)
* [Google Geocoding API](https://developers.google.com/maps/documentation/geocoding/overview)
* [Google Directions API](https://developers.google.com/maps/documentation/directions/overview)

## Wireframes
### Forecast
![Forecast](https://user-images.githubusercontent.com/55028065/88316575-4b33ae80-ccd5-11ea-9cc6-de7c9ebc4fce.png)

### User Registration
![sweater_weather_sign_up](https://user-images.githubusercontent.com/55028065/88316581-4cfd7200-ccd5-11ea-9f5f-66d77c5e21d5.png)

### User Login
![sweater_weather_login](https://user-images.githubusercontent.com/55028065/88316589-5090f900-ccd5-11ea-876e-30727c505364.png)

### Road Trip Information
![sweater_weather_road_trip](https://user-images.githubusercontent.com/55028065/88316597-52f35300-ccd5-11ea-8d55-261a12581d9d.png)

