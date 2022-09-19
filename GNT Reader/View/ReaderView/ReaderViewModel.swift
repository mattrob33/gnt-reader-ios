//
//  ReaderViewModel.swift
//  GNT Reader
//
//  Created by Matt Robertson on 8/22/21.
//

import Foundation

class ReaderViewModel: ObservableObject {

    @Published private(set) var verseRef: VerseRef = VerseRef(book: Book(0), chapter: 1, verse: 1)
    
    private(set) var verses: [Verse] = []

    private let verseDataSource: VerseDataSource
    
    private var wordId = 0
    
    init() {
        verseDataSource = SqliteVerseDataSource()
        verseRef = VerseRef.deserialize(from: UserDefaults().string(forKey: "verse_ref") ?? "0_1_1")
    }
    
    func goToVerseRef(_ ref: VerseRef) {
        verseRef = ref
    }

    func getVersesForChapter(ref: VerseRef) -> [Verse] {
        
        wordId = 0
        
        let chapter = verseDataSource.getVersesForChapter(book: ref.book, chapter: ref.chapter).map { verse in
            Verse(
                verseRef: verse.verseRef,
                words: verse.words.map { word in
                    Word(
                        text: word.text,
                        lexicalForm: word.lexicalForm,
                        parsing: word.parsing,
                        wordId: "\(verse.verseRef.book.num)_\(verse.verseRef.chapter)_\(getAndIncrementWordId())"
                    )
                }
            )
        }
        
        verses += chapter
        
        return chapter
    }

    func getWord(byId id: String) -> Word? {
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
