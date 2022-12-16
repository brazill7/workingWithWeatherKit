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
            Text("24-Hour Forecast")
                .font(.caption)
                .underline(pattern: .solid)
                .padding()
            ScrollView(.horizontal){
                
                HStack{
                    ForEach(hourWeatherList, id: \.date) { hourWeatherItem in
                        VStack(spacing: 15) {
                            Text(hourWeatherItem.date.formatAsAbbTime())
                                .foregroundColor(.white)
                            Image(systemName: "\(hourWeatherItem.symbolName)")
                                .foregroundColor(.white)
                            Text(hourWeatherItem.temperature.formatted())
                                .fontWeight(.semibold)
                                .foregroundColor(.white)
                            Text(hourWeatherItem.cloudCover.formatted(.percent))
                                .foregroundColor(.gray)
                            Text(hourWeatherItem.precipitationAmount.formatted())
                                .foregroundColor(.gray)
                            //Text(hourWeatherItem.precipitation.rawValue)
                        }//.padding()
                    }
                }
            } .background(RoundedRectangle(cornerRadius: 10)
                .foregroundColor(primaryColor())
              .padding(EdgeInsets(top: -10, leading: -10, bottom: -10, trailing: -10)))
                
        }
    }
}

