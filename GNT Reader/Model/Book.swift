//
//  Book.swift
//  GNT Reader
//
//  Created by Matt Robertson on 8/22/21.
//

import Foundation

struct Book {
    let num: Int
    let abbrv: String
    let title: String

    init(num: Int) {
        self.num = num
        abbrv = Book.abbrvs[num]
        title = Book.titles[num]
    }

    private static let abbrvs = [ "Matt", "Mark", "Luke", "John", "Acts", "Rom", "1 Cor", "2 Cor", "Gal", "Eph", "Phil", "Col", "1 Thess", "2 Thess", "1 Tim", "2 Tim", "Titus", "Phlm", "Heb", "James", "1 Pet", "2 Pet", "1 John", "2 John", "3 John", "Jude", "Rev" ]
    private static let titles = [ "Matthew", "Mark", "Luke", "John", "Acts", "Romans", "1 Corinthians", "2 Corinthians", "Galatians", "Ephesians", "Philippians", "Colossians", "1 Thessalonians", "2 Thessalonians", "1 Timothy", "2 Timothy", "Titus", "Philemon", "Hebrews", "James", "1 Peter", "2 Peter", "1 John", "2 John", "3 John", "Jude", "Revelation" ]
}
