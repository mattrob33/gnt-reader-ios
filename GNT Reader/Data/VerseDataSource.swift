//
//  VerseDataSource.swift
//  GNT Reader
//
//  Created by Matt Robertson on 8/22/21.
//

import Foundation

class VerseDataSource {
    
    func getVersesForChapter(book: Book, chapter: Int) -> [Verse] {
        return [
            Verse(
                verseRef: VerseRef(
                    book: Book(num: 0),
                    chapter: 1,
                    verse: 1
                ),
                words: [
                    
                ]
            )
        ]
    }
    

}
