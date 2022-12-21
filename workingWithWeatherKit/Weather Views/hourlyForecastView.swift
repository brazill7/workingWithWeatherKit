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
            VStack(alignment: .leading){
                HStack {
                    Text("24-Hour Forecast")
                        .font(.caption)
                        .underline(pattern: .solid)
                    .padding()
//                    NavigationLink(destination: dayForecastPicker()){
//                            Text("Choose Shown Info")
//                            .background(RoundedRectangle(cornerRadius: 10)
//                                .foregroundColor(.black)
//                                .padding(EdgeInsets(top: -5, leading: -5, bottom: -5, trailing: -5)))
//
//                    }
                }
                ScrollView(.horizontal){
                    
                    HStack{
                        ForEach(hourWeatherList, id: \.date) { hourWeatherItem in
                            VStack(spacing: 10) {
                                Text(hourWeatherItem.date.formatAsAbbTime())
                                    .foregroundColor(.white)
                                    .fontWeight(.bold)
                                    .frame(alignment: .top)
                                Image(systemName: "\(hourWeatherItem.symbolName)")
                                    .foregroundColor(.white)
                                Text("\(hourWeatherItem.temperature.formatted())")
                                    .fontWeight(.semibold)
                                    .foregroundColor(.white)
                                Text(hourWeatherItem.apparentTemperature.formatted())
                                    .foregroundColor(.white)
                                Text("\(Image(systemName: "cloud")): \(hourWeatherItem.cloudCover.formatted(.percent))")
                                    .foregroundColor(.gray)
                                Text("\(Image(systemName: "wind"))\(hourWeatherItem.wind.speed.formatted())")
                                    .foregroundColor(.cyan)
                                Text("\(Image(systemName: "sun.min"))\(hourWeatherItem.uvIndex.value.formatted())")
                                    .foregroundColor(.green)
                            
                                //Text(hourWeatherItem.precipitation.rawValue)
                            }.frame(width: 90, height: 200, alignment: .top)
                            LinearGradient(colors: [.white, .gray], startPoint: .top, endPoint: .bottom)
                                .frame(width:1, height: 200)
                                
                        }
                    }
                } .background(RoundedRectangle(cornerRadius: 10)
                    .foregroundColor(primaryColor())
                  .padding(EdgeInsets(top: -10, leading: -10, bottom: -10, trailing: -10)))
                
            }
    }
}

