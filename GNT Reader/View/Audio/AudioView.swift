//
//  AudioView.swift
//  GNT Reader
//
//  Created by Matt Robertson on 2/11/24.
//

import Foundation
import SwiftUI

struct AudioView: View {

    @StateObject private var viewModel: AudioViewModel = AudioViewModel()
    
    var chapter: VerseRef

    var body: some View {
        VStack {
            Image(systemName: "chevron.down")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 20, height: 20)
                .foregroundStyle(.gray)
                .padding(.top, 16)
                .padding(.bottom, 32)

            playbackControls(
                playbackState: $viewModel.player.playbackState,
                onPlayPause: viewModel.onTapPlayPause,
                onSkipBackward: viewModel.onSkipBackward,
                onSkipForward: viewModel.onSkipForward
            )
            .onReceive(viewModel.player.$playbackState) { _ in
                self.viewModel.objectWillChange.send()
            }
            
            speedControls(speed: $viewModel.player.playbackSpeed).padding(.vertical, 40)

            voiceControls(isModern: $viewModel.player.isModernPronunciation)
        }
        .onAppear {
            viewModel.updateChapter(self.chapter)
        }
    }

    @ViewBuilder
    private func playbackControls(
        playbackState: Binding<PlaybackState>,
        onPlayPause: @escaping () -> (),
        onSkipBackward: @escaping () -> (),
        onSkipForward: @escaping () -> ()
    ) -> some View {
        HStack {
            skipBackButton(onTap: onSkipBackward)
            switch playbackState.wrappedValue {
            case .playing:
                pauseButton(onTap: onPlayPause)
            default:
                playButton(onTap: onPlayPause)
            }
            skipForwardButton(onTap: onSkipForward)
        }
    }
    
    @ViewBuilder
    private func speedControls(speed: Binding<Float>) -> some View {
        HStack {
            Spacer()
            VStack(alignment: .center) {
                Text("Speed").foregroundStyle(.gray)
                Text(String(format: "%.1fx", speed.wrappedValue)).foregroundStyle(.gray)
            }
            
            Spacer()
            Spacer()
            
            Slider(
                value: speed,
                in: 0.5...2.0,
                step: 0.1
            )
            
            Spacer()
        }
        .padding(.horizontal, 20)
    }
    
    @ViewBuilder
    private func voiceControls(isModern: Binding<Bool>) -> some View {
        HStack {
            Text("Erasmian")
                .foregroundStyle(isModern.wrappedValue ? .gray : Color.accentColor)
                .onTapGesture {
                    isModern.wrappedValue = false
                }

            Toggle("Pronunciation", isOn: isModern)
                .labelsHidden()
                .toggleStyle(SwitchToggleStyle(tint: .accentColor))
                .padding(.horizontal, 20)
            
            Text("Modern")
                .foregroundStyle(isModern.wrappedValue ? Color.accentColor : .gray)
                .onTapGesture {
                    isModern.wrappedValue = true
                }
        }
    }
    
    @ViewBuilder
    private func playButton(onTap: @escaping () -> ()) -> some View {
        mediaButton(
            name: "play.fill",
            size: 48,
            onTap: onTap
        )
    }
    
    @ViewBuilder
    private func pauseButton(onTap: @escaping () -> ()) -> some View {
        mediaButton(
            name: "pause.fill",
            size: 48,
            onTap: onTap
        )
    }
    
    @ViewBuilder
    private func skipBackButton(onTap: @escaping () -> ()) -> some View {
        mediaButton(
            name: "gobackward.10",
            size: 32,
            onTap: onTap
        )
    }
    
    @ViewBuilder
    private func skipForwardButton(onTap: @escaping () -> ()) -> some View {
        mediaButton(
            name: "goforward.10",
            size: 32,
            onTap: onTap
        )
    }
    
    @ViewBuilder
    private func mediaButton(
        name: String,
        size: CGFloat,
        onTap: @escaping () -> ()
    ) -> some View {
        Button(action: onTap) {
            Image(systemName: name)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .foregroundColor(.accentColor)
                .frame(width: size, height: size)
                .padding(.horizontal, 24)
        }
    }
    
}

struct AudioView_Previews: PreviewProvider {
    static var previews: some View {
        AudioView(
            chapter: VerseRef(book: Book(3), chapter: 1, verse: nil)
        )
    }
}
