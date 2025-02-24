//
//  AddGiftViaLinkView.swift
//  SeeGiftNew
//
//  Created by Chris Rogers on 2/23/25.
//

import SwiftUI
import SwiftSoup


struct AddGiftViaLinkView: View {
    let mozaLink = "https://mozaracing.com/en-us/product/r3-bundle-for-pc/"
    @State var downloadedGift: Gift = Gift()
    @State var giftLink: String = "https://amazon.com"
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
    @Binding var gift: Gift
    @State private var pageTitle: String = "Loading..."
    @State private var metaDescription: String = "Loading..."
    @State private var links: [String] = []
    @State private var images: [downloadedGiftImage] = []
    @State var currImage: downloadedGiftImage = downloadedGiftImage()
    let giftLink: String
    
    var body: some View {
        Text("Verify Gift Information Before Saving")
        
        VStack(alignment: .leading, spacing: 10) {
            Text("Page Title: \(pageTitle)").font(.headline)
            Text("Meta Description: \(metaDescription)").font(.subheadline)
            
            //                       Text("🔗 Links:")
            //                       ForEach(links, id: \.self) { link in
            //                           Text(link).foregroundColor(.blue)
            //                       }
            ScrollView (.horizontal){
                Text("🖼 Images:")
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
            .padding()
            
            Button("TEMP BUTTON TO SAVE") {
                //filters the images array to only the ones that are selected and then maps it to be just the actual string names.
                //TODO: FROM HERE I WILL NEED TO ACTUALLY DOWNLOAD THOSE FILES AND THEN STORE THEM IN THE DOCUMENTS FOLDER OF THE APP, BUT FOR NOW THIS WILL SUFFICE
                gift.downloadedImages = images.filter() {
                    $0.isSelected == true
                }.map({$0.url})
                
            }
        }
            .onAppear {
                fetchHTML(from: giftLink) { title, meta, extractedLinks, extractedImages in
                    self.pageTitle = title ?? "Failed to load"
                    self.metaDescription = meta ?? "No Meta Description"
                    self.links = extractedLinks
                    self.images = extractedImages
                    //self.gift = Gift(downloadedImages: extractedImages)
                }
            }
        }
        
    func fetchHTML(from urlString: String, completion: @escaping (String?, String?, [String], [downloadedGiftImage]) -> Void) {
                guard let url = URL(string: urlString) else {
                    completion(nil, nil, [], [])
                    return
                }

                URLSession.shared.dataTask(with: url) { data, response, error in
                    guard let data = data, error == nil, let html = String(data: data, encoding: .utf8) else {
                        completion(nil, nil, [], [])
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
    //                    ForEach(extractedImages) { imgLink in
    //
    //
    //                    }
                        let boom = extractedImages.map() { imageURL in
                            let fixedURL = imageURL.hasPrefix("https") ? imageURL : "https:" + imageURL
                           return downloadedGiftImage(url: fixedURL, isSelected: false)
                        }
                        //print(extractedImages)
                        DispatchQueue.main.async {
                            completion(title, metaDescription, extractedLinks, boom)
                        }
                    } catch {
                        completion(nil, nil, [], [])
                    }
                }.resume()
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
    AddGiftViaLinkView()
}
