//
//  StringExtensions.swift
//  GNT Reader
//
//  Created by Matt Robertson on 8/22/21.
//

import Foundation

extension StringProtocol {
    subscript(_ offset: Int)                     -> Element     { self[index(startIndex, offsetBy: offset)] }
    subscript(_ range: Range<Int>)               -> SubSequence { prefix(range.lowerBound+range.count).suffix(range.count) }
    subscript(_ range: ClosedRange<Int>)         -> SubSequence { prefix(range.lowerBound+range.count).suffix(range.count) }
    subscript(_ range: PartialRangeThrough<Int>) -> SubSequence { prefix(range.upperBound.advanced(by: 1)) }
    subscript(_ range: PartialRangeUpTo<Int>)    -> SubSequence { prefix(range.upperBound) }
    subscript(_ range: PartialRangeFrom<Int>)    -> SubSequence { suffix(Swift.max(0, count-range.lowerBound)) }
    
    func trim() -> String { self.trimmingCharacters(in: .whitespacesAndNewlines) }
}

func base64encode(_ str: String) -> String? {
    let utf8str = str.data(using: .utf8)
    if let base64Encoded = utf8str?.base64EncodedString(options: Data.Base64EncodingOptions(rawValue: 0)) {
        return base64Encoded
    }
    return nil
}

func base64decode(_ encoded: String) -> String? {
    if let base64Decoded = Data(base64Encoded: encoded, options: Data.Base64DecodingOptions(rawValue: 0))
        .map({ String(data: $0, encoding: .utf8) }) {
            return base64Decoded ?? ""
        }
    
    return nil
}
