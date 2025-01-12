//
//  Code.swift
//  SeeGift
//
//  Created by Chris Rogers on 1/12/25.
//

class UserAccount {
    var firstName: String = "Test"
    var lastName: String = "Account"
    var userName: String = "TestAccount" //This needs to be unique
    var password: String = "Password"
    var spouse = ""
    //var profilePicture: Image?
    //Profile PIcture maybe? Not sure how to do this yet obviously
    var giftsList: [Gift] = []
    var friendsList: [UserAccount] = []
    var isUserPublic: Bool = false
    var isFriendsListPublic: Bool = false //Enum with choices here possibly as well
    //Total price of gifts so that we can let gifter know that they can get all the gifts and still be under budget for their giftee. Thanks autocomplete!
    var totalGiftValue: Double {
        giftsList.reduce(0) { $0 + $1.price }
    }
    var gifteeList: [UserAccount] = []
    
    func addGiftToList(_ gift: Gift) {
        giftsList.append(gift)
    }
    
    func removeGiftFromList(_ gift: Gift) {
        giftsList.removeAll { $0.name == gift.name }
    }
    
    func addFriendToList(_ friend: UserAccount) {
        friendsList.append(friend)
    }
    
    func removeFriendFromList(_ friend: UserAccount) {
        friendsList.removeAll { $0.userName == friend.userName }
    }
    
    func connectSpouseToAccount(_ spouse: UserAccount) {
        self.spouse = spouse.userName
    }
}

//I should be able to extend useraccount somehow i just dont know how yet. Just allow gifter to see what they need to see and thats it
//struct Giftee {
//    var firstName: String
//    var lastName: String
//    var userName: String
//    var giftsList: [Gift] = []
//}

struct Gift {
    var name: String = "MISSING NAME"
    var price: Double = 0
    var description: String = ""
    //var image: Image
    var link: String = ""
    var ranking: Int = 0
    var isGifted: Bool = false
    
//    init(name: String = "MISSING NAME", price: Double = 0, description: String = "", link: String = "", ranking: Int = 0) {
//        self.name = name
//        self.price = price
//        self.description = description
//        self.link = link
//        self.ranking = ranking
//    }
}

struct GiftPairings {
    var year: Int
    var pairings: [String: String] //This will be [UserAccount.userName: UserAccount.userName], for example ["Chris": "Brigette"]
    //Key-Value pairs for the matchups from this year
}

class UserGroup {
    var groupName: String = "Test Group"
    var Members: [UserAccount] = []
    var groupType: String = "Friend" //Family or Friend...probably use an enum here actually
    var giftGivingCombos: [Int: [String: String]] = [:]
    var settings: GroupSettings = GroupSettings()
    var currentYear: Int = 2025
    func randomizeGiftee() {
        if (settings.canCouplesMatch) {
            if(settings.canPairingsRepeat) {
                //No limitations so just randomize
                let randomizedGifter = Members.randomElement()!.userName
                var tempMemberList = Members
                tempMemberList.removeAll { $0.userName == randomizedGifter }
                let randomizedGiftee = tempMemberList.randomElement()!.userName
                giftGivingCombos[currentYear]![randomizedGifter] = randomizedGiftee
            }
            else {
                print("NEED TO IMPLEMENT INSIDE SETTINGS.CANPAIRINGSREPEAT")
            }
        }
        else if (settings.canPairingsRepeat) {
            //No couples but previous pairings is fine
            let randomizedGifter = Members.randomElement()!
            var tempMemberList = Members
            tempMemberList.removeAll { ($0.userName == randomizedGifter.userName) || $0.userName == randomizedGifter.spouse }
            let randomizedGiftee = tempMemberList.randomElement()!.userName
            giftGivingCombos[currentYear]![randomizedGifter.userName] = randomizedGiftee
        }
        //TODO: Implement logic for when no repeats and no spouses are chosen
        
    }
}

struct GroupSettings {
    var canCouplesMatch: Bool = false //Can couples get each other
    var canPairingsRepeat: Bool = false //Can we repeat a pairing from previous years
    var isWhiteElephant: Bool = false
    var priceLimit: Double = 0
}

var newGift = Gift(description: "GIFT")

