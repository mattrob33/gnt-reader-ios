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
            Text(selectedWord.lexicalForm).font(.custom("Cardo", size: 22)) +
            Text(" (\(wordInfo?.occ ?? 0)x)").font(.system(size: 18, design: .serif))
            
            if wordInfo != nil {
                Text(wordInfo!.gloss).font(.system(size: 18, design: .serif))
            }

            Text(selectedWord.parsing.humanReadable)
                .font(.system(size: 18, design: .serif))
            
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
            
            ForEach(concordance, id: \.0) { entry in
                let ref = entry.0
                Text("\(ref.book.title) \(ref.chapter):\(ref.verse!)")
                    .font(.system(size: 18, design: .serif))
            }
        }
        .frame(
            maxWidth: .infinity,
            maxHeight: .infinity,
            alignment: .topLeading
        )
    }
}
