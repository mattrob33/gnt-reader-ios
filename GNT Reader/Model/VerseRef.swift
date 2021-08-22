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
}
