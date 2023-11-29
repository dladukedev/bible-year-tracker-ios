//
//  BibleReadingsDataModel.swift
//  BibleYearTracker
//
//  Created by Donovan LaDuke on 11/15/23.
//

import Foundation

struct BibleDataModel: Codable {
    let days: [Day]
    
    struct Day: Codable {
        let id: String
        let offset: String
        let reading1: String
        let reading2: String
        let reading3: String
        
        var readings: [String] {
            [reading1, reading2, reading3]
        }
    }
}

struct BibleDayModel: Identifiable {
    let id: Int
    let offset: Int
    let readings: [Reading]
    
    enum Reading: Equatable, Identifiable, CustomStringConvertible {
        case wholeBook(book: BibleBook)
        case singleChapter(book: BibleBook, chapter: String)
        case partialChapter(book: BibleBook, chapter: String, verseStart: String, verseEnd: String)
        case multipleChapters(book: BibleBook, chapterStart: String, chapterEnd: String)
        case partialChapters(book: BibleBook, chapterStart: String, verseStart: String, chapterEnd: String, verseEnd: String)
        
        var id: String {
            switch self {
            case .wholeBook(book: let book):
                return book.description
            case .singleChapter(book: let book, chapter: let chapter):
                return "\(book)+\(chapter)"
            case .partialChapter(book: let book, chapter: let chapter, verseStart: let verseStart, verseEnd: let verseEnd):
                return "\(book)+\(chapter)+\(verseStart)+\(verseEnd)"
            case .multipleChapters(book: let book, chapterStart: let chapterStart, chapterEnd: let chapterEnd):
                return "\(book)+\(chapterStart)+\(chapterEnd)"
            case .partialChapters(book: let book, chapterStart: let chapterStart, verseStart: let verseStart, chapterEnd: let chapterEnd, verseEnd: let verseEnd):
                return "\(book)+\(chapterStart)+\(verseStart)+\(chapterEnd)+\(verseEnd)"
            }
        }
        
        var description: String {
            switch self {
            case .wholeBook(book: let book):
                return book.description
            case .singleChapter(book: let book, chapter: let chapter):
                return "\(book) \(chapter)"
            case .partialChapter(book: let book, chapter: let chapter, verseStart: let verseStart, verseEnd: let verseEnd):
                return "\(book) \(chapter):\(verseStart)-\(verseEnd)"
            case .multipleChapters(book: let book, chapterStart: let chapterStart, chapterEnd: let chapterEnd):
                return "\(book) \(chapterStart)-\(chapterEnd)"
            case .partialChapters(book: let book, chapterStart: let chapterStart, verseStart: let verseStart, chapterEnd: let chapterEnd, verseEnd: let verseEnd):
                return "\(book) \(chapterStart):\(verseStart)-\(chapterEnd):\(verseEnd)"
            }
        }
        
    }
    
    init(dataModel: BibleDataModel.Day) {
        guard let dataModelId = Int(dataModel.id) else { fatalError() }
        guard let dataModelOffset = Int(dataModel.offset) else { fatalError() }
        
        self.id = dataModelId
        self.offset = dataModelOffset
        
        self.readings = dataModel.readings.flatMap { BibleReadingParser.parseBibleReadings(readingItem: $0) }
    }
}

enum BibleBook: CustomStringConvertible {
    case genesis
    case exodus
    case leviticus
    case numbers
    case deuteronomy
    case joshua
    case judges
    case ruth
    case firstSamuel
    case secondSamuel
    case firstKings
    case secondKings
    case firstChronicles
    case secondChronicles
    case ezra
    case nehemiah
    case tobit
    case judith
    case esther
    case job
    case psalms
    case proverbs
    case ecclesiastes
    case songOfSongs
    case wisdom
    case sirach
    case isaiah
    case jeremiah
    case lamentations
    case baruch
    case ezekiel
    case daniel
    case hosea
    case joel
    case amos
    case obadiah
    case jonah
    case micah
    case nahum
    case habakkuk
    case zephaniah
    case haggai
    case zechariah
    case malachi
    case firstMaccabees
    case secondMaccabees
    case matthew
    case mark
    case luke
    case john
    case acts
    case romans
    case firstCorinthians
    case secondCorinthians
    case galatians
    case ephesians
    case philippians
    case colossians
    case firstThessalonians
    case secondThessalonians
    case firstTimothy
    case secondTimothy
    case titus
    case philemon
    case hebrews
    case james
    case firstPeter
    case secondPeter
    case firstJohn
    case secondJohn
    case thirdJohn
    case jude
    case revelation
    
    var description: String {
        switch self {
        case .genesis: return "Genesis"
        case .exodus: return "Exodus"
        case .leviticus: return "Leviticus"
        case .numbers: return "Numbers"
        case .deuteronomy: return "Deuteronomy"
        case .joshua: return "Joshua"
        case .judges: return "Judges"
        case .ruth: return "Ruth"
        case .firstSamuel: return "1 Samuel"
        case .secondSamuel: return "2 Samuel"
        case .firstKings: return "1 Kings"
        case .secondKings: return "2 Kings"
        case .firstChronicles: return "1 Chronicles"
        case .secondChronicles: return "2 Chronicles"
        case .ezra: return "Ezra"
        case .nehemiah: return "Nehemiah"
        case .tobit: return "Tobit"
        case .judith: return "Judith"
        case .esther: return "Esther"
        case .job: return "Job"
        case .psalms: return "Psalms"
        case .proverbs: return "Proverbs"
        case .ecclesiastes: return "Ecclesiastes"
        case .songOfSongs: return "Song of Songs"
        case .wisdom: return "Wisdom"
        case .sirach: return "Sirach"
        case .isaiah: return "Isaiah"
        case .jeremiah: return "Jeremiah"
        case .lamentations: return "Lamentations"
        case .baruch: return "Baruch"
        case .ezekiel: return "Ezekiel"
        case .daniel: return "Daniel"
        case .hosea: return "Hosea"
        case .joel: return "Joel"
        case .amos: return "Amos"
        case .obadiah: return "Obadiah"
        case .jonah: return "Jonah"
        case .micah: return "Micah"
        case .nahum: return "Nahum"
        case .habakkuk: return "Habakkuk"
        case .zephaniah: return "Zephaniah"
        case .haggai: return "Haggai"
        case .zechariah: return "Zechariah"
        case .malachi: return "Malachi"
        case .firstMaccabees: return "1 Maccabees"
        case .secondMaccabees: return "2 Maccabees"
        case .matthew: return "Matthew"
        case .mark: return "Mark"
        case .luke: return "Luke"
        case .john: return "John"
        case .acts: return "Acts"
        case .romans: return "Romans"
        case .firstCorinthians: return "1 Corinthians"
        case .secondCorinthians: return "2 Corinthians"
        case .galatians: return "Galatians"
        case .ephesians: return "Ephesians"
        case .philippians: return "Philippians"
        case .colossians: return "Colossians"
        case .firstThessalonians: return "1 Thessalonians"
        case .secondThessalonians: return "2 Thessalonians"
        case .firstTimothy: return "1 Timothy"
        case .secondTimothy: return "2 Timothy"
        case .titus: return "Titus"
        case .philemon: return "Philemon"
        case .hebrews: return "Hebrews"
        case .james: return "James"
        case .firstPeter: return "1 Peter"
        case .secondPeter: return "2 Peter"
        case .firstJohn: return "1 John"
        case .secondJohn: return "2 John"
        case .thirdJohn: return "3 John"
        case .jude: return "Jude"
        case .revelation: return "Revelation"
        }
    }

}
