//
//  CSV_InterviewApp.swift
//  CSV-Interview
//
//  Created by Lucas Bighi on 18/01/25.
//

import SwiftUI

@main
struct CSV_InterviewApp: App {
    var body: some Scene {
        WindowGroup {
            MainView(viewModel: MainViewModel())
        }
    }
}
