//
//  JournalListView.swift
//  JRNL-SwiftUI
//
//  Created by SeongKook on 5/28/24.
//

import SwiftUI
import SwiftData

struct JournalListView: View {
    @State private var searchText = ""
    
    @State private var isShowAddJournalView = false
    
    @Query(sort:\JournalEntry.date) var journalEntries: [JournalEntry]
    
    var filteredJournalEntries: [JournalEntry] {
        if searchText.isEmpty {
            return journalEntries
        } else {
            let lowercasedSearchText = searchText.lowercased()
            return journalEntries.filter { $0.entryTitle.lowercased().contains(lowercasedSearchText) }
        }
    }
    
    var body: some View {
        NavigationStack {
            List(filteredJournalEntries) { journalEntry in
                NavigationLink(value: journalEntry) {
                    JournalCell(journalEntry: journalEntry)
                }
                .navigationDestination(for: JournalEntry.self) {
                    journalEntry in
                    JournalEntryDetailView(journalEntry: journalEntry)
                }
            }
            .navigationTitle("Journal List")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Add", systemImage: "plus") {
                        isShowAddJournalView = true
                    }
                }
            }
            .sheet(isPresented: $isShowAddJournalView) {
                AddJournalEntryView()
            }
            .searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .always))
        }
    }
}

#Preview {
    JournalListView()
        .modelContainer(for: JournalEntry.self, inMemory: true)
}
