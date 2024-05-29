//
//  JournalEntry.swift
//  JRNL-SwiftUI
//
//  Created by SeongKook on 5/28/24.
//
import Foundation
import SwiftData
import UIKit

@Model
class JournalEntry {
    let date: Date
    let rating: Int
    let entryTitle: String
    let entryBody: String
    @Attribute(.externalStorage) let photoData: Data?
    let latitude: Double?
    let longitude: Double?

    init(rating: Int, entryTitle: String, entryBody: String, photo: UIImage?,
         latitude: Double?, longitude: Double?) {
        self.date = Date()
        self.rating = rating
        self.entryTitle = entryTitle
        self.entryBody = entryBody
        self.photoData = photo?.jpegData(compressionQuality: 1.0)
        self.latitude = latitude
        self.longitude = longitude
    }
}
