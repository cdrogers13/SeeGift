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
    @State var giftLink: String = ""
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
                LoadedGiftLinkView(giftLink: giftLink).id(viewID)
            }
        }
    }
}

struct LoadedGiftLinkView: View {
    @State private var pageTitle: String = "Loading..."
    @State private var metaDescription: String = "Loading..."
    @State private var links: [String] = []
    @State private var images: [String] = []
    let giftLink: String
    
    var body: some View {
        Text("Verify Gift Information Before Saving")
            ScrollView {
                       VStack(alignment: .leading, spacing: 10) {
                           Text("Page Title: \(pageTitle)").font(.headline)
                           Text("Meta Description: \(metaDescription)").font(.subheadline)
                           
    //                       Text("🔗 Links:")
    //                       ForEach(links, id: \.self) { link in
    //                           Text(link).foregroundColor(.blue)
    //                       }

                           Text("🖼 Images:")
                                           ForEach(images, id: \.self) { img in
                                               if let url = URL(string: img) {
                                                   if (img.hasSuffix("jpg") || img.contains("fmt=jpeg") ) {
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
                                                   }
                                                  
                                               }
                                           }
                                       }
                                       .padding()
                   }
            .onAppear {
                fetchHTML(from: giftLink) { title, meta, extractedLinks, extractedImages in
                    self.pageTitle = title ?? "Failed to load"
                    self.metaDescription = meta ?? "No Meta Description"
                    self.links = extractedLinks
                    self.images = extractedImages
                }
            }
        }
        
        func fetchHTML(from urlString: String, completion: @escaping (String?, String?, [String], [String]) -> Void) {
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
                        let boom = extractedImages.map { imageURL in
                            imageURL.hasPrefix("https") ? imageURL : "https:" + imageURL
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

#Preview {
    AddGiftViaLinkView()
}
