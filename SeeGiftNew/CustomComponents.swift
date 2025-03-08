//
//  CustomComponents.swift
//  SeeGiftNew
//
//  Created by Chris Rogers on 2/16/25.
//

import SwiftUI

struct CustomComponents: View {
    @State var isOn : Bool = false
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
        Button("PUSH ME") {}.buttonStyle(CloseButton())
        Toggle(isOn: $isOn, label: {
            Text("Mark As Most Wanted")
        }).toggleStyle(FavoritedToggleStyle())
        ScrollView (.horizontal, showsIndicators: false) {
        LazyHStack {
//            ForEach(testGiftList) {gift in
//                
//                Button(action: {
//                }) {
//                    ZStack(alignment: .topTrailing) {
//                        HStack{
//                            //                                Text("#\(gift.ranking)")
//                            Image(gift.image).resizable().cornerRadius(50).scaledToFit().frame(width: 200, height: 200)
//                            Spacer()
//                            VStack (alignment: .trailing){
//                                Text(gift.name)
//                                Text(gift.price, format: .currency(code: "USD"))
//                                //                                    Button(action: {
//                                //                                        currGift = gift
//                                //                                        showDescPopup.toggle()
//                                //                                        showList.toggle() //List and description popup should always be opposites
//                                //                                        print("Test?")
//                                //                                    }, label: {
//                                //                                        Text("Details")
//                                //                                    }).buttonStyle(BorderlessButtonStyle())
//                            }
//                        }.padding()
//                        Text("#\(gift.ranking)").padding()
//                    }
//                    
//                }.background(Color.yellow).foregroundStyle(.black).clipShape(RoundedRectangle(cornerRadius: 30))
//            }.listRowBackground(Color.black)
//            //LazyHStack {}
        }
    }
        
//        ScrollView (.horizontal) {
//        LazyHStack {
//            ForEach(testGiftList, id: \.self) {gift in
//                
//                Button(action: {
//                }) {
//                    ZStack(alignment: .topTrailing) {
//                        HStack{
//                            //                                Text("#\(gift.ranking)")
//                            Image(gift.image).resizable().cornerRadius(50).scaledToFit().frame(width: 200, height: 200)
//                            Spacer()
//                            VStack (alignment: .trailing){
//                                Text(gift.name)
//                                Text(gift.price, format: .currency(code: "USD"))
//                                //                                    Button(action: {
//                                //                                        currGift = gift
//                                //                                        showDescPopup.toggle()
//                                //                                        showList.toggle() //List and description popup should always be opposites
//                                //                                        print("Test?")
//                                //                                    }, label: {
//                                //                                        Text("Details")
//                                //                                    }).buttonStyle(BorderlessButtonStyle())
//                            }
//                        }.padding()
//                        Text("#\(gift.ranking)").padding()
//                    }
//                    
//                }.background(Color.yellow).foregroundStyle(.black).clipShape(RoundedRectangle(cornerRadius: 30))
//            }.listRowBackground(Color.black)
//            //LazyHStack {}
//        }
//    }
        
    }
}

struct LoadingView: View {
    var body: some View {
        ZStack {
            Color.blue
            VStack {
                Text("Loading...")
                ProgressView()
            }
        }
    }
}



struct CheckboxToggleStyle: ToggleStyle {
    func makeBody(configuration: Configuration) -> some View {
        HStack {
            configuration.label
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
        }
    }
}

struct FavoritedToggleStyle: ToggleStyle {
    func makeBody(configuration: Configuration) -> some View {
        HStack {
            configuration.label
            Image(systemName: configuration.isOn ? "star.fill" : "star").foregroundStyle(.yellow, .black).onTapGesture {
                withAnimation(.spring()) {
                    configuration.isOn.toggle()
                }
            }
        }
    }
}

//LABEL STYLES-----------------------------------------------

//Place icon on top of words vertically
struct VerticalLabelStyle: LabelStyle {
    @State var textColor: Color = .black
    @State var picColor: Color = .black
    func makeBody(configuration: Configuration) -> some View {
        VStack(alignment: .center, spacing: 8) {
            configuration.icon.foregroundStyle(picColor)
            configuration.title.foregroundStyle(textColor)
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
            Circle().fill(.yellow).frame(width: 25, height: 25)
            Image(systemName: "xmark")
                .foregroundColor(.black)
                .font(.system(size: 10))
        }
    }
}


#Preview {
    CustomComponents()
}
