//
//  ReaderView.swift
//  GNT Reader
//
//  Created by Matt Robertson on 8/22/21.
//

import Foundation
import SwiftUI

struct ReaderView: View {

    @ObservedObject var viewModel: ViewModel = ViewModel()

    var body: some View {
        Group {
            VersesTextView(verses: self.viewModel.verses)
        }
        .padding()
        .onAppear {
            self.viewModel.loadVersesForChapter(book: Book(0), chapter: 1)
        }
    }
}

struct ReaderView_Previews: PreviewProvider {
    static var previews: some View {
        ReaderView()
    }
}

struct VersesTextView: View {
    var verses: [Verse]
    
    @State private var tappedWord: String = "[none]"
    
    var body: some View {
        VStack {
            Text("Tapped word: \(tappedWord)").padding()
            
            verses.map { verse in
                getVerseText(verse)
            }
            .reduce(Text(""), +)
            .tint(.white)
        }
        .onOpenURL { url in
            let wordIndex = url.absoluteString.index(url.absoluteString.startIndex, offsetBy: 4)
            tappedWord = base64decode(String(url.absoluteString[wordIndex...].utf8)!)!
        }
    }

    private func getVerseText(_ verse: Verse) -> Text {
        var text = Text("\(verse.verseRef.verse!)\u{00a0}").superscript()
        text = text + verse.words.map { word in
            getWordText(word)
        }.reduce(Text(""), +)
        return text
    }

    private func getWordText(_ word: Word) -> Text {
        let url = "gnt:\(base64encode(word.lexicalForm)!)"
        let markdown = try! AttributedString(markdown: "[\(word.text)](\(url))")
        return Text("\(markdown) ").regularText()
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
