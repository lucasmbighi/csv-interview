//
//  CSVReader.swift
//  CSV-Interview
//
//  Created by Lucas Bighi on 19/01/25.
//

import Foundation

class CSVReader {
    func parseCSV(from url: URL) throws -> [[String]] {
        let content = try String(contentsOf: url, encoding: .utf8)
        let lines = content.split(whereSeparator: \.isNewline)
        
        var rows: [[String]] = []
        let expectedColumnCount = lines.first?.split(separator: ",").count ?? 0
        
        for line in lines {
            let fields = line
                .split(separator: ",")
                .map { String($0).trimmingCharacters(in: CharacterSet(charactersIn: "\"")) }
            
            if fields.first?.count == .zero {
                throw CSVReaderError.empty
            } else if fields.count != expectedColumnCount {
                throw CSVReaderError.malformed
            }
            
            rows.append(fields)
        }
        
        return rows
    }
}
