//
//  AddGiftViaLinkView.swift
//  SeeGiftNew
//
//  Created by Chris Rogers on 2/23/25.
//

import SwiftUI
//Think i only need swiftsoup at the top level but gonna leave it commented out for now
//import SwiftSoup


struct AddGiftViaLinkView: View {
    
    
    let mozaLink = "https://mozaracing.com/en-us/product/r3-bundle-for-pc/"
    @State var downloadedGift: Gift = Gift()
    @State var giftLink: String = "https://mozaracing.com/en-us/product/r3-bundle-for-pc/"
    @State var showLoadedGift: Bool = false
    @State var viewID = UUID() //UUID is something you can pass into a view so that the UI knows its a new instance and will refresh itself
    var body: some View {
            VStack {
                HStack {
                    Text("Paste Link Below:")
                    TextField("URL Link", text: $giftLink).multilineTextAlignment(.trailing)
                }.onSubmit {
                    viewID = UUID()
                    showLoadedGift = (giftLink.isEmpty) ? false : true
                }
                if (showLoadedGift) {
                    LoadedGiftLinkView(gift: $downloadedGift, giftLink: giftLink).id(viewID)
                }
            }
        
    }
}

struct LoadedGiftLinkView: View {
    @Environment(UserAccount.self) var currUser
    @Binding var gift: Gift
    @State private var pageTitle: String = "Loading..."
    @State private var metaDescription: String = "Loading..."
    @State private var links: [String] = []
    @State private var images: [downloadedGiftImage] = []
    @State var currImage: downloadedGiftImage = downloadedGiftImage()
    @State var productPrice: Double = 0.0
    @State var giftName: String = ""
    @State var description: String = ""
    @State var doneLoading: Bool = false
    let giftLink: String
    let aeLink = "https://www.ae.com/us/en/p/men/slim-fit-jeans/slim-straight-jeans-/ae-airflex-slim-straight-jean/0116_6848_001?menu=cat4840004"
    let mozaLink = "https://mozaracing.com/en-us/product/r3-bundle-for-pc/"
    let amazonLink = "https://www.amazon.com/Mintes-Dental-Vet-Recommended-Mint-Flavored-Removes/dp/B083MN4LGT?pd_rd_w=7wEGJ&content-id=amzn1.sym.4cbfbf26-01ab-40e5-a9b2-609425eaa81a&pf_rd_p=4cbfbf26-01ab-40e5-a9b2-609425eaa81a&pf_rd_r=HDEX70TQAXQM007XGJVY&pd_rd_wg=KW1DL&pd_rd_r=53b8994e-ada2-4cf4-9e8e-34e22d70a10c&pd_rd_i=B083MN4LGT&ref_=pd_bap_d_grid_rp_0_1_ec_scp_i&th=1"
    
    var body: some View {
         ZStack {
             VStack {
                 Text("Verify Gift Information Before Saving")
                 
                 VStack(spacing: 10) {
                     Form {
                         VStack {
                             Text("Gift Name:")
                             TextEditor(text: $gift.name).multilineTextAlignment(.center)
                         }
                         VStack {
                             Text("Gift Price:")
                             TextField("Price", value: $gift.price, format: .currency(code: "USD")).multilineTextAlignment(.center)
                         }
                         VStack (alignment: .center){
                             Text("URL Link:")
                             Text(gift.link).multilineTextAlignment(.center)
                         }
                         
                     }
                 }.onAppear {
                     fetchHTML(from: amazonLink) { title, meta, extractedLinks, extractedImages, price in
                         self.pageTitle = title ?? "Failed to load"
                         self.metaDescription = meta ?? "No Meta Description"
                         self.links = extractedLinks
                         self.images = extractedImages
                         self.productPrice = price ?? 0.0
                         //gift.name = ""
                         gift.description = metaDescription
                         gift.price = productPrice
                         gift.link = giftLink
                         doneLoading = true
                     }
                 }
                 VStack (alignment: .center) {
                     Text("Gift Description:")
                     TextEditor(text: $gift.description).frame( height: 100, alignment: .top)
                 }.padding(.bottom)
                 VStack{
                     Text("Select Gift Images:")
                     ScrollView (.horizontal){
                         LazyHStack {
                             ForEach($images, id: \.self) { $img in
                                 if let url = URL(string: img.url) {
                                     if (img.url.hasSuffix("jpg") || img.url.contains("fmt=jpeg") ) {
                                         ZStack(alignment: .topTrailing) {
                                             AsyncImage(url: url) { phase in
                                                 if let image = phase.image {
                                                     image.resizable().scaledToFit()//.frame(height: 150)
                                                 } else {
                                                     ProgressView()
                                                 }
                                             }
                                             .frame(width: 200, height: 150)
                                             .background(Color.gray.opacity(0.2))
                                             .cornerRadius(10)
                                             checkBoxItemView(isSelected: $img.isSelected)
                                         }
                                         
                                     }
                                     
                                 }
                             }
                         }
                         
                     }
                     //.padding(.bottom)
                 }
                 Button("TEMP BUTTON TO SAVE") {
                     //filters the images array to only the ones that are selected and then maps it to be just the actual string names.
                     //TODO: FROM HERE I WILL NEED TO ACTUALLY DOWNLOAD THOSE FILES AND THEN STORE THEM IN THE DOCUMENTS FOLDER OF THE APP, BUT FOR NOW THIS WILL SUFFICE
                     gift.downloadedImages = images.filter() {
                         $0.isSelected == true
                     }.map({$0.url})
                     currUser.giftsList.append(gift)
                     print(currUser)
                 }
             }
             if (!doneLoading) {
                 ZStack {
                     Color.blue
                     VStack {
                         Text("Loading...")
                         ProgressView()
                     }
                 }
             }
        }
    }
}

struct downloadedGiftImage: Hashable {
    var url: String = ""
    var isSelected: Bool = false
}

struct checkBoxItemView: View {
    @Binding var isSelected: Bool
    var body: some View {
        Toggle(isOn: $isSelected, label: {}).toggleStyle(CheckboxToggleStyle())
    }
}

#Preview {
    AddGiftViaLinkView().environment(chris)
}
