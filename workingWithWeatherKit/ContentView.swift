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
    @State private var timeRemaining = 10
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    @StateObject private var locationManager = LocationManager()
    let weatherSerice = WeatherService.shared
    @State private var weather: Weather?
    @State private var precip: Precipitation?
    @State var refreshView: Bool = false
    
    

    private func getWeatherAsync() async {
        do{
            //if let location = locationManager.currentLocation{
            let location = CLLocation(latitude: 42.3314, longitude: -83.0458)
            self.weather = try await weatherSerice.weather(for: location)
            //}
        } catch {
            print(error)
        }
    }
    
    private func getWeatherDataRegular() {
        Task{
            await getWeatherAsync()
        }
    }
//    var minuteWeather: [MinuteWeather] {
//        if let weather {
//            Array(weather.minuteForecast.filter { minuteWeather in
//                return minuteWeather.date.timeIntervalSince(Date()) >= 0
//            }.prefix(60))
//        } else {
//            return []
//        }
//    }
    
    //used in the 24 hour forecast view
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
    //for use of the top part of the weatherview (no rain/snow for THE HOUR)
    var hourWeatherData: [HourWeather] {
        if let weather {
            return Array(weather.hourlyForecast.filter { hourlyWeather in
                return hourlyWeather.date.timeIntervalSince(Date()) >= 0
            }.prefix(1))
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
                                if let location = locationManager.currentLocation{
                                    NavigationLink(destination: locationView(currentLocation: location)) {
                                        Image(systemName: "location")
                                    }
                                }
                                Text("Weather Data as of: \(weather.currentWeather.date.formatted(date: .abbreviated, time: .shortened))")
                                    .font(.footnote)
                                Button{
                                    getWeatherDataRegular()
                                } label: {
                                    Image(systemName: "arrow.clockwise")
                                        .resizable()
                                        .frame(width: 12, height: 12)
                                        
                                }
                            }
                            
                            //Text("Current / Upcoming Weather at your Location")
                            Text("Current Temp: \(weather.currentWeather.temperature.formatted())")
                            Text("Feels Like: \(weather.currentWeather.apparentTemperature.formatted())")
                            Text("\(weather.currentWeather.condition.description)")
                            
                            ForEach(hourWeatherData, id: \.date) { hourWeatherItem in
                                VStack{
                                    if hourWeatherItem.precipitationAmount.formatted() == "0 in" {
                                        Text("No rain/snow for the hour")
                                    }else {
                                        Text(" Precipitation for the hour: \(hourWeatherItem.precipitationAmount.formatted())")
                                        }
                                    }
                            }
                            
                            
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
                            .padding(EdgeInsets(top: 350, leading: 0, bottom: 25, trailing: 0))
                        
                        //Text("\(timeRemaining)")
                        if timeRemaining < 8 {
                            Text("Loading Weather Data")
                        }
                        if timeRemaining == 0{
                            Text("This is taking a while, make you you have a stable internet connection and have Location Services enabled for this app in the settings")
                                .multilineTextAlignment(.center)
                                .padding()
                        }
                    }
                }.task(id: locationManager.currentLocation) {
                    do{
                        //if let location = locationManager.currentLocation{
                        let location = CLLocation(latitude: 42.3314, longitude: -83.0458)
                        self.weather = try await weatherSerice.weather(for: location)
                        //}
                    } catch {
                        print(error)
                    }
                    
                }
            }
        }.onReceive(timer) { time in
            if timeRemaining > 0 {
                timeRemaining -= 1
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
