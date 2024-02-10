//
//  VocabDataSource.swift
//  GNT Reader
//
//  Created by Matt Robertson on 8/22/21.
//

import Foundation

protocol VocabDataSource {

    func getVocabWordsForChapter(book: Book, chapter: Int) -> [WordInfo]

}
