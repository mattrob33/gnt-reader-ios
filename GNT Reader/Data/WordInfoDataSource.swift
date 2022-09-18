//
//  VerseDataSource.swift
//  GNT Reader
//
//  Created by Matt Robertson on 8/22/21.
//

import Foundation

protocol WordInfoDataSource {

    func getWordInfo(for lex: String) -> WordInfo?

}
