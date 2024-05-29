//
//  JournalCell.swift
//  JRNL-SwiftUI
//
//  Created by SeongKook on 5/29/24.
//

import SwiftUI

struct JournalCell: View {
    var journalEntry: JournalEntry
    
    var body: some View {
        VStack {
            HStack {
                Image(uiImage: journalEntry.photo ?? UIImage(systemName: "face.smiling")!)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 90, height: 90)
                    .clipped()
                VStack {
                    Text(journalEntry.date.formatted(.dateTime.year().month().day()))
                        .font(.title)
                        .fontWeight(.bold)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Text(journalEntry.entryTitle)
                        .font(.title2)
                        .foregroundStyle(.secondary)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
            }
        }
    }
}

