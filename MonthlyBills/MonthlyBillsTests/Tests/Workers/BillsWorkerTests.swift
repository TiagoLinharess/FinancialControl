//
//  BillsWorkerTests.swift
//  MonthlyBillsTests
//
//  Created by Tiago Linhares on 08/01/24.
//

@testable import MonthlyBills
import SharpnezCore
import XCTest

final class BillsWorkerTests: XCTestCase {
    
    var sut: BillsWorker!
    var mock: MonthlyBillsRepositoryMock!

    override func setUpWithError() throws {
        mock = .init()
        sut = .init(repository: mock)
    }

    override func tearDownWithError() throws {
        mock = nil
        sut = nil
    }

    func test_create_success() throws {
        XCTAssertNoThrow(try sut.create(annualCalendar: BillsMock.annualCalendar))
    }
    
    func test_create_error() throws {
        mock.isError = true
        XCTAssertThrowsError(try sut.create(annualCalendar: BillsMock.annualCalendar))
    }
    
    func test_read_success() throws {
        let annualCalendars = try sut.read()
        XCTAssertTrue(annualCalendars.count > 0)
    }
    
    func test_read_error() throws {
        mock.isError = true
        XCTAssertThrowsError(try sut.read())
    }
    
    func test_read_at_year_success() throws {
        let annualCalendar = try sut.readAtYear(year: "2023")
        XCTAssertTrue(annualCalendar.year > "2023")
    }
    
    func test_read_at_year_error() throws {
        mock.isError = true
        XCTAssertThrowsError(try sut.readAtYear(year: "2023"))
    }
    
    func test_read_at_month_success() throws {
        let bill = try sut.readAtMonth(id: mock.billId)
        XCTAssertTrue(bill.id == mock.billId)
    }
    
    func test_read_at_month_error() throws {
        mock.isError = true
        XCTAssertThrowsError(try sut.readAtMonth(id: mock.billId))
    }
}
