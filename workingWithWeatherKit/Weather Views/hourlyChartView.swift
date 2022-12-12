//
//  hourlyChartView.swift
//  workingWithWeatherKit
//
//  Created by Maverick Brazill on 12/13/22.
//

import SwiftUI
import WeatherKit
import Charts

struct HourlyChartView: View{
    let hourlyWeatherData: [HourWeather]
    var body: some View{
        Chart {
            ForEach(hourlyWeatherData.prefix(10), id: \.date) {hourlyWeather in
                LineMark(x: .value("Hour", hourlyWeather.date.formatAsAbbTime()), y: .value("Temp", hourlyWeather.temperature.converted(to: .fahrenheit).value))
            }
        }
    }
}


