//
//  AddJournalEntryView.swift
//  JRNL-SwiftUI
//
//  Created by SeongKook on 5/28/24.
//

import SwiftUI

struct AddJournalEntryView: View {
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationStack {
            Text("Add Journal")
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
                            dismiss()
                        }
                    }
                }
        }
    }
}

#Preview {
    AddJournalEntryView()
}
