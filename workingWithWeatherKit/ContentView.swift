//
//  ContentView.swift
//  workingWithWeatherKit
//
//  Created by Maverick Brazill on 12/12/22.
//

import SwiftUI
import CoreLocation
import WeatherKit
import Charts


struct ContentView: View {
    @StateObject private var locationManager = LocationManager()
    let weatherSerice = WeatherService.shared
    @State private var weather: Weather?
    @State private var precip: Precipitation?
    
//    var minuteWeather: [MinuteWeather] {
//        if let weather {
//            Array(weather.minuteForecast.filter { minuteWeather in
//                return minuteWeather.date.timeIntervalSince(Date()) >= 0
//            }.prefix(60))
//        } else {
//            return []
//        }
//    }
    
    var hourlyWeatherData: [HourWeather] {
        if let weather {
            return Array(weather.hourlyForecast.filter { hourlyWeather in
                return hourlyWeather.date.timeIntervalSince(Date()) >= 0
            }.prefix(24))
            //prefix is hour many hours you want to display
        } else {
            return []
        }
    }
    
    
    
    var body: some View {
        NavigationView {
            ScrollView{
                VStack {
                    if let weather = weather{
                        VStack{
                            //current weather data
                            HStack {
                                Text("\(weather.currentWeather.date.formatted())")
                                if let location = locationManager.currentLocation{
                                    NavigationLink(destination: locationView(bruh: location)) {
                                        Image(systemName: "location")
                                    }
                                }
                            }
                            
                            //Text("Current / Upcoming Weather at your Location")
                            Text("Current Temp: \(weather.currentWeather.temperature.formatted())")
                            Text("Feels Like: \(weather.currentWeather.apparentTemperature.formatted())")
                            Text("\(weather.currentWeather.condition.description)")
                            
                            
                        }
                        HourlyForecastView(hourWeatherList: hourlyWeatherData)
                            .padding()
                        HourlyChartView(hourlyWeatherData: hourlyWeatherData)
                            .padding()
                        //Spacer()
                        
                        TenDayForecastView(dayWeatherList: weather.dailyForecast.forecast)
                            .padding()
                       // precipHourView(minuteWeatherList: minuteWeather)
                        
                        
                    } else {
                        ProgressView()
                        Text("Loading Weather Data ,this may take a while,\n if it never loads, make sure location services are enabled on this app in the settings.")
                            .multilineTextAlignment(.center)
                    }
                }.task(id: locationManager.currentLocation) {
                    do{
                        //if let location = locationManager.currentLocation{
                        let location = CLLocation(latitude: 42.3314, longitude: 83.0458)
                        self.weather = try await weatherSerice.weather(for: location)
                        //}
                    } catch {
                        print(error)
                    }
                    
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
