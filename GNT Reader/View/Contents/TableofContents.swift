//
//  TableofContents.swift
//  GNT Reader
//
//  Created by Matt Robertson on 9/16/22.
//

import Foundation
import SwiftUI

private enum ContentsMode {
    case Book
    case Chapter
}

struct TableofContents: View {
    
    var onVerseRefSelected: (VerseRef) -> ()
    var onDismiss: () -> ()
    
    @State private var mode: ContentsMode = .Book
    @State private var book: Book = Book(0)
    
    var body: some View {
        switch mode {
        case .Book:
            TableofContentsBook(
                onBookSelected: {
                    book = $0
                    mode = .Chapter
                },
                onDismiss: {
                    onDismiss()
                }
            )
        case .Chapter:
            TableofContentsChapter(
                book: book,
                onVerseRefSelected: { ref in
                    onVerseRefSelected(ref)
                },
                onBack: {
                    mode = .Book
                },
                onDismiss: {
                    onDismiss()
                }
            )
        }
    }
}

struct TableofContentsBook: View {
    
    var onBookSelected: (Book) -> ()
    var onDismiss: () -> ()
    
    var body: some View {
        ScrollView {
            VStack {
                ZStack {
                    Text("Contents")
                        .font(.system(size: 22, design: .serif))
                        .frame(maxWidth: .infinity, alignment: .center)
                    
                    Image(systemName: "xmark")
                        .padding()
                        .frame(maxWidth: .infinity, alignment: .trailing)
                        .onTapGesture { onDismiss() }
                }
                .frame(height: 50, alignment: .center)
                
                Divider()

                ForEach(0..<27, id: \.self) { bookId in
                    Text(bookTitles[bookId])
                        .font(.system(size: 20, design: .serif))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.vertical, 4)
                        .padding(.leading, 20)
                        .onTapGesture {
                            onBookSelected(Book(bookId))
                        }
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
    }
}

struct TableofContentsChapter: View {
    
    var book: Book
    
    var onVerseRefSelected: (VerseRef) -> ()
    var onBack: () -> ()
    var onDismiss: () -> ()
    
    var body: some View {
        ScrollView {
            VStack {
                ZStack {
                    Text("Contents")
                        .font(.system(size: 22, design: .serif))
                        .frame(maxWidth: .infinity, alignment: .center)
                    
                    Image(systemName: "xmark")
                        .padding()
                        .frame(maxWidth: .infinity, alignment: .trailing)
                        .onTapGesture { onDismiss() }
                }
                .frame(height: 50, alignment: .center)
                
                Divider()
                
                HStack {
                    Image(systemName: "chevron.backward")
                    Text("\(bookTitles[book.num])")
                        .font(.system(size: 18, design: .serif))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .onTapGesture {
                            onBack()
                        }
                }
                .padding()
                
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 50, maximum: 80))]) {
                    ForEach(1...verseCounts[book.num].count, id: \.self) { chapter in
                        Text("\(chapter)")
                            .font(.system(size: 20, design: .serif))
                            .padding()
                            .onTapGesture {
                                onVerseRefSelected(
                                    VerseRef(book: book, chapter: chapter, verse: 1)
                                )
                            }
                    }
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
    }
}
