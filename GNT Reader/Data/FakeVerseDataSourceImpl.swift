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
                    Word(text: "Ἐν", lexicalForm: "έν", parsing: fakeWordParsing()),
                    Word(text: "ἀρχῇ", lexicalForm: "ἀρχῇ", parsing: fakeWordParsing()),
                    Word(text: "ἦν", lexicalForm: "be", parsing: fakeWordParsing()),
                    Word(text: "ὁ", lexicalForm: "ὁ", parsing: fakeWordParsing()),
                    Word(text: "λόγος,", lexicalForm: "λόγος", parsing: fakeWordParsing()),
                    Word(text: "καὶ", lexicalForm: "καὶ", parsing: fakeWordParsing()),
                    Word(text: "ὁ", lexicalForm: "ὁ", parsing: fakeWordParsing()),
                    Word(text: "λόγος", lexicalForm: "λόγος", parsing: fakeWordParsing()),
                    Word(text: "ἦν", lexicalForm: "be", parsing: fakeWordParsing()),
                    Word(text: "πρὸς", lexicalForm: "πρὸς", parsing: fakeWordParsing()),
                    Word(text: "τὸν", lexicalForm: "ὁ", parsing: fakeWordParsing()),
                    Word(text: "θεόν,", lexicalForm: "θεός", parsing: fakeWordParsing()),
                    Word(text: "καὶ", lexicalForm: "καὶ", parsing: fakeWordParsing()),
                    Word(text: "θεὸς", lexicalForm: "θεὸς", parsing: fakeWordParsing()),
                    Word(text: "ἦν", lexicalForm: "be", parsing: fakeWordParsing()),
                    Word(text: "λόγος.", lexicalForm: "λόγος", parsing: fakeWordParsing()),
                ]
            ),
            
            Verse(
                verseRef: VerseRef(
                    book: Book(0),
                    chapter: 1,
                    verse: 2
                ),
                words: [
                        Word(text: "οὗτος", lexicalForm: "οὗτος", parsing: fakeWordParsing()),
                        Word(text: "ἦν", lexicalForm: "be", parsing: fakeWordParsing()),
                        Word(text: "ἐν", lexicalForm: "ἐν", parsing: fakeWordParsing()),
                        Word(text: "ἀρχῇ", lexicalForm: "ἀρχῇ", parsing: fakeWordParsing()),
                        Word(text: "πρὸς", lexicalForm: "πρὸς", parsing: fakeWordParsing()),
                        Word(text: "τὸν", lexicalForm: "ὁ", parsing: fakeWordParsing()),
                        Word(text: "θεόν.", lexicalForm: "θεός", parsing: fakeWordParsing()),
                ]
            )
        ]
    }

    private func fakeWordParsing() -> WordParsing {
        return WordParsing.decode(codedParsing: "")
    }
    

}
