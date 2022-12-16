//
//  precipHourView.swift
//  workingWithWeatherKit
//
//  Created by Maverick Brazill on 12/14/22.
//

import SwiftUI
import WeatherKit

struct precipHourView: View {
    let minuteWeatherList: [MinuteWeather]
    
    var body: some View {
        VStack{
            ForEach(minuteWeatherList, id: \.date){
                minuteWeatherItem in
                VStack{
                    Text(minuteWeatherItem.precipitationChance.formatted())
                }
            }
        }
    }
}


