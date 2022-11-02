//
//  MainViewModel.swift
//  GNT Reader
//
//  Created by Matt Robertson on 9/16/22.
//

import Foundation

class MainViewModel: ObservableObject {
    
    private let wordInfoDataSource = SqliteWordInfoDataSource()
    
    func getWordInfo(for lex: String) -> WordInfo? {
        return wordInfoDataSource.getWordInfo(for: lex)
    }
    
    func getConcordance(for lex: String) -> [(VerseRef, String)] {
        return wordInfoDataSource.getConcordance(for: lex)
    }
    
}
