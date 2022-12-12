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
    
    var body: some View{
        VStack{
            Text("10 day forecast")
                .font(.caption)
            ForEach(dayWeatherList, id: \.date) { dailyWeather in
                HStack{
                    HStack{
                        Text(dailyWeather.date.formatAsAbbDay())
                        Image(systemName: "\(dailyWeather.symbolName)")
                            .foregroundColor(.black)
                    } .frame(width: 100)
                    HStack{
                        Text(dailyWeather.lowTemperature.formatted())
                            .frame(maxWidth: .infinity)
                    
                        Text(dailyWeather.highTemperature.formatted())
                            .frame(maxWidth: .infinity)
                    }.background(RoundedRectangle(cornerRadius: 10)
                        .foregroundColor(.teal).padding(EdgeInsets(top: -2, leading: 0, bottom: -2, trailing: 0)))
                    .padding(EdgeInsets(top: 1, leading: 0, bottom: 0, trailing: 10))
                        
                }
            }
        }
    }
}
extension Date {
    func formatAsAbbDay() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEE"
        return formatter.string(from: self)
    }
    func formatAsAbbTime() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "ha"
        return formatter.string(from: self)
    }
}


