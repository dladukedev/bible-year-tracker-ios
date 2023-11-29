//
//  BibleReadingParser.swift
//  BibleYearTracker
//
//  Created by Donovan LaDuke on 11/15/23.
//

import Foundation

class BibleReadingParser {
    static func parseBibleReadings(readingItem: String) -> [BibleDayModel.Reading] {
        let selections = readingItem.components(separatedBy: String(selectionSeparator))
        
        return selections.map { readingFrom(selection: $0) }
    }
    
    private static func readingFrom(selection: String) -> BibleDayModel.Reading {
        if(isSelectionPartialChapters(selection: selection)) {
            return parsePartialChapterReadingsFrom(selection: selection)
        } else if(isSelectionPartialChapter(selection: selection)) {
            return parsePartialChapterReadingFrom(selection: selection)
        } else if(isMultipleChapters(selection: selection)) {
            return parseMultipleChaptersReadingFrom(selection: selection)
        } else if(isSelectionSingleChapter(selection: selection)) {
            return parseSingleChapterReadingFrom(selection: selection)
        } else {
            return parseWholeBookReadingFrom(selection: selection)
        }
    }
    
    private static func isSelectionSingleChapter(selection: String) -> Bool {
        selection.last?.isNumber ?? false
    }
    
    private static func isSelectionPartialChapters(selection: String) -> Bool {
        let delims = selection.countOf(character: verseDeliminator)
        return delims == 2
    }
    
    private static func isSelectionPartialChapter(selection: String) -> Bool {
        let delims = selection.countOf(character: verseDeliminator)
        return delims == 1
    }
    
    private static func isMultipleChapters(selection: String) -> Bool {
        selection.contains { $0 == chapterDeliminator }
    }
    
    private static func parsePartialChapterReadingsFrom(selection: String) -> BibleDayModel.Reading {
        let (book, rawChaptersAndVerses) = splitBookAndChaptersFrom(selection: selection)
        
        
        let (readingStart, readingEnd) = rawChaptersAndVerses.splitOn(character: chapterDeliminator)
        let (chapterStart, verseStart) = readingStart.splitOn(character: verseDeliminator)
        let (chapterEnd, verseEnd) = readingEnd.splitOn(character: verseDeliminator)
        
        return BibleDayModel.Reading.partialChapters(book: book, chapterStart: chapterStart, verseStart: verseStart, chapterEnd: chapterEnd, verseEnd: verseEnd)
    }
    
    private static func parsePartialChapterReadingFrom(selection: String) ->BibleDayModel.Reading {
        let (book, rawChaptersAndVerses) = splitBookAndChaptersFrom(selection: selection)
        
        let (chapter, verses) = rawChaptersAndVerses.splitOn(character: verseDeliminator)
        
        let (verseStart, verseEnd) = verses.splitOn(character: chapterDeliminator)
        
        return BibleDayModel.Reading.partialChapter(book: book, chapter: chapter, verseStart: verseStart, verseEnd: verseEnd)
    }
    
    private static func parseMultipleChaptersReadingFrom(selection: String) ->BibleDayModel.Reading {
        let (book, rawChaptersAndVerses) = splitBookAndChaptersFrom(selection: selection)
        
        let (chapterStart, chapterEnd) = rawChaptersAndVerses.splitOn(character: chapterDeliminator)
        
        return BibleDayModel.Reading.multipleChapters(book: book, chapterStart: chapterStart, chapterEnd: chapterEnd)
    }
    
    private static func parseSingleChapterReadingFrom(selection: String) ->BibleDayModel.Reading {
        let (book, chapter) = splitBookAndChaptersFrom(selection: selection)
        
        return BibleDayModel.Reading.singleChapter(book: book, chapter: chapter)
    }
    
    private static func parseWholeBookReadingFrom(selection: String) ->BibleDayModel.Reading {
        let book = bibleBookFrom(bookString: selection)
        return BibleDayModel.Reading.wholeBook(book: book)
    }
    
    private static func splitBookAndChaptersFrom(selection: String) -> (BibleBook, String) {
        guard let splitIndex = selection.lastIndex(of: bookChapterDeliminator) else {
            fatalError()
        }
        
        let rawBook = selection[..<splitIndex]
        let book = bibleBookFrom(bookString: String(rawBook))
        let chapters = selection[(selection.index(after: splitIndex))...]
        
        return (book, String(chapters))
    }
    
    private static func bibleBookFrom(bookString: String) -> BibleBook {
        guard let bibleBook = bibleBookMap[bookString] else {
            fatalError()
        }
        
        return bibleBook
    }
    
    private static let selectionSeparator: Character = ","
    private static let chapterDeliminator: Character = "-"
    private static let verseDeliminator: Character = ":"
    private static let bookChapterDeliminator: Character = " "
    
    private static let bibleBookMap = [
        "Gn": BibleBook.genesis,
        "Ex": BibleBook.exodus,
        "Lv": BibleBook.leviticus,
        "Nm": BibleBook.numbers,
        "Dt": BibleBook.deuteronomy,
        "Jos": BibleBook.joshua,
        "Jgs": BibleBook.judges,
        "Ruth": BibleBook.ruth,
        "1 Sm": BibleBook.firstSamuel,
        "2 Sm": BibleBook.secondSamuel,
        "1 Kgs": BibleBook.firstKings,
        "2 Kgs": BibleBook.secondKings,
        "1 Chr": BibleBook.firstChronicles,
        "2 Chr": BibleBook.secondChronicles,
        "Ezra": BibleBook.ezra,
        "Neh": BibleBook.nehemiah,
        "Tb": BibleBook.tobit,
        "Jdt": BibleBook.judith,
        "Es": BibleBook.esther,
        "1 Mac": BibleBook.firstMaccabees,
        "2 Mac": BibleBook.secondMaccabees,
        "Jb": BibleBook.job,
        "Ps": BibleBook.psalms,
        "Prv": BibleBook.proverbs,
        "Ecc": BibleBook.ecclesiastes,
        "Sgs": BibleBook.songOfSongs,
        "Wis": BibleBook.wisdom,
        "Sir": BibleBook.sirach,
        "Is": BibleBook.isaiah,
        "Jer": BibleBook.jeremiah,
        "Lam": BibleBook.lamentations,
        "Bar": BibleBook.baruch,
        "Ez": BibleBook.ezekiel,
        "Dn": BibleBook.daniel,
        "Hos": BibleBook.hosea,
        "Joel": BibleBook.joel,
        "Am": BibleBook.amos,
        "Obadiah": BibleBook.obadiah,
        "Jon": BibleBook.jonah,
        "Mic": BibleBook.micah,
        "Nahum": BibleBook.nahum,
        "Habakkuk": BibleBook.habakkuk,
        "Zephaniah": BibleBook.zephaniah,
        "Haggai": BibleBook.haggai,
        "Zech": BibleBook.zechariah,
        "Malachi": BibleBook.malachi,
        "Mt": BibleBook.matthew,
        "Mk": BibleBook.mark,
        "Lk": BibleBook.luke,
        "Jn": BibleBook.john,
        "Acts": BibleBook.acts,
        "Rom": BibleBook.romans,
        "1 Cor": BibleBook.firstCorinthians,
        "2 Cor": BibleBook.secondCorinthians,
        "Gal": BibleBook.galatians,
        "Eph": BibleBook.ephesians,
        "Phil": BibleBook.philippians,
        "Col": BibleBook.colossians,
        "1 Thes": BibleBook.firstThessalonians,
        "2 Thes": BibleBook.secondThessalonians,
        "1 Tim": BibleBook.firstTimothy,
        "2 Tim": BibleBook.secondTimothy,
        "Titus": BibleBook.titus,
        "Philemon": BibleBook.philemon,
        "Heb": BibleBook.hebrews,
        "Jas": BibleBook.james,
        "1 Pt": BibleBook.firstPeter,
        "2 Pt": BibleBook.secondPeter,
        "1 Jn": BibleBook.firstJohn,
        "2 Jn": BibleBook.secondJohn,
        "3 Jn": BibleBook.thirdJohn,
        "Jude": BibleBook.jude,
        "Rev": BibleBook.revelation,
    ]
}

private extension String {
    func countOf(character: Character) -> Int {
        filter { $0 == character }.count
    }
    
    func splitOn(character: Character) -> (String, String) {
        let parts = split(separator: character)
        
        guard let first = parts.first.map({ String($0) }) else { fatalError() }
        guard let last = parts.last.map({ String($0) }) else { fatalError() }
        
        return (first, last)
    }
}

