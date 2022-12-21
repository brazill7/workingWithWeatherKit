//
//  tenDayForecastView.swift
//  workingWithWeatherKit
//
//  Created by Maverick Brazill on 12/13/22.
//

import SwiftUI
import WeatherKit

struct TenDayForecastView: View{
    let dayWeatherList: [DayWeather]
    let lightBlue = Color(red: 41, green: 255, blue: 239)
    var body: some View{
        VStack(alignment: .leading){
            Text("10 day forecast")
                .font(.caption)
                .underline(pattern: .solid)
            ForEach(dayWeatherList, id: \.date) { dailyWeather in
                HStack{
                    VStack(alignment: .trailing){
                        HStack{
                            Text(dailyWeather.date.formatAsAbbDay())
                                .frame(alignment: .trailing)
                                .underline()
                            Spacer()
                            Image(systemName: "\(dailyWeather.symbolName)")
                                .foregroundColor(primaryColor())
                            //Spacer()
                        }
                        HStack{
                            //Text(dailyWeather.precipitation.rawValue)
                            //Text(dailyWeather.rainfallAmount.formatted())
                            //Text("proj: \(dailyWeather.snowfallAmount.formatted())")
                              //  .font(.caption)
                            Text(dailyWeather.precipitationChance.formatted(.percent))
                                .font(.caption)
                                .padding(EdgeInsets(top: 0, leading: -5, bottom: 0, trailing: -3))
                            
                        }
                        
                    } .frame(width: 100)
                    HStack{
                        Text(dailyWeather.lowTemperature.formatted())
                            .frame(maxWidth: .infinity)
                    
                        Text(dailyWeather.highTemperature.formatted())
                            .frame(maxWidth: .infinity)
                    }
                    .background(LinearGradient(colors: [.mint,.orange], startPoint: .topLeading, endPoint: .bottomTrailing))
                        .padding(EdgeInsets(top: -2, leading: 0, bottom: -2, trailing: 0))
                    .padding(EdgeInsets(top: 1, leading: 10, bottom: 0, trailing: 10))
                        
                }
            }
        }
    }
}



