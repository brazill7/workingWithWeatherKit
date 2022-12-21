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
        VStack(alignment: .leading){
            Text("24 Hour Temperature Forecast Graph")
                .font(.caption)
                .underline(pattern: .solid)
            ZStack{
                Chart {
                    ForEach(hourlyWeatherData.prefix(24), id: \.date) {hourlyWeather in
                        AreaMark(x: .value("Hour", hourlyWeather.date, unit: .hour), y: .value("Temp", hourlyWeather.temperature.converted(to: .fahrenheit).value))
                            .foregroundStyle(secondaryColor().opacity(0.4))
                            //.alignsMarkStylesWithPlotArea()
                            

                    }
                }.chartXAxis(.hidden)
                    .chartYAxisLabel("test")
                Chart {
                    ForEach(hourlyWeatherData.prefix(24), id: \.date) {hourlyWeather in
                        LineMark(x: .value("Hour", hourlyWeather.date, unit: .hour), y: .value("Temp", hourlyWeather.temperature.converted(to: .fahrenheit).value))
                            .foregroundStyle(primaryColor())
                    }
                }.chartXAxis(.hidden)
                    .chartYAxisLabel("test")
            }
        }
    }
}



