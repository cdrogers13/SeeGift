//
//  Code.swift
//  SeeGift
//
//  Created by Chris Rogers on 1/12/25.
//

import Foundation

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
    
    init(firstName: String = "Test", lastName: String = "Account", userName: String = "TestAccount", password: String = "Password", spouse: String = "", giftsList: [Gift] = [], friendsList: [UserAccount] = [], isUserPublic: Bool = false, isFriendsListPublic: Bool = false, gifteeList: [UserAccount] = []) {
        self.firstName = firstName
        self.lastName = lastName
        self.userName = userName
        self.password = password
        self.spouse = spouse
        self.giftsList = giftsList
        self.friendsList = friendsList
        self.isUserPublic = isUserPublic
        self.isFriendsListPublic = isFriendsListPublic
        self.gifteeList = gifteeList
    }
    func addGiftToList(_ gift: inout Gift) {
        if (giftsList.contains(where: {$0.giftID == gift.giftID})) {
            gift.giftID = Int.random(in: 1...1000000000)
        }
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
    var giftID: Int = Int.random(in: 0...1000000000)
    
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
    var groupName: String
    var groupAdmins: [UserAccount]
    var members: [UserAccount]
    var groupType: String //Family or Friend...probably use an enum here actually
    var giftGivingCombos: [Int: [String: String]] = [:]
    var settings: GroupSettings
    var currentYear: Int
    var availableGiftees: [UserAccount]
    //var takenGiftees: [String] = [] //This will be user name of people taken in the group already
    
    init(groupName: String = "Test Group", members: [UserAccount] = [], groupAdmins: [UserAccount] = [], groupType: String = "Friend", giftGivingCombos: [Int : [String : String]] = [:], settings: GroupSettings = GroupSettings(), currentYear: Int, availableGiftees: [UserAccount] = []) {
        self.groupName = groupName
        self.members = members
        self.groupAdmins = groupAdmins
        self.groupType = groupType
        self.giftGivingCombos[currentYear] = [:]
        self.settings = settings
        self.currentYear = currentYear
        self.availableGiftees = availableGiftees
    }
    
    func isAdmin(_ user: UserAccount) -> Bool {
        groupAdmins.contains(where: {$0.userName == user.userName})
    }
    func addMember(_ member: UserAccount) {
        members.append(member);
        availableGiftees.append(member);
    }
    
    func generateRandomGiftee(user: UserAccount) { //TODO: THIS FUNCTION MIGHT BE MORE OF A GENERAL FUNCTION THAN IN THE CLASS BUT WE'LL SEE
        //First check to see if user has already generated gift for current year
        let hasUserGeneratedGiftee = giftGivingCombos[currentYear]?.keys.contains(user.userName)
        if (hasUserGeneratedGiftee == true) {
            print(user.userName + " has already generated gift for current year")
            return
        }
        let previousGiftee = (giftGivingCombos[currentYear-1]?[user.userName] != nil) ? giftGivingCombos[currentYear-1]?[user.userName] : ""
        
        var tempAvailableGiftees: [UserAccount] = availableGiftees.filter({$0.userName != user.userName})
        if (settings.canCouplesMatch) {
            print("1")
            if(settings.canPairingsRepeat) {
                print("2")
                guard let randomizedGiftee = tempAvailableGiftees.randomElement() else {return}
                
                if let gifteeIndex = availableGiftees.firstIndex(where: {$0.userName == randomizedGiftee.userName}) {
                    availableGiftees.remove(at: gifteeIndex)
                }
                
                giftGivingCombos[currentYear]?[user.userName] = randomizedGiftee.userName
                print("3")
            }
            else {
                print("4")
                guard let randomizedGiftee = tempAvailableGiftees.filter({$0.userName != previousGiftee}).randomElement() else {return}
                
                if let gifteeIndex = availableGiftees.firstIndex(where: {$0.userName == randomizedGiftee.userName}) {
                    availableGiftees.remove(at: gifteeIndex)
                }
                
                
                giftGivingCombos[currentYear]?[user.userName] = randomizedGiftee.userName
                print("5")
            }
        }
        else if (settings.canPairingsRepeat) {
            print("6")
            guard let randomizedGiftee = tempAvailableGiftees.filter({$0.userName != user.spouse}).randomElement() else {return}
            
            if let gifteeIndex = availableGiftees.firstIndex(where: {$0.userName == randomizedGiftee.userName}) {
                availableGiftees.remove(at: gifteeIndex)
            }
            giftGivingCombos[currentYear]?[user.userName] = randomizedGiftee.userName
            print("7")
        }
        else {
            print("8")
            guard let randomizedGiftee = tempAvailableGiftees.filter({($0.userName != previousGiftee && $0.userName == user.spouse)}).randomElement() else {return}
            
            if let gifteeIndex = availableGiftees.firstIndex(where: {$0.userName == randomizedGiftee.userName}) {
                availableGiftees.remove(at: gifteeIndex)
            }
            giftGivingCombos[currentYear]?[user.userName] = randomizedGiftee.userName
            print("9")
        }
        
    }
    
    func adminAssignPairing(gifter: UserAccount, giftee: UserAccount, year: Int) { //TODO: Make sure this can only been done by admin
        giftGivingCombos[year]?[gifter.userName] = giftee.userName
    }
    
    func adminUpdateGroupSettings(canCouplesMatch: Bool, canPairingsRepeat: Bool, isWhiteElephant: Bool, priceLimit: Double) {
        settings.canCouplesMatch = canCouplesMatch
        settings.canPairingsRepeat = canPairingsRepeat
        settings.isWhiteElephant = isWhiteElephant
        settings.priceLimit = priceLimit
    }
    
    
    //TODO: Might need to change the logic of this since the gift giving should be more in a "circle" than matched
    func randomizeAllPairings() {
        //TODO: The following code randomizes it succesfully. THIS LOOPS INFINITELY SOMETIMES THOUGH! NEED TO FIGURE OUT WHY!
        // var giftcombo : [String:String] = [:]
        // var users : [String] = ["Chris", "Brigette", "Collin", "Meg", "Jessie", "Scott", "Aaron"]
        // var gifterList = users
        // var gifteeList = users
        // while (gifteeList.count > 0 || gifterList.count > 0) {
        //     guard let randomizedGifter = gifterList.randomElement() else {break}
        //     guard let randomizedGiftee = gifteeList.randomElement() else {break}
        //     if (randomizedGiftee == randomizedGifter) {
        //         continue
        //     }
        //     gifterList.removeAll { $0 == randomizedGifter }
        //     gifteeList.removeAll { $0 == randomizedGiftee }
        //     giftcombo[randomizedGifter] = randomizedGiftee
        // }
        // print(giftcombo)
        
        if (settings.canCouplesMatch) {
            if(settings.canPairingsRepeat) {
                //No limitations so just randomize
                let randomizedGifter = members.randomElement()!.userName
                let randmoizedGiftee = availableGiftees.randomElement()!.userName
                var tempMemberList = members
                tempMemberList.removeAll { $0.userName == randomizedGifter }
                let randomizedGiftee = tempMemberList.randomElement()!.userName
                giftGivingCombos[currentYear]![randomizedGifter] = randomizedGiftee
            }
            else {
                //Couples can match but pairings cant repeat
                //guard let randomizedGifter = members.randomElement() else {break}
                //guard let randomizedGiftee = members.randomElement() else {break}
                print("NEED TO IMPLEMENT INSIDE SETTINGS.CANPAIRINGSREPEAT")
            }
        }
        else if (settings.canPairingsRepeat) {
            //No couples but previous pairings is fine
            let randomizedGifter = members.randomElement()!
            var tempMemberList = members
            tempMemberList.removeAll { ($0.userName == randomizedGifter.userName) || $0.userName == randomizedGifter.spouse }
            let randomizedGiftee = tempMemberList.randomElement()!.userName
            giftGivingCombos[currentYear]![randomizedGifter.userName] = randomizedGiftee
        }
        //TODO: Implement logic for when no repeats and no spouses are chosen
        //No couples, no repeats
        else {
            let randomizedGifter = members.randomElement()!
            var tempMemberList = members
            //Remove user, user's spouse and users match from previous year
            tempMemberList.removeAll { $0.userName == randomizedGifter.userName || $0.userName == randomizedGifter.spouse || $0.userName == giftGivingCombos[currentYear-1]![randomizedGifter.userName] }
            let randomizedGiftee = tempMemberList.randomElement()!.userName
            giftGivingCombos[currentYear]![randomizedGifter.userName] = randomizedGiftee
        }
    }
}

struct GroupSettings {
    var canCouplesMatch: Bool = false //Can couples get each other
    var canPairingsRepeat: Bool = false //Can we repeat a pairing from previous years
    var isWhiteElephant: Bool = false
    var priceLimit: Double = 0
}

//Create a new group with the passed group information. This returns the new group itself, so should be stored in a variable
func adminCloneGroup(clonedGroup: UserGroup, newGroupName: String, newGroupYear: Int) -> UserGroup {
    let newGroup = UserGroup(groupName: newGroupName, currentYear: newGroupYear)
    newGroup.groupName = newGroupName
    newGroup.groupAdmins = clonedGroup.groupAdmins
    newGroup.members = clonedGroup.members
    newGroup.groupType = clonedGroup.groupType
    newGroup.currentYear = newGroupYear
    newGroup.settings = clonedGroup.settings
    return newGroup
}

//Build out a gift object and then add it to the user account
func userAddGift(user: UserAccount, giftName: String, giftPrice: Double, giftDescription: String = "", giftLink: String = "", giftRanking: Int = 0, giftIsGifted: Bool = false ) {
    var newGift = Gift(name: giftName, price: giftPrice, description: giftDescription, link: giftLink, ranking: giftRanking, isGifted: giftIsGifted)
    user.addGiftToList(&newGift)
}

var newGift = Gift(description: "GIFT")
var x24: UserGroup = UserGroup(groupName: "X24", currentYear: 2025)
