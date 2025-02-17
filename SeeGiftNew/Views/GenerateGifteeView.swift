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
         chris = UserAccount(firstName: "Chris", lastName: "Rogers", userName: "juice", spouse: "Brigette")
         brigette = UserAccount(firstName: "Brigette", lastName: "Rogers", userName: "brig", spouse: "Chris")
         collin = UserAccount(firstName: "Collin", lastName: "Rogers", userName: "cdrog", spouse: "Megan")
         meg = UserAccount(firstName: "Megan", lastName: "Rogers", userName: "megv", spouse: "Collin")
         Aaron = UserAccount(firstName: "Aaron", lastName: "Christopher", userName: "aaron", spouse: "")
        x24 = UserGroup(groupName: "X24", giftGivingCombos: [2023: [:], 2024: [collin.userName:brigette.userName], 2025: [:]], settings: GroupSettings(canCouplesMatch: true , canPairingsRepeat: true), currentYear: 2024)
        x24.members = [chris, brigette, collin, meg, Aaron]
        //remove prematched combos
        var initMatches = x24.giftGivingCombos[2024]?.values
        x24.availableGiftees = x24.members.filter( {!initMatches!.contains($0.userName)})
    }


//    x24.giftGivingCombos[2024]?[collin.userName] = brigette.userName
//    x24.members = [chris, brigette, collin, meg, Aaron]
//    x24.availableGiftees = x24.members
  
    var body: some View {
        VStack(spacing: 75) {
            Text("PUT THE GROUP NAME IN BIG LETTERS UP HERE MAYBE?")
            
            Button(action: { print("HI")
                x24.generateRandomGiftee(user: brigette)
                Giftee = (x24.giftGivingCombos[2024]?[brigette.userName]) ?? "ERROR"
//                print(Giftee)
                x24.generateRandomGiftee(user: chris)
                Giftee = (x24.giftGivingCombos[2024]?[chris.userName]) ?? "ERROR"
//                print(Giftee)
                x24.generateRandomGiftee(user: Aaron)
                Giftee = (x24.giftGivingCombos[2024]?[Aaron.userName]) ?? "ERROR"
//                print(Giftee)
                x24.generateRandomGiftee(user: collin)
                Giftee = (x24.giftGivingCombos[2024]?[collin.userName]) ?? "ERROR"
//                print(Giftee)
                x24.generateRandomGiftee(user: meg)
                Giftee = (x24.giftGivingCombos[2024]?[meg.userName]) ?? "ERROR"
                print(x24.giftGivingCombos[2024] ?? "Returned NIL")
                Timer.scheduledTimer(withTimeInterval: 3.0, repeats: false) { _ in showResult = true}})
            {
                ZStack {
                    Circle()
                    Label("Generate Your Giftee!", systemImage: "gift").foregroundStyle(.black)
                }
            }.contentShape(Circle())
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
