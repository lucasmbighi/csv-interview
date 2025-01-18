//
//  MainView.swift
//  CSV-Interview
//
//  Created by Lucas Bighi on 18/01/25.
//

import SwiftUI

struct MainView: View {
    
    @StateObject var viewModel: MainViewModel
    
    var body: some View {
        Text("Hello, World!")
    }
}

#Preview {
    MainView(viewModel: MainViewModel())
}
