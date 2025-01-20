//
//  MainViewModel.swift
//  CSV-Interview
//
//  Created by Lucas Bighi on 18/01/25.
//

import Foundation

final class MainViewModel: ObservableObject {
    
    // MARK: Private properties
    private let csvReader: CSVReader
    
    // MARK: Published properties
    @Published private(set) var errorMessage: String?
    @Published private(set) var csvData: [[String]] = []
    
    init(csvReader: CSVReader = CSVReader()) {
        self.csvReader = csvReader
    }
    
    func loadCSV(from url: URL) {
        do {
            csvData = try csvReader.parseCSV(from: url)
        } catch {
            guard let csvReaderError = error as? CSVReaderError else {
                errorMessage = "Failed to load CSV"
                return
            }
            errorMessage = csvReaderError.errorDescription
        }
    }
}
