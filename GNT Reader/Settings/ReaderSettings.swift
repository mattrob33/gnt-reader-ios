//
//  ReaderSettings.swift
//  GNT Reader
//
//  Created by Matt Robertson on 2/12/24.
//

import Foundation

struct ReaderSettings {
    let font: ReaderFont
    let fontSize: Int
    let lineSpacing: Float
    let showVerseNumbers: Bool
    let versesOnSeparateLines: Bool

    static func getDefault() -> ReaderSettings {
        return ReaderSettings(
            font: .cardo,
            fontSize: 28,
            lineSpacing: 24,
            showVerseNumbers: true,
            versesOnSeparateLines: false
        )
    }
    
    func copy(
        font: ReaderFont? = nil,
        fontSize: Int? = nil,
        lineSpacing: Float? = nil,
        showVerseNumbers: Bool? = nil,
        versesOnSeparateLines: Bool? = nil
    ) -> ReaderSettings {
        return ReaderSettings(
            font: font ?? self.font,
            fontSize: fontSize ?? self.fontSize,
            lineSpacing: lineSpacing ?? self.lineSpacing,
            showVerseNumbers: showVerseNumbers ?? self.showVerseNumbers,
            versesOnSeparateLines: versesOnSeparateLines ?? self.versesOnSeparateLines
        )
    }
}
