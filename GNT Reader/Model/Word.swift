//
//  Word.swift
//  GNT Reader
//
//  Created by Matt Robertson on 8/22/21.
//

import Foundation

struct Word {
    let text: String
    let lexicalForm: String
    let parsing: WordParsing

    var wordId: String = ""
}

extension Word: Identifiable {
    public var id: String { String(wordId) }
}
