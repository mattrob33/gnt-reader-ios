//
//  ReaderSettingsStorage.swift
//  GNT Reader
//
//  Created by Matt Robertson on 2/12/24.
//

import Foundation

class ReaderSettingsStorage {
    
    private let FONT_KEY = "font"
    private let FONT_SIZE_KEY = "font_size"
    private let LINE_SPACING_KEY = "line_spacing"
    private let SHOW_VERSE_NUMBERS_KEY = "show_verse_numbers"
    private let VERSES_ON_SEPARATE_LINES_KEY = "verses_on_separate_lines"
    
    private let defaultSettings = ReaderSettings.getDefault()

    private init() {
        
//        UserDefaults.standard.register(
//            defaults: [
//                FONT_KEY: defaultSettings.font,
//                FONT_SIZE_KEY: defaultSettings.fontSize,
//                LINE_SPACING_KEY: defaultSettings.lineSpacing,
//                SHOW_VERSE_NUMBERS_KEY: defaultSettings.showVerseNumbers,
//                VERSES_ON_SEPARATE_LINES_KEY: defaultSettings.versesOnSeparateLines
//            ]
//        )
    }

    static let shared = ReaderSettingsStorage()

    func save(_ settings: ReaderSettings) {
        UserDefaults.standard.set(settings.font.rawValue, forKey: FONT_KEY)
        UserDefaults.standard.set(settings.fontSize, forKey: FONT_SIZE_KEY)
        UserDefaults.standard.set(settings.lineSpacing, forKey: LINE_SPACING_KEY)
        UserDefaults.standard.set(settings.showVerseNumbers, forKey: SHOW_VERSE_NUMBERS_KEY)
        UserDefaults.standard.set(settings.versesOnSeparateLines, forKey: VERSES_ON_SEPARATE_LINES_KEY)
    }
    
    func load() -> ReaderSettings {
        return ReaderSettings(
            font: ReaderFont(rawValue: UserDefaults.standard.string(forKey: FONT_KEY) ?? "") ?? defaultSettings.font,
            fontSize: UserDefaults.standard.optionalInt(forKey: FONT_SIZE_KEY) ?? defaultSettings.fontSize,
            lineSpacing: UserDefaults.standard.optionalFloat(forKey: LINE_SPACING_KEY) ?? defaultSettings.lineSpacing,
            showVerseNumbers: UserDefaults.standard.optionalBool(forKey: SHOW_VERSE_NUMBERS_KEY) ?? defaultSettings.showVerseNumbers,
            versesOnSeparateLines: UserDefaults.standard.optionalBool(forKey: VERSES_ON_SEPARATE_LINES_KEY) ?? defaultSettings.versesOnSeparateLines
        )
    }
    
}

extension UserDefaults {

    public func optionalInt(forKey defaultName: String) -> Int? {
        let defaults = self
        if let value = defaults.value(forKey: defaultName) {
            return value as? Int
        }
        return nil
    }

    public func optionalFloat(forKey defaultName: String) -> Float? {
        let defaults = self
        if let value = defaults.value(forKey: defaultName) {
            return value as? Float
        }
        return nil
    }

    public func optionalBool(forKey defaultName: String) -> Bool? {
        let defaults = self
        if let value = defaults.value(forKey: defaultName) {
            return value as? Bool
        }
        return nil
    }
}
