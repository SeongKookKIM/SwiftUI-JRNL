//
//  AddJournalEntryView.swift
//  JRNL-SwiftUI
//
//  Created by SeongKook on 5/28/24.
//

import SwiftUI
import CoreLocation //위치정보

struct AddJournalEntryView: View {
    @Environment(\.dismiss) var dismiss
    @Environment(\.modelContext) var modelContext
    
    @State private var rating = 0
    @State private var isGetLocationOn = false
    @State private var locationLabel = "Get Location"
    @State private var currentLocation: CLLocation?
    @State private var entryTitle = ""
    @State private var entryBody = ""
    
    @StateObject private var locationManager = LocationManager()
    
    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("rating")) {
                    RatingView(rating: $rating)
                }
                Section(header: Text("Location")) {
                    Toggle(locationLabel, isOn: $isGetLocationOn)
                        .onChange(of: isGetLocationOn) {
                            if isGetLocationOn {
                                locationLabel = "Get Location..."
                                locationManager.requestLocation()
                            } else {
                                locationLabel = "Get Location"
                            }
                        }
                        .onReceive(locationManager.$location) { location in
                            if isGetLocationOn {
                                currentLocation = location
                                locationLabel = "Done"
                            }
                        }
                }
                Section(header: Text("Title")) {
                    TextField("Enter Title", text: $entryTitle)
                }
                Section(header: Text("Body")) {
                    TextEditor(text: $entryBody)
                }
                Section(header: Text("Photo")) {
                    Text("Photo")
                }
            }
            .navigationTitle("Add Journal Entry")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button("Cancle") {
                        dismiss()
                    }
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Save") {
                        let journalEntry = JournalEntry(rating: 3, entryTitle: entryTitle,
                                                        entryBody: entryBody, latitude: currentLocation?.coordinate.latitude, longitude: currentLocation?.coordinate.longitude)
                        modelContext.insert(journalEntry)
                        dismiss()
                    }
                }
            }
        }
    }
}

#Preview {
    AddJournalEntryView()
        .modelContainer(for: JournalEntry.self, inMemory: true)
}
