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
    
    var onTapWord: (Word) -> ()

    var body: some View {
        Group {
            VersesTextView(
                viewModel: viewModel,
                verses: self.viewModel.verses,
                onTapWord: onTapWord
            )
        }
        .padding()
    }
}

struct ReaderView_Previews: PreviewProvider {
    static var previews: some View {
        ReaderView(onTapWord: { word in})
    }
}

struct VersesTextView: View {
    
    var viewModel: ReaderViewModel
    
    var verses: [Verse]
    
    var onTapWord: (Word) -> ()
    
    var body: some View {
        VStack {
            getChapterText(verses, forRef: viewModel.verseRef)
        }
        .onOpenURL { url in
            let wordIndex = url.absoluteString.index(url.absoluteString.startIndex, offsetBy: 4)
            let wordId = String(url.absoluteString[wordIndex...].utf8)!
            
            let word = viewModel.getWord(byId: Int(wordId)!)!
            onTapWord(word)
        }
    }

    private func getChapterText(_ verses: [Verse], forRef ref: VerseRef) -> some View {
        var versesText = Text("")
        for verse in verses {
            versesText = versesText + getVerseText(verse)
        }
        
        return ScrollView {
            versesText
                .font(.custom("Cardo", size: 22))
                .lineSpacing(12)
                .tint(.white)
        }
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
