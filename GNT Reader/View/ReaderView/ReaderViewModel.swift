//
//  ReaderViewModel.swift
//  GNT Reader
//
//  Created by Matt Robertson on 8/22/21.
//

import Foundation

class ReaderViewModel: ObservableObject {

    @Published private(set) var verseRef: VerseRef = VerseRef(book: Book(0), chapter: 1, verse: 1)
    
    @Published private(set) var verses: [Verse] = []
    
    private var wordMap: [ Int : Word ] = [:]

    private let verseDataSource: VerseDataSource
    
    private var wordId = 0
    
    init() {
        verseDataSource = SqliteVerseDataSource()
        loadVersesForChapter(ref: verseRef)
    }

    func loadVersesForChapter(ref: VerseRef) {
        verseRef = ref

        verses = verseDataSource.getVersesForChapter(book: ref.book, chapter: ref.chapter).map { verse in
            Verse(
                verseRef: verse.verseRef,
                words: verse.words.map { word in
                    Word(
                        text: word.text,
                        lexicalForm: word.lexicalForm,
                        parsing: word.parsing,
                        wordId: getAndIncrementWordId()
                    )
                }
            )
        }
    }

    func getWord(byId id: Int) -> Word? {
        for verse in verses {
            for word in verse.words {
                if word.wordId == id {
                    return word
                }
            }
        }
        return nil
    }
    
    private func getAndIncrementWordId() -> Int {
        let id = wordId
        wordId += 1
        return id
    }
}
