//
//  ReaderFont.swift
//  GNT Reader
//
//  Created by Matt Robertson on 2/12/24.
//

import Foundation

enum ReaderFont: String, CaseIterable, Identifiable {
    case cardo
    case gentium
    
    var id: Self { self }
    
    func fontName() -> String {
        switch self {
        case .cardo: return "Cardo"
        case .gentium: return "GentiumBookPlus"
        }
    }
    
    static func fromFontName(_ name: String) -> ReaderFont {
        switch name {
        case "Cardo": return .cardo
        case "GentiumBookPlus": return .gentium
        default: return .cardo
        }
    }
}
