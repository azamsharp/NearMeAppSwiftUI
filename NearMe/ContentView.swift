//
//  ContentView.swift
//  NearMe
//
//  Created by Mohammad Azam on 5/5/21.
//

import SwiftUI
import MapKit

enum DisplayType {
    case map
    case list
}

struct ContentView: View {
    
    @StateObject private var placeListVM = PlaceListViewModel()
    @State private var userTrackingMode: MapUserTrackingMode = .follow
    @State private var searchTerm: String = ""
    @State private var displayType: DisplayType = .map
    @State private var isDragged: Bool = false
    
    private func getRegion() -> Binding<MKCoordinateRegion> {
        
        guard let coordinate = placeListVM.currentLocation else {
            return .constant(MKCoordinateRegion.defaultRegion)
        }
        
        return .constant(MKCoordinateRegion(center: coordinate, span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)))
        
    }
    
    var body: some View {
        VStack {
            
            TextField("Search", text: $searchTerm, onEditingChanged: { _ in
                
            }, onCommit: {
                    // get all landmarks
                placeListVM.searchLandmarks(searchTerm: searchTerm)
                
            }).textFieldStyle(RoundedBorderTextFieldStyle())
            
            LandmarkCategoryView { (category) in
                placeListVM.searchLandmarks(searchTerm: category)
            }
            
            Picker("Select", selection: $displayType) {
                Text("Map").tag(DisplayType.map)
                Text("List").tag(DisplayType.list)
            }.pickerStyle(SegmentedPickerStyle())
            
            if displayType == .map {
                
                Map(coordinateRegion: getRegion(), interactionModes: .all, showsUserLocation: true, userTrackingMode: $userTrackingMode, annotationItems: placeListVM.landmarks) { landmark in
                    MapMarker(coordinate: landmark.coordinate)
                }
                .gesture(DragGesture()
                            .onChanged({ (value) in
                                isDragged = true
                            })
                ).overlay(isDragged ? AnyView(RecenterButton {
                    placeListVM.startUpdatingLocation()
                    isDragged = false 
                }.padding()): AnyView(EmptyView()), alignment: .bottom)
                
                
            } else if displayType == .list {
                LandmarkListView(landmarks: placeListVM.landmarks)
            }
            
        }.padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
