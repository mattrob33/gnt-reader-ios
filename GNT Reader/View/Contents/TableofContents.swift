//
//  TableofContents.swift
//  GNT Reader
//
//  Created by Matt Robertson on 9/16/22.
//

import Foundation
import SwiftUI

struct TableofContents: View {
    
    var onVerseRefSelected: (VerseRef) -> ()
    
    var body: some View {
        ScrollView {
            VStack {
                ForEach(0..<27, id: \.self) { bookId in
                    Text(Book.titles[bookId])
                        .font(.system(size: 22))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.vertical, 4)
                        .padding(.leading, 20)
                        .onTapGesture {
                            onVerseRefSelected(
                                VerseRef(book: Book(bookId), chapter: 1, verse: 1)
                            )
                        }
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
    }
}
