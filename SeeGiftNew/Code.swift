//
//  Code.swift
//  SeeGift
//
//  Created by Chris Rogers on 1/12/25.
//


/*TODO: -IMPLEMENT, SHOW AND DETERMINE A USAGE FOR GIFT RANKINGS ON PERTINENT VIEWS AND INPUT PAGES
            --Might want to put in the capability for user to rearrange their ranking order through drag and drop. Would be good practice at the very least
 
 -IMPLEMENT FUNCTIONAL LINKS ON THE GIFTS  (DONE! OPENS IN BROWSER, NEED TO TEST IF THESE LINKS ALLOW THEM TO OPEN IN APPS. I IMAGINE IT USES USER DEFAULT PREFERENCES)
 
 -LEARN ABOUT AND BEGIN WORK ON THE SETTINGS FEATURES AND THE COGS ICON ON THE GROUP SETTINGS SCREEN
 
 -IMPLEMENT NAVIGATION LINKS CONNECTED TO BUTTONS ON THE SETTINGS PAGES
 
 -CREATE GROUP PAGE VIEW AND LINK IT TO GROUPS TAB. NEED THIS TO BE NAVIGABLE ONCE I FIGURE OUT WHAT I WANT IT TO BE ABLE TO DO
 
 -NEED TO FIGURE OUT HOW TO FIX THE ISSUE OF MULTI-LEVEL NAVIGATIONLINKS PUTTING MORE THAN ONE BACK BUTTON ON SCREEN. MY GUESS IS TO USE THE STACK INSTEAD OF THE LINKS
 
 -THINK I WANT TO CHANGE RANKINGS TO ONE MOST WANTED GIFT PER LIST INSTEAD OF A RANKING SYSTEM. PROBABLY EASIER ON ALL FRONTS TO BE HONEST
 
 -USE NEW PICTURE DOWNLOAD TO CREATE A CHECKLIST VIEW WHERE USERS CAN SELECT WHAT PICS THEY WANT TO USE FROM THE WEB LINK
 */


import Foundation
import WebKit
import SwiftSoup


@Observable class UserAccount: Identifiable {
    var firstName: String = "Test"
    var lastName: String = "Account"
    var userName: String = "TestAccount" //This needs to be unique
    var password: String = "Password"
    var spouse = ""
    var profilePicture: String = "Profile Silhouette"
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

class AdminAccount: UserAccount {
    
}
//struct Gift: Hashable {
@Observable class Gift: Identifiable {
    var name: String = ""
    var price: Double = 0
    var description: String = ""
    //var userComments: String = ""
    var image: String = ""
    var link: String = ""
    //var ranking: Int = 0
    var isGifted: Bool = false
    var giftID: Int = Int.random(in: 0...1000000000)
    var isMostWanted: Bool = false
    var downloadedImages: [String] = []
    
    init(name: String = "", price: Double = 0, description: String = "", image: String = "", link: String = "", isGifted: Bool = false, giftID: Int = Int.random(in: 0...1000000000), isMostWanted: Bool = false, downloadedImages: [String] = []) {
        self.name = name
        self.price = price
        self.description = description
        self.image = image
        self.link = link
        self.isGifted = isGifted
        self.giftID = giftID
        self.isMostWanted = isMostWanted
        self.downloadedImages = downloadedImages
    }
}

struct GiftPairings {
    var year: Int
    var pairings: [String: String] //This will be [UserAccount.userName: UserAccount.userName], for example ["Chris": "Brigette"]
    //Key-Value pairs for the matchups from this year
}

enum GroupType : String {
    case family
    case friend
}

class UserGroup: Identifiable {
    var groupName: String
    var groupAdmins: [UserAccount]
    var members: [UserAccount]
    var groupType: GroupType //Family or Friend...probably use an enum here actually
    var giftGivingCombos: [Int: [String: String]]
    var settings: GroupSettings
    var currentYear: Int
    var availableGiftees: [UserAccount]
    var groupImage: String = ""
    //var takenGiftees: [String] = [] //This will be user name of people taken in the group already
    
    init(groupName: String = "Test Group", members: [UserAccount] = [], groupAdmins: [UserAccount] = [], groupType: GroupType = GroupType.friend, giftGivingCombos: [Int : [String : String]] = [:], settings: GroupSettings = GroupSettings(), currentYear: Int, availableGiftees: [UserAccount] = []) {
        self.groupName = groupName
        self.members = members
        self.groupAdmins = groupAdmins
        self.groupType = groupType
        self.giftGivingCombos = giftGivingCombos
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
    var newGift = Gift(name: giftName, price: giftPrice, description: giftDescription, link: giftLink, isGifted: giftIsGifted)
    user.addGiftToList(&newGift)
}

//Create JSON File upon pertinent data creation
func createJSONFile() {
    
}

//Save to JSON File (Once implemented) whenever a transition calls for it
func updateJSONFileOnNavigate() {
    
}

func fetchHTML(from urlString: String, completion: @escaping (String?, String?, [String], [downloadedGiftImage], Double?) -> Void) {
            guard let url = URL(string: urlString) else {
                completion(nil, nil, [], [], nil)
                return
            }

            URLSession.shared.dataTask(with: url) { data, response, error in
                guard let data = data, error == nil, let html = String(data: data, encoding: .utf8) else {
                    completion(nil, nil, [], [], nil)
                    return
                }

                do {
                    let document = try SwiftSoup.parse(html)
                    
                    // Extract title
                    let title = try document.title()
                    
                    // Extract meta description
                    let metaTag = try document.select("meta[name=description]").first()
                    let metaDescription = try metaTag?.attr("content") ?? "No description"

                    // Extract all links
                    let linkElements = try document.select("a[href]")
                    let extractedLinks = linkElements.array().compactMap { try? $0.attr("href") }

                    // Extract all image sources
                    let imageElements = try document.select("img[src]")
                    let extractedImages = imageElements.array().compactMap { try? $0.attr("src") }
                    let downloadedImages = extractedImages.map() { imageURL in
                        let fixedURL = imageURL.hasPrefix("https") ? imageURL : "https:" + imageURL
                       return downloadedGiftImage(url: fixedURL, isSelected: false)
                    }
                    //Extract price through various methods. Will just be blank if not found
                    let productPrice = extractPrice(from: document)
                    //let extractedPrice = Double(productPrice)
                    DispatchQueue.main.async {
                        completion(title, metaDescription, extractedLinks, downloadedImages, Double(productPrice))
                    }
                } catch {
                    completion(nil, nil, [], [], nil)
                }
            }.resume()
        }

func extractPrice(from doc: Document) -> String {
    let selectors = [
        ".a-price-whole",                // Amazon
        ".priceView-hero-price",         // Best Buy
        ".product-price",                // Walmart
        ".Price-characteristic",         // Target
        ".price",                        // General fallback
    ]
    
    for selector in selectors {
        if let price = try? doc.select(selector).first()?.text(), !price.isEmpty {
            var extractedPrice = price
            //This essentially only returns number values
            extractedPrice.removeAll { !"0123456789.".contains($0) }
            return extractedPrice
        }
    }
    
    return "Price Not Found"
}

//Gifts

var newGift = Gift(name: "Mountain Bike", price: 100, description: "This is a test gift", image: "Bike", link: "https://www.google.com", isMostWanted: true)
var newGift2 = Gift(name: "3-Body Problem", price: 35, description: "Book I would really like to read", image: "Test4", link: "https://www.amazon.com", isGifted: true)
var newGift3 = Gift(name: "Barbie Doll", price: 25, description: "Uglah Barbie", image: "Baby Doll", link: "https://www.google.com")
var newGift4 = Gift(name: "Test Gift3", price: 75, description: "This is yet another test gift", image: "Test3", link: "https://www.google.com")
var newGift5 = Gift(name: "Test Gift4", price: 60, description: "Yup...another test gift", image: "Test2", link: "https://www.google.com")
var newGift6 = Gift(name: "Test Gift5", price: 35, description: "This is a test gift", image: "Test3", link: "https://www.google.com")
var testGiftList: [Gift] = [newGift, newGift2, newGift3]


//UserAccounts
var chris = UserAccount(firstName: "Chris", lastName: "Rogers", userName: "juice", spouse: "Brigette", giftsList: [newGift, newGift4])
var brigette = UserAccount(firstName: "Brigette", lastName: "Rogers", userName: "brig", spouse: "Chris")
var collin = UserAccount(firstName: "Collin", lastName: "Rogers", userName: "cdrog", spouse: "Megan")
var meg = UserAccount(firstName: "Megan", lastName: "Rogers", userName: "megv", spouse: "Collin")
var Aaron = UserAccount(firstName: "Aaron", lastName: "Christopher", userName: "aaron", spouse: "")
var Nick = UserAccount(firstName: "Nick", lastName: "Mourning", userName: "nickm", spouse: "")
var Josh = UserAccount(firstName: "Josh", lastName: "Mourning", userName: "joshm", spouse: "")
var Bella = UserAccount(firstName: "Bella", lastName: "Mourning", userName: "bellam", spouse: "")
var Ken = UserAccount(firstName: "Ken", lastName: "Mourning", userName: "kenm", spouse: "mariem")
var Marie = UserAccount(firstName: "Marie", lastName: "Mourning", userName: "mariem", spouse: "kenm")

//UserGroups
var mourningFamily: UserGroup = UserGroup(groupName: "Mourning Family", members: [chris, brigette, Nick, Josh, Bella, Ken, Marie], groupAdmins: [chris, brigette], groupType: .family, currentYear: 2025, availableGiftees: [chris, brigette, Nick, Josh, Bella, Ken, Marie])

var x24: UserGroup = UserGroup(groupName: "X24", members: [chris, brigette, collin, meg, Aaron], groupAdmins: [chris, brigette], groupType: .family, currentYear: 2025, availableGiftees: [chris, brigette, collin, meg, Aaron])




var userGroupsArray = [mourningFamily, x24]


