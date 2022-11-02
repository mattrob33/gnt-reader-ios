//
//  WordInfoView.swift
//  GNT Reader
//
//  Created by Matt Robertson on 9/16/22.
//

import Foundation
import SwiftUI

struct WordInfoView: View {
    
    var selectedWord: Word
    var wordInfo: WordInfo?
    var concordance: [(VerseRef, String)]

    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                GlossView(
                    selectedWord: selectedWord,
                    wordInfo: wordInfo
                )
                
                ConcordanceView(concordance: concordance)
            }
            .padding(16)
        }
    }
}

struct GlossView: View {
    
    var selectedWord: Word
    var wordInfo: WordInfo?
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(selectedWord.lexicalForm)
                .font(.custom("Cardo", size: 22))
            
            if wordInfo != nil {
                Text(wordInfo!.gloss)
                    .font(.system(size: 18, design: .serif))
            }

            Text(selectedWord.parsing.humanReadable)
                .font(.system(size: 18, design: .serif))
                .italic()
            
            Divider()
        }
        .frame(
            maxWidth: .infinity,
            maxHeight: .infinity,
            alignment: .topLeading
        )
    }
}

struct ConcordanceView: View {
    
    var concordance: [(VerseRef, String)]
    
    var body: some View {
        
        VStack(alignment: .leading) {
            
            Text("Concordance")
                .font(.system(size: 20, design: .serif))
                .bold()
                .frame(maxWidth: .infinity, alignment: .center)
            
            Text("(\(concordance.count)x)")
                .font(.system(size: 18, design: .serif))
                .padding(.bottom, 16)
                .frame(maxWidth: .infinity, alignment: .center)
            
            ForEach(0 ..< concordance.count) { index in
                let entry = concordance[index]
                let ref = entry.0
                let verse = entry.1.split(separator: " ").map { words in
                    words.split(separator: "_")[0]
                }.joined(separator: " ")

                VStack(alignment: .leading) {
                    Text("\(index + 1). \(ref.book.title) \(ref.chapter):\(ref.verse!)")
                        .font(.system(size: 16, design: .serif))
                        .bold()
                    
                    Text(verse)
                        .font(.custom("Cardo", size: 20))
                }
                .padding(.bottom, 16)
            }
        }
        .frame(
            maxWidth: .infinity,
            maxHeight: .infinity,
            alignment: .topLeading
        )
    }
}
