//
//  JRNL_SwiftUIApp.swift
//  JRNL-SwiftUI
//
//  Created by SeongKook on 5/28/24.
//

import SwiftUI

@main
struct JRNL_SwiftUIApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: JournalEntry.self)
    }
}
