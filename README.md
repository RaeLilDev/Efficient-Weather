# Efficient-Weather

### Our Goal
An iOS app to check current weather condition and forecast for next five days based on location choosen on map.

### Installation Guide
 - After cloning the repository you need to run the following command in terminal (in project directory). 
    - pod install
 
 - In the first time run with simulator, to get your location you need to set default location to MyLocation in EditScheme -> Options.
 - You can also change default location coordinate in Resources -> MyLocation.gpx file.

### What You Will See
- For the first time choose location using MapKit.
- After that, you can check current weather condition and forecast data in main screen.
- At the top-right corner of main screen, user can tap location button and change location.
- Offline cache functionality is used with Realm.
- User can select forecast detail data by tapping forecast day in main screen.
  
