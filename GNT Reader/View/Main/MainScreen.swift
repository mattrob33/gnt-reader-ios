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

    @ObservedObject private var mainViewModel: MainViewModel = MainViewModel()
    @ObservedObject private var readerViewModel: ReaderViewModel = ReaderViewModel()
    
    var body: some View {
        ZStack(alignment: .bottom) {
            ReaderView(viewModel: readerViewModel)
            HStack {
                Text("Contents")
                    .onTapGesture {
                        isShowingContents = true
                    }
            }
            .frame(maxWidth: .infinity, maxHeight: 40)
            .background(.gray)
        }
        .sheet(isPresented: $isShowingContents) {
            TableofContents(
                onVerseRefSelected: { ref in
                    readerViewModel.loadVersesForChapter(book: ref.book, chapter: ref.chapter)
                    isShowingContents = false
                }
            )
        }
    }
}
