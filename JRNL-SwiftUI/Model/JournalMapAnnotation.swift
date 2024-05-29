//
//  JournalMapAnnotation.swift
//  JRNL-SwiftUI
//
//  Created by SeongKook on 5/29/24.
//

import Foundation
import MapKit
import CoreLocation

class JournalMapAnnotation: NSObject, MKAnnotation {
    let dateString: String
    let entryTitle: String
    let latitude: Double
    let longitude: Double
    let journal: JournalEntry
    
    init(journal: JournalEntry) {
        self.dateString = journal.date.formatted(.dateTime.year().month().day())
        self.entryTitle = journal.entryTitle
        self.latitude = journal.latitude ?? 0
        self.longitude = journal.longitude ?? 0
        self.journal = journal
    }
    
    var coordinate: CLLocationCoordinate2D {
        return CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
    
    var title: String? {
        dateString
    }
    
    var subtitle: String? {
        entryTitle
    }
}
