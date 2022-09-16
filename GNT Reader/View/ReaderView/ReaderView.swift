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
    
    var body: some View {
        verses.map { verse in
            Text("\(verse.verseRef.verse!)\u{00a0}").superscript() +

            verse.words.map { word in
                Text("\(word.text) ").regularText()
            }.reduce(Text(""), +)

        }.reduce(Text(""), +)
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
