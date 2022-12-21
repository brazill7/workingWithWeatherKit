//
//  minuteWeatherPrecip.swift
//  workingWithWeatherKit
//
//  Created by Maverick Brazill on 12/19/22.
//

import SwiftUI
import WeatherKit
import Charts




struct MinuteWeatherPrecip: View {
    let minuteForecast: [MinuteWeather]
    let checkForRain: [HourWeather]
    let dayWeatherList: [DayWeather]
    
    var body: some View {
        VStack{
            ForEach(checkForRain, id: \.date) { hourWeatherItem in
                VStack{
                    if hourWeatherItem.precipitationAmount.formatted() == "0 in" {
                        Text("10 Day Precipitation Chance")
                        Chart{
                            ForEach(dayWeatherList, id: \.date) { dailyWeather in
                                LineMark(x: .value("Date", dailyWeather.date, unit: .hour) , y: .value("% of Rain", dailyWeather.precipitationChance))
                                
                            }
                        }.foregroundColor(primaryColor())
                    } else {
                        Text("Precipitation for the hour (in/hr)")
                        Chart{
                            ForEach(minuteForecast, id: \.date) { minuteDataItem in
                                if minuteDataItem.precipitation.rawValue != "none" {
                                    LineMark(x:.value("Hour and Minute", minuteDataItem.date, unit: .minute) ,
                                             y: .value("Rain in MpH", minuteDataItem.precipitationIntensity.converted(to: .inchPerHour).value))
                                }
//                                RuleMark(y: .value("Annotation", 0.5))
//                                    .foregroundStyle(.black)
//                                    .lineStyle(StrokeStyle(lineWidth: 1, dash: [5]))
//                                    .annotation(alignment: .trailingLastTextBaseline ) {
//                                        Text("Testadadasdadasdax")
//                                            .font(.caption)
//                                            .foregroundColor(.black)
//                                    }
                                
                            }
                        } .chartXAxis(.visible) .chartYAxis(.visible)
                    }
                }
            }
                
            }
        }
        
            
        
            
//            VStack{
//                ForEach(minuteForecast, id: \.date){ minuteDataItem in
//                    Text("\(minuteDataItem.precipitation.description)")
//                    Text("\(minuteDataItem.precipitationChance.formatted())")
//                    Text("\(minuteDataItem.precipitationIntensity.converted(to: .inchPerHour).value)")
//
//                }
//
//            }
        }
    


extension UnitSpeed {
    static let inchPerHour = UnitSpeed(symbol: "in/hr", converter: UnitConverterLinear(coefficient: 1/28324.4544))
}
