//
//  SettingsViewModel.swift
//  GNT Reader
//
//  Created by Matt Robertson on 2/12/24.
//

import Foundation
import Combine

class SettingsViewModel: ObservableObject {
    
    @Published var settings: ReaderSettings
    
    @Published var font: ReaderFont
    @Published var fontSize: Float
    @Published var lineSpacing: Float
    @Published var showVerseNumbers: Bool
    @Published var versesOnSeparateLines: Bool
    
    private var cancellables = Set<AnyCancellable>()

    init() {
        let settings = ReaderSettingsStorage.shared.load()

        font = settings.font
        fontSize = Float(settings.fontSize)
        lineSpacing = settings.lineSpacing
        showVerseNumbers = settings.showVerseNumbers
        versesOnSeparateLines = settings.versesOnSeparateLines

        self.settings = settings

        observeSettings()
        
    }

    private func observeSettings() {
        $settings.sink { updatedSettings in
            ReaderSettingsStorage.shared.save(updatedSettings)
        }
        .store(in: &cancellables)
        
        $font.sink { newValue in
            self.settings = self.settings.copy(font: newValue)
        }
        .store(in: &cancellables)

        $fontSize.sink { newValue in
            self.settings = self.settings.copy(fontSize: Int(newValue))
        }
        .store(in: &cancellables)

        $lineSpacing.sink { newValue in
            self.settings = self.settings.copy(lineSpacing: newValue)
        }
        .store(in: &cancellables)
        
        $showVerseNumbers.sink { newValue in
            self.settings = self.settings.copy(showVerseNumbers: newValue)
        }
        .store(in: &cancellables)
        
        $versesOnSeparateLines.sink { newValue in
            self.settings = self.settings.copy(versesOnSeparateLines: newValue)
        }
        .store(in: &cancellables)
        
    }
    
}
