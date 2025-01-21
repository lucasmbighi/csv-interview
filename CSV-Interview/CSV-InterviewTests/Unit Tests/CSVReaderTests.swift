//
//  CSVReaderTests.swift
//  CSV-InterviewTests
//
//  Created by Lucas Bighi on 19/01/25.
//

import XCTest
@testable import CSV_Interview

final class CSVReaderTests: XCTestCase {
    
    var csvReader: CSVReader!
    
    override func setUp() {
        super.setUp()
        csvReader = CSVReader()
    }
    
    override func tearDown() {
        csvReader = nil
        super.tearDown()
    }
    
    func testParseCSV_ValidContent() throws {
        let url = try url(forCSV: "issues")
        
        let results = try csvReader.parseCSV(from: url)
        let firstResult = results[1]
        
        XCTAssertEqual(results.count, 4)
        XCTAssertEqual(firstResult[0], "Theo")
        XCTAssertEqual(firstResult[1], "Jansen")
        XCTAssertEqual(firstResult[2], "5")
        XCTAssertEqual(firstResult[3], "1978-01-02T00:00:00")
    }
    
    func testParseCSV_EmptyContent() throws {
        let url = try url(forCSV: "empty")
        
        XCTAssertThrowsError(try csvReader.parseCSV(from: url)) { error in
            XCTAssertEqual(error as? CSVReaderError, CSVReaderError.empty)
        }
    }
    
    func testParseCSV_MalformedContent() throws {
        let url = try url(forCSV: "malformed")
        
        XCTAssertThrowsError(try csvReader.parseCSV(from: url)) { error in
            XCTAssertEqual(error as? CSVReaderError, CSVReaderError.malformed)
        }
    }
    
    private func url(forCSV csv: String) throws -> URL {
        let bundle = Bundle(for: type(of: self))
        guard let url = bundle.url(forResource: csv, withExtension: "csv") else {
            throw NSError(domain: "Unable to find file \(csv)", code: 0)
        }
        return url
    }
}
