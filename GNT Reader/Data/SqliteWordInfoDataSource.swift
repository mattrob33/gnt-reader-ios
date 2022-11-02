//
//  SqliteVerseDataSource.swift
//  GNT Reader
//
//  Created by Matt Robertson on 9/16/22.
//

import Foundation
import SQLite

class SqliteWordInfoDataSource: WordInfoDataSource {
    
    let db: Connection
    
    init() {
        let dbUrl = Bundle.main.url(forResource: "gnt-app", withExtension: "db")!
        let dbPath = dbUrl.path
        db = try! Connection(dbPath)
    }
    
    func getWordInfo(for lex: String) -> WordInfo? {
        
        let glossesTable = Table("glosses")

        let _lex = Expression<String>("lex")
        let _gloss = Expression<String>("gloss")
        let _occ = Expression<Int>("occ")

        let query = glossesTable.filter(_lex == lex)
        
        for wordInfo in try! db.prepare(query) {
            return WordInfo(
                lex: wordInfo[_lex],
                gloss: wordInfo[_gloss],
                occ: wordInfo[_occ]
            )
        }
        
        return nil
    }
    
    func getConcordance(for lex: String) -> [(VerseRef, String)] {
        
        let concordanceTable = Table("concordance")

        let _lex = Expression<String>("lex")
        let _book = Expression<Int>("book")
        let _chapter = Expression<Int>("chapter")
        let _verseNum = Expression<Int>("verse")

        let query = concordanceTable.filter(_lex == lex)
        
        var concordance: [(VerseRef, String)] = []
        
        for result in try! db.prepare(query) {
            let ref = VerseRef(book: Book(result[_book]), chapter: result[_chapter], verse: result[_verseNum])
            concordance.append(
                (ref, "")
            )
        }
        
        return concordance
    }

}
