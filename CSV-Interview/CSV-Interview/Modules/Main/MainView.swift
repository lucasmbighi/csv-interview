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
        NavigationStack {
            Group {
                if viewModel.isLoading {
                    loadingView
                } else if let headers = viewModel.getCSVHeaders {
                    csvView(headers, rows: viewModel.getCSVData)
                } else {
                    emptyView
                }
            }
            .alert("Error loading CSV file",
                   isPresented: .constant(viewModel.errorMessage != nil),
                   presenting: viewModel.errorMessage,
                   actions: { _ in },
                   message: { errorMessage in
                Text(
                    errorMessage
                )
            })
            .onChange(of: viewModel.isShowingFileSelector, { _, newValue in
                viewModel.onFileSelectorChange(newValue)
            })
            .navigationTitle("CSV Reader")
            .toolbar {
                Button(action: viewModel.showFileSelector) {
                    Image(systemName: "plus")
                }
            }
            .fileImporter(
                isPresented: $viewModel.isShowingFileSelector,
                allowedContentTypes: [.commaSeparatedText],
                onCompletion: viewModel.onChooseFile
            )
        }
    }
    
    private var loadingView: some View {
        VStack {
            Text("Loading CSV file...")
            ProgressView()
        }
    }
    
    private var emptyView: some View {
        VStack {
            Text("Welcome to CSV Reader")
                .font(.title)
            
            Text("Start selecting a file tapping the \"+\" button")
        }
    }
    
    private func csvView(_ headers: [String], rows: [[String]]) -> some View {
        ScrollView {
            let columns = headers.map { _ in
                GridItem(.flexible(), alignment: .center)
            }
            
            LazyVGrid(columns: columns, spacing: .zero, pinnedViews: [.sectionHeaders]) {
                Section {
                    ForEach(rows, id: \.self) { row in
                        ForEach(row, id: \.self) { cell in
                            Text(cell)
                                .foregroundStyle(.black)
                                .frame(maxWidth: .infinity, maxHeight: .infinity)
                                .background(viewModel.isEven(row) ? .gray.opacity(0.3) : .white)
                                .id(UUID())
                        }
                    }
                } header: {
                    HStack(alignment: .center) {
                        ForEach(headers, id: \.self) { header in
                            Text(header)
                                .frame(maxWidth: .infinity, maxHeight: .infinity)
                                .font(.headline)
                                .foregroundStyle(.white)
                                .padding(8)
                                .background(.blue.opacity(0.8))
                                .id(UUID())
                        }
                    }
                }
            }
        }
        .padding()
    }
}

#Preview {
    let mockCSV = [
        ["First name","Sur name","Issue count","Date of birth"],
        ["Theo","Jansen","5","1978-01-02T00:00:00"],
        ["Fiona","de Vries","7","1950-11-12T00:00:00"],
        ["Petra","Boersma","1","2001-04-20T00:00:00"],
    ]
    
    return MainView(
        viewModel: MainViewModel(
            csvData: mockCSV
        )
    )
}
