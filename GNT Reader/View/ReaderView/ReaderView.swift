//
//  ReaderView.swift
//  GNT Reader
//
//  Created by Matt Robertson on 8/22/21.
//

import Foundation
import SwiftUI

struct ReaderView: View {

    @ObservedObject var viewModel: ReaderViewModel = ReaderViewModel()
    
    @Binding var settings: ReaderSettings

    var onTapWord: (Word) -> ()
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack {
                ChapterTextView(
                    viewModel: viewModel,
                    settings: settings,
                    chapterRef: viewModel.verseRef,
                    verses: viewModel.getVersesForChapter(ref: viewModel.verseRef),
                    onTapWord: onTapWord
                )
                
                Spacer().frame(height: 400)
            }
        }
        .padding()
    }
}


struct ChapterTextView: View {

    @Environment(\.verticalSizeClass) var verticalSizeClass: UserInterfaceSizeClass?
    @Environment(\.horizontalSizeClass) var horizontalSizeClass: UserInterfaceSizeClass?

    var viewModel: ReaderViewModel
    
    var settings: ReaderSettings
    
    var chapterRef: VerseRef
    
    var verses: [Verse]
    
    var onTapWord: (Word) -> ()
    
    var body: some View {
        getChapterText(
            verses,
            forRef: chapterRef,
            isIpad: (verticalSizeClass == .regular && horizontalSizeClass == .regular)
        )
        .onOpenURL { url in
            let wordIndex = url.absoluteString.index(url.absoluteString.startIndex, offsetBy: 4)
            let wordId = String(url.absoluteString[wordIndex...].utf8)!
            
            let word = viewModel.getWord(byId: wordId)!
            onTapWord(word)
        }
    }

    private func getChapterText(_ verses: [Verse], forRef ref: VerseRef, isIpad: Bool) -> some View {
        var versesText = Text("")
        
        for verse in verses {
            versesText = versesText + getVerseText(verse)
        }
        
        return VStack {
            if ref.chapter == 1 {
                Text("\(bookTitles[ref.book.num])")
                    .font(.custom(settings.font.fontName(), size: CGFloat(settings.fontSize)))
                    .padding(.vertical, 16)
            }
            
            Text("\(ref.chapter)")
                .font(.custom(settings.font.fontName(), size: CGFloat(settings.fontSize)))
                .lineSpacing(CGFloat(settings.lineSpacing))
                .padding()
                .border(.foreground)
            
            versesText
                .font(.custom(settings.font.fontName(), size: CGFloat(settings.fontSize)))
                .lineSpacing(isIpad ? 18 : 12)
                .tint(.primary)
        }
        .padding(.horizontal, isIpad ? 60 : 0)
    }

    private func getVerseText(_ verse: Verse) -> Text {
        var text = Text("\(verse.verseRef.verse!)\u{00a0}").superscript()
        for word in verse.words {
            text = text + getWordText(word)
        }
        return text
    }

    private func getWordText(_ word: Word) -> Text {
        let url = "gnt:\(word.wordId)"
        let markdown = try! AttributedString(markdown: "[\(word.text)](\(url))")
        return Text("\(markdown) ")
    }
}

extension Text {
    func regularText() -> Text {
        return self.font(.system(size: 20))
    }
    
    func superscript() -> Text {
        let fontSize = 12
        let baseOffset: Float = Float(fontSize) * 5.0 / 10.0
        return self.font(.system(size: CGFloat(fontSize))).baselineOffset(CGFloat(baseOffset))
    }
}
