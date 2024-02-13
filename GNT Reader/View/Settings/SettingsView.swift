//
//  SettingsView.swift
//  GNT Reader
//
//  Created by Matt Robertson on 2/12/24.
//

import Foundation
import SwiftUI

struct SettingsView: View {

    @ObservedObject var viewModel: SettingsViewModel = SettingsViewModel()

    var onDismiss: () -> ()
    
    var body: some View {
        ScrollView {
            VStack {
                topBar(onDismiss)
                
                ReaderPreview(settings: viewModel.settings)
                
                fontSize(fontSize: $viewModel.fontSize)
                lineSpacing(lineSpacing: $viewModel.lineSpacing)
                font(font: $viewModel.font)
                verseNumbers(showVerseNumbers: $viewModel.showVerseNumbers)
                versesOnSeparateLines(versesOnSeparateLines: $viewModel.versesOnSeparateLines)
            }
        }
        .padding()
    }

    @ViewBuilder
    private func topBar(_ onDismiss: @escaping () -> ()) -> some View {
        ZStack {
            Text("Settings")
                .font(.system(size: 22, design: .serif))
                .frame(maxWidth: .infinity, alignment: .center)
            
            Image(systemName: "xmark")
                .padding()
                .frame(maxWidth: .infinity, alignment: .trailing)
                .onTapGesture { onDismiss() }
        }
        .frame(height: 50, alignment: .center)
        
        Divider()
    }
    
    @ViewBuilder
    private func fontSize(fontSize: Binding<Float>) -> some View {
        VStack {
            Text("Font Size")
                .font(.headline)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            Slider(
                value: fontSize,
                in: 18...36,
                step: 2
            )
        }
        .padding()
    }
    
    @ViewBuilder
    private func lineSpacing(lineSpacing: Binding<Float>) -> some View {
        VStack {
            Text("Line Spacing")
                .font(.headline)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            Slider(
                value: lineSpacing,
                in: 18...48,
                step: 2
            )
        }
        .padding()
    }
    
    @ViewBuilder
    private func font(font: Binding<ReaderFont>) -> some View {
        HStack {
            Text("Font")
                .font(.headline)
            
            Spacer()
            
            Picker("Font", selection: font) {
                ForEach(ReaderFont.allCases) { font in
                    Text(font.rawValue.capitalized)
                }
            }
        }
        .padding()
    }
    
    @ViewBuilder
    private func verseNumbers(showVerseNumbers: Binding<Bool>) -> some View {
        HStack {
            Text("Show verse numbers")
                .font(.headline)
            
            Spacer()
            
            Toggle("Show verse numbers", isOn: showVerseNumbers)
                .labelsHidden()
                .toggleStyle(SwitchToggleStyle(tint: .accentColor))
                .padding(.horizontal, 20)
        }
        .padding()
    }
    
    @ViewBuilder
    private func versesOnSeparateLines(versesOnSeparateLines: Binding<Bool>) -> some View {
        HStack {
            Text("Verses on separate lines")
                .font(.headline)
            
            Spacer()
            
            Toggle("Show verses on separate lines", isOn: versesOnSeparateLines)
                .labelsHidden()
                .toggleStyle(SwitchToggleStyle(tint: .accentColor))
                .padding(.horizontal, 20)
        }
        .padding()
    }
    
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView(
            onDismiss: { }
        )
    }
}
