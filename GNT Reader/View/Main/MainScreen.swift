//
//  MainScreen.swift
//  GNT Reader
//
//  Created by Matt Robertson on 9/16/22.
//

import Foundation
import SwiftUI

struct MainScreen: View {
    
    @State private var isShowingContents: Bool = false
    
    @State private var isShowingWordInfo: Bool = false
    @State private var wordInfoDetent = PresentationDetent.medium
    @State private var selectedWord: Word? = nil

    @ObservedObject private var mainViewModel: MainViewModel = MainViewModel()
    @ObservedObject private var readerViewModel: ReaderViewModel = ReaderViewModel()
    
    var body: some View {
        ZStack(alignment: .bottom) {
            ReaderView(
                viewModel: readerViewModel,
                onTapWord: { word in
                    selectedWord = word
                    isShowingWordInfo = true
                }
            )
            
            BottomBar(
                onTapContents: {
                    isShowingContents = true
                },
                onTapVocab: {},
                onTapAudio: {},
                onTapSettings: {}
            )
        }
        .sheet(isPresented: $isShowingContents) {
            TableofContents(
                onVerseRefSelected: { ref in
                    readerViewModel.loadVersesForChapter(ref: ref)
                    isShowingContents = false
                },
                onDismiss: {
                    isShowingContents = false
                }
            )
        }
        .sheet(isPresented: $isShowingWordInfo) {
            VStack(alignment: .leading) {
                if let selectedWord = selectedWord {
                    Text(selectedWord.lexicalForm)
                        .font(.custom("Cardo", size: 22))
                    Text(selectedWord.parsing.humanReadable)
                        .font(.system(size: 18, design: .serif))
                    
                    Divider()
                } else {
                    Text("No word selected")
                }
            }
            .frame(
                maxWidth: .infinity,
                maxHeight: .infinity,
                alignment: .topLeading
            )
            .padding(16)
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
                BottomBarIcon(systemName: "list.bullet", onTap: onTapContents)
                Spacer()
                BottomBarIcon(systemName: "a.circle", onTap: onTapVocab)
                Spacer()
                BottomBarIcon(systemName: "speaker.wave.2.fill", onTap: onTapAudio)
                Spacer()
                BottomBarIcon(systemName: "gearshape.fill", onTap: onTapSettings)
            }
            .padding(.horizontal, 40)
            .frame(maxWidth: .infinity, minHeight: 50)
        }
        .background(.background)
    }
}

private struct BottomBarIcon: View {
    
    var systemName: String
    var onTap: () -> ()
    
    var body: some View {
        Image(systemName: systemName)
            .resizable()
            .aspectRatio(1, contentMode: .fit)
            .frame(
                width: 20,
                height: 20
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
