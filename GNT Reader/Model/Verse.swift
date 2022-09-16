//
//  Verse.swift
//  GNT Reader
//
//  Created by Matt Robertson on 8/22/21.
//

import Foundation

struct Verse {
    let verseRef: VerseRef
    let words: [Word]
    let text: String

    public init(verseRef: VerseRef, words: [Word]) {
        self.verseRef = verseRef
        self.words = words

        text = {
            var text = ""
            for word in words {
                text += "\(word.text) "
            }
            return text.trim()
        }()
    }

}
