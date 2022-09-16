//
//  FakeVerseDataSourceImpl.swift
//  GNT Reader
//
//  Created by Matt Robertson on 8/22/21.
//

import Foundation

class FakeVerseDataSourceImpl: VerseDataSource {

    // A fake for testing
    func getVersesForChapter(book: Book, chapter: Int) -> [Verse] {
        return [
            Verse(
                verseRef: VerseRef(
                    book: Book(0),
                    chapter: 1,
                    verse: 1
                ),
                words: [
                    Word(text: "This", lexicalForm: "this", parsing: fakeWordParsing()),
                    Word(text: "is", lexicalForm: "be", parsing: fakeWordParsing()),
                    Word(text: "the", lexicalForm: "the", parsing: fakeWordParsing()),
                    Word(text: "first", lexicalForm: "one", parsing: fakeWordParsing()),
                    Word(text: "verse.", lexicalForm: "verse", parsing: fakeWordParsing())
                ]
            ),
            
            Verse(
                verseRef: VerseRef(
                    book: Book(0),
                    chapter: 1,
                    verse: 2
                ),
                words: [
                    Word(text: "This", lexicalForm: "this", parsing: fakeWordParsing()),
                    Word(text: "is", lexicalForm: "be", parsing: fakeWordParsing()),
                    Word(text: "the", lexicalForm: "the", parsing: fakeWordParsing()),
                    Word(text: "second", lexicalForm: "two", parsing: fakeWordParsing()),
                    Word(text: "verse.", lexicalForm: "verse", parsing: fakeWordParsing())
                ]
            ),
            
            Verse(
                verseRef: VerseRef(
                    book: Book(0),
                    chapter: 1,
                    verse: 3
                ),
                words: [
                    Word(text: "This", lexicalForm: "this", parsing: fakeWordParsing()),
                    Word(text: "is", lexicalForm: "be", parsing: fakeWordParsing()),
                    Word(text: "the", lexicalForm: "the", parsing: fakeWordParsing()),
                    Word(text: "third", lexicalForm: "three", parsing: fakeWordParsing()),
                    Word(text: "verse.", lexicalForm: "verse", parsing: fakeWordParsing())
                ]
            ),
            
            Verse(
                verseRef: VerseRef(
                    book: Book(0),
                    chapter: 1,
                    verse: 4
                ),
                words: [
                    Word(text: "This", lexicalForm: "this", parsing: fakeWordParsing()),
                    Word(text: "is", lexicalForm: "be", parsing: fakeWordParsing()),
                    Word(text: "the", lexicalForm: "the", parsing: fakeWordParsing()),
                    Word(text: "fourth", lexicalForm: "four", parsing: fakeWordParsing()),
                    Word(text: "verse.", lexicalForm: "verse", parsing: fakeWordParsing())
                ]
            ),
        ]
    }

    private func fakeWordParsing() -> WordParsing {
        return WordParsing.decode(codedParsing: "")
    }
    

}
