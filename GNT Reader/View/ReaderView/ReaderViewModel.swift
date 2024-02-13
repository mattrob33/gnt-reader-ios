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
    
    private(set) var wordMap: [String : Word] = [:]

    private let verseDataSource: VerseDataSource

    
    init() {
        verseDataSource = SqliteVerseDataSource()
    }
    
    func goToVerseRef(_ ref: VerseRef) {
        verseRef = ref
        UserDefaults().set(ref.serialize(), forKey: "verse_ref")
    }

    func getVersesForChapter(ref: VerseRef) -> [Verse] {

        var chapter: [Verse] = []

        let chapterVerses = verseDataSource.getVersesForChapter(book: ref.book, chapter: ref.chapter)
        
        var wordIdNum = 0
        
        for verse in chapterVerses {
            
            var words: [Word] = []

            for _word in verse.words {
                let wordId = "\(verse.verseRef.book.num)_\(verse.verseRef.chapter)_\(wordIdNum)"

                let word = Word(
                    text: _word.text,
                    lexicalForm: _word.lexicalForm,
                    parsing: _word.parsing,
                    wordId: wordId
                )
                
                words.append(word)
                wordMap[wordId] = word
                wordIdNum += 1
            }
            
            chapter.append(
                Verse(
                    verseRef: verse.verseRef,
                    words: words
                )
            )
        }
        
        return chapter
    }

    func getWord(byId id: String) -> Word? {
        return wordMap[id]
    }
    
}
