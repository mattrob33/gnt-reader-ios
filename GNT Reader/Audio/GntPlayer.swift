//
//  GntPlayer.swift
//  GNT Reader
//
//  Created by Matt Robertson on 2/11/24.
//

import Foundation
import AVFoundation
import AVKit
import MediaPlayer
import Combine

class GntPlayer: ObservableObject {

    static let shared: GntPlayer = GntPlayer()
    
    @Published var playbackState: PlaybackState = .stopped
    
    @Published var playbackSpeed: Float = 1.0
    
    @Published var isModernPronunciation: Bool = false
    
    private(set) var currentChapter: VerseRef? = nil

    private var player = AVQueuePlayer()
    
    private var cancellables = Set<AnyCancellable>()
    
    private init() {
        try? AVAudioSession.sharedInstance().setCategory(.playback, mode: .spokenAudio, policy: .longFormAudio)

        $playbackSpeed
            .sink { newValue in
                self.player.rate = newValue
            }
            .store(in: &cancellables)

        $isModernPronunciation
            .sink { _ in
                self.stop()
            }
            .store(in: &cancellables)
    }

    func onTapPlayPause(chapter: VerseRef) {
        switch self.playbackState {
        case .playing:
            pause()
        case .paused:
            resume()
        case .stopped:
            play(chapter: chapter)
        }
    }
    
    func onSkipBackward() {        
        let newTime = CMTimeSubtract(player.currentTime(), CMTimeMakeWithSeconds(10, preferredTimescale: 1000))
        let finalTime = max(newTime, CMTimeMake(value: 0, timescale: 1000))
        player.currentItem?.seek(to: finalTime, completionHandler: nil)
    }
    
    func onSkipForward() {
        let newTime = CMTimeAdd(player.currentTime(), CMTimeMakeWithSeconds(10, preferredTimescale: 1000))
        let duration = player.currentItem!.duration
        let finalTime = min(newTime, duration)
        player.currentItem?.seek(to: finalTime, completionHandler: nil)
    }

    func stop() {
        player.pause()
        player.removeAllItems()
        playbackState = .stopped
    }
    
    private func play(chapter: VerseRef) {
        player.removeAllItems()
        player.insert(
            AVPlayerItem(
                url: getUrl(isModern: isModernPronunciation, chapter: chapter)
            ),
            after: nil
        )
        player.play()
        currentChapter = chapter
        playbackState = .playing
    }
    
    private func resume() {
        player.play()
        playbackState = .playing
    }
    
    private func pause() {
        player.pause()
        playbackState = .paused
    }
    
    private func getUrl(
        isModern: Bool,
        chapter: VerseRef
    ) -> URL {
        let narrator: String
        if isModern {
            narrator = "modern/default"
        } else {
            narrator = "erasmian/default"
        }

        let bookString = String(format: "%02d", chapter.book.num + 1)
        let chapterString = String(format: "%02d", chapter.chapter)
        let refString = "\(bookString)-\(chapterString)"

        return URL(string: "https://erasmus.dev/gnt-audio/\(narrator)/\(refString).mp3")!
    }
}

