//
//  BibleReadingParserTests.swift
//  BibleYearTrackerTests
//
//  Created by Donovan LaDuke on 11/15/23.
//

import XCTest
@testable import BibleYearTracker

final class BibleReadingParserTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testParseSingleChapter() throws {
        let expected = [BibleDayModel.Reading.singleChapter(book: BibleBook.psalms, chapter: "1")]
        
        let actual = BibleReadingParser.parseBibleReadings(readingItem: "Ps 1")
        
        XCTAssertEqual(actual, expected)
    }
    
    func testParseMultipleSelections() throws {
        let expected = [BibleDayModel.Reading.wholeBook(book: BibleBook.secondJohn),BibleDayModel.Reading.wholeBook(book: BibleBook.thirdJohn)]
        
        let actual = BibleReadingParser.parseBibleReadings(readingItem: "2 Jn,3 Jn")
        
        XCTAssertEqual(actual, expected)
    }
    
    func testParseVerseRange() throws {
        let expected = [BibleDayModel.Reading.partialChapter(book: BibleBook.matthew, chapter: "1", verseStart: "1", verseEnd: "17")]
        
        let actual = BibleReadingParser.parseBibleReadings(readingItem: "Mt 1:1-17")
        
        XCTAssertEqual(actual, expected)
        
    }
}
