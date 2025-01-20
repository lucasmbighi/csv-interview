//
//  CSVReaderError.swift
//  CSV-Interview
//
//  Created by Lucas Bighi on 19/01/25.
//

import Foundation

enum CSVReaderError: LocalizedError {
    case empty
    case malformed
    
    var errorDescription: String? {
        switch self {
        case .empty:
            return "The CSV file is empty."
        case .malformed:
            return "The CSV file is malformed."
        }
    }
}

