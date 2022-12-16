//
//  locationView.swift
//  workingWithWeatherKit
//
//  Created by Maverick Brazill on 12/14/22.
//

import SwiftUI
import MapKit
import CoreLocation

struct locationView: View {
    @State var bruh: CLLocation
    
 
    
    var body: some View {
        Text("Your Current Location")
        Text("Lat: \(self.bruh.coordinate.latitude)")
        Text("Long: \(self.bruh.coordinate.longitude)")
        
    }
}


