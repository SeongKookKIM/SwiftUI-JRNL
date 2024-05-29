//
//  MapView.swift
//  JRNL-SwiftUI
//
//  Created by SeongKook on 5/28/24.
//

import SwiftUI
import MapKit
import CoreLocation
import SwiftData

struct MapUIView: UIViewRepresentable {
    @Binding var region: MKCoordinateRegion
    @Binding var annotations: [MKAnnotation]
    @Binding var isDetailViewActive: Bool
    
    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView()
        mapView.delegate = context.coordinator
        return mapView
    }
    
    func updateUIView(_ uiView: MKMapView, context: Context) {
        uiView.setRegion(region, animated: true)
        uiView.addAnnotations(annotations)
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, MKMapViewDelegate {
        var parent: MapUIView
        
        init(_ parent: MapUIView) {
            self.parent = parent
        }
        
        func mapView(_ mapView: MKMapView, viewFor annotation: any MKAnnotation) -> MKAnnotationView? {
            let identifier = "mapAnnotation"
            if annotation is JournalMapAnnotation {
                if let annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) {
                    annotationView.annotation = annotation
                    return annotationView
                } else {
                    let annotationView = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: identifier)
                    annotationView.canShowCallout = true
                    let calloutButton = UIButton(type: .detailDisclosure)
                    annotationView.rightCalloutAccessoryView = calloutButton
                    return annotationView
                }
            }
            return nil
        }
        
        func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
            if let journalAnnotation = view.annotation as? JournalMapAnnotation {
                print(journalAnnotation.journal.entryTitle)
                
                
            }
        }
    
    }
}


struct MapView: View {
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 37.7749, longitude: -122.4194),
        span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
    )
    @State private var annotations: [MKAnnotation] = []
    @State private var isDetailViewActive = false
    
    @StateObject private var locationManager = LocationManager()
    @Query(sort: \JournalEntry.date) var journalEntries: [JournalEntry]
    
    var body: some View {
        NavigationStack {
            MapUIView(region: $region, annotations: $annotations,
                      isDetailViewActive: $isDetailViewActive)
                .onAppear {
                    locationManager.requestLocation()
                }
                .onReceive(locationManager.$location) { location in
                    if let location = location {
                        region = MKCoordinateRegion(center: location.coordinate,
                                                    span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
                        annotations = journalEntries.map { JournalMapAnnotation(journal: $0) }
                    }
                }
                .navigationTitle("Map")
                .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    MapView()
}
