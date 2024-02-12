//
//  AudioViewModel.swift
//  GNT Reader
//
//  Created by Matt Robertson on 2/11/24.
//

import Foundation
import AVFoundation
import AVKit
import MediaPlayer
import Combine

class AudioViewModel: ObservableObject {
    
    @Published private(set) var chapter: VerseRef = VerseRef(book: Book(0), chapter: 1, verse: nil)

    @Published var player = GntPlayer.shared
    
    func updateChapter(_ chapter: VerseRef) {
        if player.currentChapter != chapter {
            player.stop()
        }
        self.chapter = chapter
    }
    
    func onTapPlayPause() {
        player.onTapPlayPause(chapter: chapter)
    }
    
    func onSkipBackward() {
        player.onSkipBackward()
    }
    
    func onSkipForward() {
        player.onSkipForward()
    }
}
