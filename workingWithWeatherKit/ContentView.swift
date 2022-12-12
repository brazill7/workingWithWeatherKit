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
        ScrollView{
            VStack {
                if let weather = weather{
                    
                    VStack{
                        Text("Current Weather at your Location")
                        Text("\(weather.currentWeather.temperature.formatted())")
                    }
                    HourlyForecastView(hourWeatherList: hourlyWeatherData)
                    HourlyChartView(hourlyWeatherData: hourlyWeatherData)
                    //Spacer()
                    
                    TenDayForecastView(dayWeatherList: weather.dailyForecast.forecast)
                    
                    
                } else {
                    ProgressView()
                    Text("Loading Weather Data, if this takes a while, make sure location services are enabled on this app in the settings.")
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

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
