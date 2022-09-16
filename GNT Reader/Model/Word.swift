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
    
    var wordId: Int = -1
}
