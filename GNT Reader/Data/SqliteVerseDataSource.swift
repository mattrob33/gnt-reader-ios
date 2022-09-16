//
//  SqliteVerseDataSource.swift
//  GNT Reader
//
//  Created by Matt Robertson on 9/16/22.
//

import Foundation
import SQLite

class SqliteVerseDataSource: VerseDataSource {
    
    let db: Connection
    
    init() {
        let dbUrl = Bundle.main.url(forResource: "gnt-app", withExtension: "db")!
        let dbPath = dbUrl.path
        db = try! Connection(dbPath)
    }
    
    func getVersesForChapter(book: Book, chapter: Int) -> [Verse] {
        
        var verses: [Verse] = []
        
        let versesTable = Table("verses")
        
        let _book = Expression<Int>("book")
        let _chapter = Expression<Int>("chapter")
        let _verse = Expression<Int>("verse")
        let _text = Expression<String>("encoded_text")

        do {
            let rawVerses = versesTable.filter(_book == book.num && _chapter == chapter)
            for verse in try db.prepare(rawVerses) {
                verses.append(
                    Verse(
                        verseRef: VerseRef(
                            book: book,
                            chapter: chapter,
                            verse: verse[_verse]
                        ),
                        words: extractWordsFromEncodedVerseText(verse[_text])
                    )
                )
            }
        } catch {
            print(error)
        }
        
        return verses
    }
    
    private func extractWordsFromEncodedVerseText(_ encodedText: String) -> [Word] {
        var words: [Word] = []
        
        let encodedWords = encodedText.components(separatedBy: " ")
        for encodedWord in encodedWords {
            let parts = encodedWord.components(separatedBy: "_")
            words.append(
                Word(
                    text: parts[0],
                    lexicalForm: parts[1],
                    parsing: WordParsing.decode(codedParsing: parts[2])
                )
            )
        }
        
        return words
    }

}
