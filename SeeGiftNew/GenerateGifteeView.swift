//
//  SwiftUIView.swift
//  SeeGiftNew
//
//  Created by Chris Rogers on 1/22/25.
//

import SwiftUI



struct GenerateGifteeView: View {
    @State var Giftee: String = "Chris"
    @State var showResult: Bool = false
    
    var chris = UserAccount(firstName: "Chris", lastName: "Rogers", userName: "juice", spouse: "Brigette")
    var brigette = UserAccount(firstName: "Brigette", lastName: "Rogers", userName: "brig", spouse: "Chris")
    var collin = UserAccount(firstName: "Collin", lastName: "Rogers", userName: "cdrog", spouse: "Megan")
    var meg = UserAccount(firstName: "Megan", lastName: "Rogers", userName: "megv", spouse: "Collin")
    var Aaron = UserAccount(firstName: "Aaron", lastName: "Christopher", userName: "aaron", spouse: "")
    
    var x24: UserGroup
    init() {
        x24 = UserGroup(groupName: "X24", giftGivingCombos: [2023: [:], 2024: [collin.userName:brigette.userName], 2025: [:]], settings: GroupSettings(canCouplesMatch: true , canPairingsRepeat: true), currentYear: 2024)
        x24.members = [chris, brigette, collin, meg, Aaron]
        x24.availableGiftees = x24.members
    }


//    x24.giftGivingCombos[2024]?[collin.userName] = brigette.userName
//    x24.members = [chris, brigette, collin, meg, Aaron]
//    x24.availableGiftees = x24.members
  
    var body: some View {
        VStack(spacing: 75) {
            Text("PUT THE GROUP NAME IN BIG LETTERS UP HERE MAYBE?")
            
            Button(action: { print("HI")
                x24.generateRandomGiftee(user: brigette)
                Giftee = (x24.giftGivingCombos[2024]?[brigette.userName])!
                print(Giftee)
                Timer.scheduledTimer(withTimeInterval: 3.0, repeats: false) { _ in showResult = true}})
            {
                ZStack {
                    Circle().frame(width: 350, height: 350).background(Color.blue).cornerRadius(360)
                    Label("Generate Your Giftee!", systemImage: "gift").foregroundStyle(.white)
                }
            }
            if (showResult) {
                Text("You Got: \(Giftee)!") //This is string literal notation
                //Text("You Got: " + Giftee) //This is normal notation i usually use
            }
        }
        .padding()
    }
}


#Preview {
    GenerateGifteeView()
}
