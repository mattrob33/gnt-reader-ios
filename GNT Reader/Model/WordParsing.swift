//
//  WordParsing.swift
//  GNT Reader
//
//  Created by Matt Robertson on 8/22/21.
//

import Foundation

struct WordParsing {
    let humanReadable: String
    
    private init(humanReadable: String) {
        self.humanReadable = humanReadable
    }
    
    static func decode(codedParsing: String) -> WordParsing {
        return WordParsing(humanReadable: parse(codedParsing: codedParsing))
    }

    static func parse(codedParsing: String) -> String {
        let typeCode = codedParsing.prefix(2)
        switch typeCode {
            case "A-": return "Adj-" + String(codedParsing[6]) + String(codedParsing[8]) + String(codedParsing[7])
            case "C-": return "Conj"
            case "D-": return "Adv"
            case "N-": return "Noun-" + String(codedParsing[6]) + String(codedParsing[8]) + String(codedParsing[7])
            case "P-": return "Prep"
            case "RA": return "Art " + String(codedParsing[6]) + String(codedParsing[8]) + String(codedParsing[7])
            case "V-":
                var tense = String(codedParsing[3])
                if (tense == "P") { tense = "Pres." }
                if (tense == "I") { tense = "Impf." }
                if (tense == "F") { tense = "Fut." }
                if (tense == "A") { tense = "Aor." }
                if (tense == "X") { tense = "Pf." }
                if (tense == "Y") { tense = "Plu." }

                var voice = String(codedParsing[4])
                if (voice == "A") { voice = "Act." }
                if (voice == "M") { voice = "Mid." }
                if (voice == "P") { voice = "Pas." }

                var mood = String(codedParsing[5])
                switch mood {
                    case "P": return "Ptc. " + tense + " " + voice + " " + String(codedParsing[6]) + String(codedParsing[8]) + String(codedParsing[7])
                    case "N": return "Infv. $tense $voice"
                    default:
                        switch mood {
                            case "I": mood = "Ind."
                            case "D": mood = "Impv."
                            case "O": mood = "Opt."
                            default: ()
                        }
                        return "Vb. " + tense + " " + voice + " " + mood + " " + String(codedParsing[2]) + String(codedParsing[7])

                }

            case "X-", "I-": return "Particle"
            default: return "[parsing unavailable]"
        }
    }
}
