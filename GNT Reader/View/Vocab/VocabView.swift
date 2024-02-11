//
//  VocabView.swift
//  GNT Reader
//
//  Created by Matt Robertson on 2/10/24.
//

import Foundation
import SwiftUI
import Combine

struct VocabView: View {

    @ObservedObject private var viewModel: VocabViewModel = VocabViewModel()
    
    var chapter: VerseRef
    
    @State private var words: [String: [WordInfo]] = [:]
    
    private let sections = [">100", "51-100x", "31-50x", "21-30x", "16-20x", "11-15x", "6-10x", "2-5x", "1x"]
    
    @State private var anchoredSection: String = ""

    var onDismiss: () -> ()

    var body: some View {
        VStack {
            ZStack {
                Text("\(chapter.book.title) \(chapter.chapter)")
                    .font(.system(size: 22, design: .serif))
                    .frame(maxWidth: .infinity, alignment: .center)
                
                Image(systemName: "xmark")
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .trailing)
                    .onTapGesture { onDismiss() }
            }
            .frame(height: 50, alignment: .center)
            
            Divider()
            
            ChipsRowView(
                options: sections,
                onChangeSelection: { selected in
                    anchoredSection = selected
                }
            )
        
            ScrollViewReader { scroller in
                ScrollView {
                    ForEach(sections, id: \.self) { section in
                        if let sectionWords = words[section] {
                            Section(header: header(section).id(section)) {
                                ForEach(sectionWords, id: \.lex) { word in
                                    vocabRow(word)
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                        .padding(.vertical, 4)
                                        .padding(.leading, 20)
                                }
                            }
                        }
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .onAppear {
                    words = viewModel.getVocabWordsForChapter(ref: chapter)
                }
                .onChange(of: anchoredSection) { section in
                    scroller.scrollTo(section, anchor: .top)
                }
            }
        }
    }

    @ViewBuilder func vocabRow(_ word: WordInfo) -> some View {
        let lex = Text(word.lex).font(.custom("Cardo", size: 22))
        let gloss = Text(" - \(word.gloss)").font(.system(size: 20, design: .serif))
        let occ = Text(" (\(word.occ)x)").font(.system(size: 20, design: .serif))
        
        lex + gloss + occ
    }
    
    @ViewBuilder func header(_ title: String) -> some View {
        VStack {
            Text(title)
                .font(.system(size: 24))
                .foregroundStyle(Color.accentColor)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)

            Divider()
                .overlay(Color.accentColor)
                .frame(height: 2)
        }
        .padding(.leading, 20)
        .padding(.top, 20)
    }
    
}
