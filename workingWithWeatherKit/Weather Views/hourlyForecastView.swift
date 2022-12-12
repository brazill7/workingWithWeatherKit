//
//  hourlyForecastView.swift
//  workingWithWeatherKit
//
//  Created by Maverick Brazill on 12/13/22.
//

import SwiftUI
import WeatherKit

struct HourlyForecastView: View {
    let hourWeatherList: [HourWeather]
    var body: some View{
        VStack{
            Text("Hourly Forecast")
                .font(.caption)
            ScrollView(.horizontal){
                HStack{
                    ForEach(hourWeatherList, id: \.date) { hourWeatherItem in
                        VStack(spacing: 15) {
                            Text(hourWeatherItem.date.formatAsAbbTime())
                            Image(systemName: "\(hourWeatherItem.symbolName).fill")
                            Text(hourWeatherItem.temperature.formatted())
                                .fontWeight(.semibold)
    
                        }.padding()
                    }
                }
            }
        }
    }
}

