//
//  SqliteVerseDataSource.swift
//  GNT Reader
//
//  Created by Matt Robertson on 9/16/22.
//

import Foundation
import SQLite

class SqliteVocabDataSource: VocabDataSource {
    
    let db: Connection
    
    init() {
        let dbUrl = Bundle.main.url(forResource: "gnt-app", withExtension: "db")!
        let dbPath = dbUrl.path
        db = try! Connection(dbPath)
    }
    
    func getVocabWordsForChapter(book: Book, chapter: Int) -> [WordInfo] {
        
        let glosses = Table("glosses")
        let concordance = Table("concordance")

        let _lex = Expression<String>("lex")
        let _gloss = Expression<String>("gloss")
        let _occ = Expression<Int>("occ")
        
        let _book = Expression<Int>("book")
        let _chapter = Expression<Int>("chapter")
        
        let chapterConcordance = concordance.filter(_book == book.num && _chapter == chapter)

        let q = glosses
            .join(.inner, concordance, on: glosses[_lex] == concordance[_lex])
            .filter(chapterConcordance.)

//        let query = glossesTable.filter(_lex == lex)
//        
//        for wordInfo in try! db.prepare(query) {
//            return WordInfo(
//                lex: wordInfo[_lex],
//                gloss: wordInfo[_gloss],
//                occ: wordInfo[_occ]
//            )
//        }
//        
//        return nil
    }

}
