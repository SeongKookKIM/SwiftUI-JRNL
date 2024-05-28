//
//  AddJournalEntryView.swift
//  JRNL-SwiftUI
//
//  Created by SeongKook on 5/28/24.
//

import SwiftUI


struct AddJournalEntryView: View {
    @Environment(\.dismiss) var dismiss
    @Environment(\.modelContext) var modelContext
    
    @State private var isGetLocationOn = false
    @State private var entryTitle = ""
    @State private var entryBody = ""
    
    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("rating")) {
                    Rectangle()
                        .foregroundColor(.brown)
                }
                Section(header: Text("Location")) {
                    Toggle("Get Location", isOn: $isGetLocationOn)
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
                                                            entryBody: entryBody, latitude: nil, longitude: nil)
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
