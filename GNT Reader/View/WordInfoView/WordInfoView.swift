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
        .padding(16)
    }
}
