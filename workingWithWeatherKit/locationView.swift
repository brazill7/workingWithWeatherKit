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
    @State var currentLocation: CLLocation
    //@State private var lat = currentLocation.coordinate.latitude 
    
    var body: some View {
        Text("Your Current Location")
        Text("Lat: \(self.currentLocation.coordinate.latitude)")
        Text("Long: \(self.currentLocation.coordinate.longitude)")
        
        //Map
        //MapMarker(coordinate: CLLocationCoordinate2D(latitude: self.currentLocation.coordinate.latitude, longitude: self.currentLocation.coordinate.longitude))
    }
    
}


