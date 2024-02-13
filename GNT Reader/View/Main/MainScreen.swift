//
//  MainScreen.swift
//  GNT Reader
//
//  Created by Matt Robertson on 9/16/22.
//

import Foundation
import SwiftUI

struct MainScreen: View {
    
    @State private var readerSettings: ReaderSettings = ReaderSettingsStorage.shared.load()

    @State private var isShowingContents: Bool = false
    @State private var isShowingVocab: Bool = false
    @State private var isShowingAudio: Bool = false
    @State private var isShowingSettings: Bool = false
    
    @State private var wordInfoDetent = PresentationDetent.medium
    @State private var selectedWord: Word? = nil

    @ObservedObject private var mainViewModel: MainViewModel = MainViewModel()
    @ObservedObject private var readerViewModel: ReaderViewModel = ReaderViewModel()

    var body: some View {
        ZStack(alignment: .bottom) {
            ReaderView(
                viewModel: readerViewModel,
                settings: $readerSettings,
                onTapWord: { word in
                    selectedWord = word
                }
            )

            BottomBar(
                onTapContents: {
                    isShowingContents = true
                },
                onTapVocab: {
                    isShowingVocab = true
                },
                onTapAudio: {
                    isShowingAudio = true
                    
                },
                onTapSettings: {
                    isShowingSettings = true
                    
                }
            )
        }
        .onAppear {
            let startingRef = VerseRef.deserialize(from: UserDefaults().string(forKey: "verse_ref") ?? "0_1_1")
            readerViewModel.goToVerseRef(startingRef)
        }
        .sheet(isPresented: $isShowingContents) {
            TableofContents(
                onVerseRefSelected: { ref in
                    isShowingContents = false
                    readerViewModel.goToVerseRef(ref)
                },
                onDismiss: {
                    isShowingContents = false
                }
            )
        }
        .sheet(isPresented: $isShowingVocab) {
            VocabView(
                chapter: readerViewModel.verseRef,
                onDismiss: {
                    isShowingVocab = false
                }
            )
        }
        .sheet(isPresented: $isShowingAudio) {
            AudioView(
                chapter: readerViewModel.verseRef
            )
            .presentationDetents([.height(300)])
        }
        .sheet(
            isPresented: $isShowingSettings,
            onDismiss: {
                readerSettings = ReaderSettingsStorage.shared.load()
                isShowingSettings = false
            }
        ) {
            SettingsView(
                onDismiss: {
                    readerSettings = ReaderSettingsStorage.shared.load()
                    isShowingSettings = false
                }
            )
        }
        .sheet(item: $selectedWord) { selectedWord in
            let wordInfo = mainViewModel.getWordInfo(for: selectedWord.lexicalForm)
            let concordance = mainViewModel.getConcordance(for: selectedWord.lexicalForm)

            WordInfoView(selectedWord: selectedWord, wordInfo: wordInfo, concordance: concordance)
                .presentationDetents(
                    [.medium, .large],
                    selection: $wordInfoDetent
                )
        }
    }
}

private struct BottomBar: View {
    
    var onTapContents: () -> ()
    var onTapVocab: () -> ()
    var onTapAudio: () -> ()
    var onTapSettings: () -> ()
    
    var body: some View {
        VStack {
            BottomBarDivider()
            
            HStack(alignment: .center) {
                ContentsIcon(onTap: onTapContents)
                Spacer()
                VocabIcon(onTap: onTapVocab)
                Spacer()
                AudioIcon(onTap: onTapAudio)
                Spacer()
                SettingsIcon(onTap: onTapSettings)
            }
            .padding(.horizontal, 40)
            .frame(maxWidth: .infinity, minHeight: 50)
        }
        .background(.background)
    }
}

private struct ContentsIcon: View {
    
    var onTap: () -> ()
    
    var body: some View {
        BottomBarIcon(
            systemName: "list.bullet",
            width: 20,
            height: 24,
            aspectRatio: 1.25,
            onTap: onTap
        )
    }
}

private struct VocabIcon: View {
    
    var onTap: () -> ()
    
    var body: some View {
        BottomBarIcon(systemName: "a.circle", onTap: onTap)
    }
}

private struct AudioIcon: View {
    
    var onTap: () -> ()
    
    var body: some View {
        BottomBarIcon(systemName: "speaker.wave.2.fill", onTap: onTap)
    }
}

private struct SettingsIcon: View {
    
    var onTap: () -> ()
    
    var body: some View {
        BottomBarIcon(systemName: "gearshape.fill", onTap: onTap)
    }
}

private struct BottomBarIcon: View {
    
    var systemName: String

    var width: CGFloat = 20
    var height: CGFloat = 20
    var aspectRatio: CGFloat = 1
    
    var onTap: () -> ()
    
    var body: some View {
        Image(systemName: systemName)
            .resizable()
            .aspectRatio(aspectRatio, contentMode: .fit)
            .frame(
                width: width,
                height: height
            )
            .onTapGesture {
                onTap()
        }
    }
}


private struct BottomBarDivider: View {
    
    var body: some View {
        Divider()
            .frame(height: 1)
            .overlay(.gray)
    }
}
