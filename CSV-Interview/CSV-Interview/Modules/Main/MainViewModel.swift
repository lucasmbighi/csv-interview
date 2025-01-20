//
//  MainViewModel.swift
//  CSV-Interview
//
//  Created by Lucas Bighi on 18/01/25.
//

import Foundation

final class MainViewModel: ObservableObject {
    
    // MARK: Published properties
    @Published var isShowingFileSelector: Bool
    
    @Published private(set) var isLoading: Bool
    @Published private var csvData: [[String]]
    @Published private(set) var errorMessage: String?
    
    // MARK: Private properties
    private let csvReader: CSVReader
    
    init(
        isShowingFileSelector: Bool = false,
        isLoading: Bool = false,
        csvData: [[String]] = [],
        errorMessage: String? = nil,
        csvReader: CSVReader = CSVReader()
    ) {
        self.isShowingFileSelector = isShowingFileSelector
        self.isLoading = isLoading
        self.csvData = csvData
        self.errorMessage = errorMessage
        self.csvReader = csvReader
    }
    
    func showFileSelector() {
        isShowingFileSelector = true
        isLoading = true
    }
    
    func onChooseFile(_ result: Result<URL, Error>) {
        switch result {
        case .success(let url):
            guard url.startAccessingSecurityScopedResource() else { return }
            loadCSV(from: url)
        case .failure:
            errorMessage = genericErrorMessage
        }
        isLoading = false
    }
    
    private func loadCSV(from url: URL) {
        do {
            csvData = try csvReader.parseCSV(from: url)
        } catch {
            guard let csvReaderError = error as? CSVReaderError else {
                errorMessage = genericErrorMessage
                return
            }
            errorMessage = csvReaderError.errorDescription
        }
    }
    
    func isEven(_ row: [String]) -> Bool {
        csvData.firstIndex(of: row)?.isMultiple(of: 2) == true
    }
}

// MARK: Get-only properties
extension MainViewModel {
    private var genericErrorMessage: String {
        "Failed to load CSV file"
    }
    
    var getCSVHeaders: [String]? {
        csvData.first
    }
    
    var getCSVData: [[String]] {
        csvData.filter { $0 != getCSVHeaders }
    }
}
