//
//  ReaderPreview.swift
//  GNT Reader
//
//  Created by Matt Robertson on 2/12/24.
//

import Foundation
import SwiftUI

struct ReaderPreview: View {
    
    let settings: ReaderSettings
    
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            getPreviewTextView(settings)
                .foregroundStyle(Color.primary)
                .font(.custom(settings.font.fontName(), size: CGFloat(settings.fontSize)))
                .lineSpacing(CGFloat(settings.lineSpacing))
                .padding()
        }
        .border(Color.primary)
        .padding()
        .frame(maxHeight: 300)
    }
    
    private func getPreviewText() -> AttributedString {
        let text = previewVerses
            .map { "\($0.verseNum) \($0.text)" }
            .joined(separator: " ")

        return AttributedString(text)
    }
    
    private func getPreviewTextView(_ settings: ReaderSettings) -> Text {
        let verseTexts: [Text] = previewVerses.map { verse in
            Text(settings.showVerseNumbers ? "\(verse.verseNum)\u{00A0}" : "").superscript() +
                Text("\(verse.text) \( settings.versesOnSeparateLines ? "\n" : "" )")
        }

        let combinedText: Text = verseTexts.reduce(Text("")) { (result, verseText) in
            result + verseText
        }
        
        return combinedText
    }
}

struct ReaderPreview_Previews: PreviewProvider {
    static var previews: some View {
        ReaderPreview(settings: ReaderSettings.getDefault())
    }
}


private class PreviewVerse {
    let verseNum: Int
    let text: String
    
    init(_ verseNum: Int, _ text: String) {
        self.verseNum = verseNum
        self.text = text
    }
}

private let previewVerses = [
    PreviewVerse(1, "Ἐν ἀρχῇ ἦν ὁ λόγος, καὶ ὁ λόγος ἦν πρὸς τὸν θεόν, καὶ θεὸς ἦν ὁ λόγος."),
    PreviewVerse(2, "οὗτος ἦν ἐν ἀρχῇ πρὸς τὸν θεόν."),
    PreviewVerse(3, "πάντα δι’ αὐτοῦ ἐγένετο, καὶ χωρὶς αὐτοῦ ἐγένετο οὐδὲ ἕν. ὃ γέγονεν"),
    PreviewVerse(4, "ἐν αὐτῷ ζωὴ ἦν, καὶ ἡ ζωὴ ἦν τὸ φῶς τῶν ἀνθρώπων ·"),
    PreviewVerse(5, "καὶ τὸ φῶς ἐν τῇ σκοτίᾳ φαίνει, καὶ ἡ σκοτία αὐτὸ οὐ κατέλαβεν."),
    PreviewVerse(6, "Ἐγένετο ἄνθρωπος ἀπεσταλμένος παρὰ θεοῦ, ὄνομα αὐτῷ Ἰωάννης ·"),
    PreviewVerse(7, "οὗτος ἦλθεν εἰς μαρτυρίαν, ἵνα μαρτυρήσῃ περὶ τοῦ φωτός, ἵνα πάντες πιστεύσωσιν δι’ αὐτοῦ."),
    PreviewVerse(8, "οὐκ ἦν ἐκεῖνος τὸ φῶς, ἀλλ’ ἵνα μαρτυρήσῃ περὶ τοῦ φωτός."),
    PreviewVerse(9, "ἦν τὸ φῶς τὸ ἀληθινὸν ὃ φωτίζει πάντα ἄνθρωπον ἐρχόμενον εἰς τὸν κόσμον."),
    PreviewVerse(10, "Ἐν τῷ κόσμῳ ἦν, καὶ ὁ κόσμος δι’ αὐτοῦ ἐγένετο, καὶ ὁ κόσμος αὐτὸν οὐκ ἔγνω."),
    PreviewVerse(11, "εἰς τὰ ἴδια ἦλθεν, καὶ οἱ ἴδιοι αὐτὸν οὐ παρέλαβον."),
    PreviewVerse(12, "ὅσοι δὲ ἔλαβον αὐτόν, ἔδωκεν αὐτοῖς ἐξουσίαν τέκνα θεοῦ γενέσθαι, τοῖς πιστεύουσιν εἰς τὸ ὄνομα αὐτοῦ,"),
    PreviewVerse(13, "οἳ οὐκ ἐξ αἱμάτων οὐδὲ ἐκ θελήματος σαρκὸς οὐδὲ ἐκ θελήματος ἀνδρὸς ἀλλ’ ἐκ θεοῦ ἐγεννήθησαν."),
    PreviewVerse(14, "Καὶ ὁ λόγος σὰρξ ἐγένετο καὶ ἐσκήνωσεν ἐν ἡμῖν, καὶ ἐθεασάμεθα τὴν δόξαν αὐτοῦ, δόξαν ὡς μονογενοῦς παρὰ πατρός, πλήρης χάριτος καὶ ἀληθείας ·"),
    PreviewVerse(15, "Ἰωάννης μαρτυρεῖ περὶ αὐτοῦ καὶ κέκραγεν λέγων · Οὗτος ἦν ὃν εἶπον ⸃· Ὁ ὀπίσω μου ἐρχόμενος ἔμπροσθέν μου γέγονεν, ὅτι πρῶτός μου ἦν ·)"),
    PreviewVerse(16, "ὅτι ἐκ τοῦ πληρώματος αὐτοῦ ἡμεῖς πάντες ἐλάβομεν, καὶ χάριν ἀντὶ χάριτος ·"),
    PreviewVerse(17, "ὅτι ὁ νόμος διὰ Μωϋσέως ἐδόθη, ἡ χάρις καὶ ἡ ἀλήθεια διὰ Ἰησοῦ Χριστοῦ ἐγένετο."),
    PreviewVerse(18, "θεὸν οὐδεὶς ἑώρακεν πώποτε · μονογενὴς θεὸς ⸃ ὁ ὢν εἰς τὸν κόλπον τοῦ πατρὸς ἐκεῖνος ἐξηγήσατο.")
]
