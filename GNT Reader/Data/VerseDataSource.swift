//
//  VerseDataSource.swift
//  GNT Reader
//
//  Created by Matt Robertson on 8/22/21.
//

import Foundation

protocol VerseDataSource {

    func getVersesForChapter(book: Book, chapter: Int) -> [Verse]

}
