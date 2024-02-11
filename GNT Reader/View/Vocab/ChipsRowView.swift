//
//  ChipsRowView.swift
//  GNT Reader
//
//  Created by Matt Robertson on 2/10/24.
//

import Foundation
import SwiftUI

struct ChipsRowView: View {

    var options: [String]

    var onChangeSelection: (String) -> ()

    @State private var selected: String
    
    init(options: [String], onChangeSelection: @escaping (String) -> Void) {
        self.options = options
        self.onChangeSelection = onChangeSelection
        self.selected = options.first ?? ""
    }

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                ForEach(options, id: \.self) { option in
                    ChipView(
                        text: option,
                        isSelected: selected == option,
                        onTap: {
                            selected = option
                            onChangeSelection(option)
                        }
                    )
                }
            }
            .padding(.horizontal, 20)
            .padding(.vertical, 20)
        }
    }
}

struct ChipView: View {

    var text: String

    var isSelected: Bool
    
    var onTap: () -> ()

    var body: some View {
        Text(text)
            .padding(.vertical, 8)
            .padding(.horizontal, 16)
            .foregroundColor(isSelected ? .white : .accentColor)
            .background(isSelected ? Color.accentColor : Color.clear)
            .cornerRadius(20)
            .overlay(
                RoundedRectangle(cornerRadius: 20)
                    .stroke(Color.blue, lineWidth: 1.5)
                
            )
            .onTapGesture {
                onTap()
            }
    }
}

