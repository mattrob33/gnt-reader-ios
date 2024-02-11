//
//  VocabViewModel.swift
//  GNT Reader
//
//  Created by Matt Robertson on 2/10/24.
//

import Foundation

class VocabViewModel: ObservableObject {
    
    private let wordInfoDataSource = SqliteWordInfoDataSource()

    func getVocabWordsForChapter(ref: VerseRef) -> [String : [WordInfo]] {
        let words = wordInfoDataSource.getVocabWordsForChapter(ref)
        
        let mappedWords = Dictionary(grouping: words) { word in
            switch word.occ {
            case 101...Int.max:
                return ">100"
            case 51...100:
                return "51-100x"
            case 31...50:
                return "31-50x"
            case 21...30:
                return "21-30x"
            case 16...20:
                return "16-20x"
            case 11...15:
                return "11-15x"
            case 6...10:
                return "6-10x"
            case 2...5:
                return "2-5x"
            default:
                return "1x"
            }
        }

        return mappedWords
    }
}
