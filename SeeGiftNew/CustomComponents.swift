//
//  CustomComponents.swift
//  SeeGiftNew
//
//  Created by Chris Rogers on 2/16/25.
//

import SwiftUI

struct CustomComponents: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
        Button("PUSH ME") {}.buttonStyle(CloseButton())
    }
}

struct CheckboxToggleStyle: ToggleStyle {
    func makeBody(configuration: Configuration) -> some View {
        HStack {

            RoundedRectangle(cornerRadius: 5.0)
                .stroke(lineWidth: 2)
                .frame(width: 25, height: 25)
                .cornerRadius(5.0)
                .overlay {
                    Image(systemName: configuration.isOn ? "checkmark" : "")
                }
                .onTapGesture {
                    withAnimation(.spring()) {
                        configuration.isOn.toggle()
                    }
                }

            configuration.label

        }
    }
}

//LABEL STYLES-----------------------------------------------

//Place icon on top of words vertically
struct VerticalLabelStyle: LabelStyle {
    func makeBody(configuration: Configuration) -> some View {
        VStack(alignment: .center, spacing: 8) {
            configuration.icon
            configuration.title
        }
    }
}

//Still horizontal label but words come before icon
struct FlippedLabelStyle: LabelStyle {
    @State var textColor: Color = .black
    @State var picColor: Color = .black
    func makeBody(configuration: Configuration) -> some View {
        HStack(alignment: .center, spacing: 8) {
            configuration.title.foregroundStyle(textColor)
            configuration.icon.foregroundStyle(picColor)
        }
    }
}

//Close button as a circle with an x inside it
struct CloseButton: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        ZStack {
            Circle().fill(.blue).frame(width: 15, height: 15)
            Image(systemName: "xmark")
                .foregroundColor(.black)
                .font(.system(size: 10))
        }
    }
}

#Preview {
    CustomComponents()
}
