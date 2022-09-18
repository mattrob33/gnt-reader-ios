//
//  VerseRef.swift
//  GNT Reader
//
//  Created by Matt Robertson on 8/22/21.
//

import Foundation

struct VerseRef {
    var book: Book
    var chapter: Int
    var verse: Int?
    
    init(book: Book, chapter: Int, verse: Int?) {
        self.book = book
        self.chapter = chapter
        self.verse = verse
    }
    
    func serialize() -> String {
        return "\(book.num)_\(chapter)_\(verse ?? 1)"
    }
    
    static func deserialize(from serialized: String) -> VerseRef {
        let parts = serialized.components(separatedBy: "_")
        return VerseRef(
            book: Book(Int(parts[0])!),
            chapter: Int(parts[1])!,
            verse: Int(parts[2])!
        )
    }
    
    static func fromAbsoluteChapterNum(_ absChapterNum: Int) -> VerseRef? {
        var bookNum = 0

        for bookEntry in 0..<verseCounts.count {
            let bookArray = verseCounts[bookEntry]
            if absChapterNum < bookNum + bookArray.count {
                let book = Book(bookEntry)
                let chapter = absChapterNum - bookNum + 1

                return VerseRef(book: book, chapter: chapter, verse: 1)
            }
            else {
                bookNum += bookArray.count
            }
        }
        
        return nil
    }
}

func getAbsoluteChapterNumForBook(_ book: Book) -> Int {
    var absChapterNum = 0

    for i in 0..<book.num {
        absChapterNum += verseCounts[i].count
    }

    return absChapterNum
}
