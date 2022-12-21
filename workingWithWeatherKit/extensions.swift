//
//  extensions.swift
//  workingWithWeatherKit
//
//  Created by Maverick Brazill on 12/20/22.
//

import Foundation


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
    func formatAsAbbHour() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "Hm"
        return formatter.string(from: self)
    }
    func formatAsSingleNumberHour() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "h"
        return formatter.string(from: self)
    }
}



