//
//  ReaderViewModel.swift
//  GNT Reader
//
//  Created by Matt Robertson on 8/22/21.
//

import Foundation

extension ReaderView {
    
    class ViewModel: ObservableObject {

        @Published private(set) var verses: [Verse] = []

        private let verseDataSource: VerseDataSource
        
        init() {
            verseDataSource = FakeVerseDataSourceImpl()
        }

        func loadVersesForChapter(book: Book, chapter: Int) {
            verses = verseDataSource.getVersesForChapter(book: book, chapter: chapter)
        }

    }

}
