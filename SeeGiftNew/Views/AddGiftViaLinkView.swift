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
    @Binding var gift: Gift
    @State private var pageTitle: String = "Loading..."
    @State private var metaDescription: String = "Loading..."
    @State private var links: [String] = []
    @State private var images: [downloadedGiftImage] = []
    @State var currImage: downloadedGiftImage = downloadedGiftImage()
    let giftLink: String
    let aeLink = "https://www.ae.com/us/en/p/men/slim-fit-jeans/slim-straight-jeans-/ae-airflex-slim-straight-jean/0116_6848_001?menu=cat4840004"
    let mozaLink = "https://mozaracing.com/en-us/product/r3-bundle-for-pc/"
    let amazonLink = "https://www.amazon.com/Mintes-Dental-Vet-Recommended-Mint-Flavored-Removes/dp/B083MN4LGT?pd_rd_w=7wEGJ&content-id=amzn1.sym.4cbfbf26-01ab-40e5-a9b2-609425eaa81a&pf_rd_p=4cbfbf26-01ab-40e5-a9b2-609425eaa81a&pf_rd_r=HDEX70TQAXQM007XGJVY&pd_rd_wg=KW1DL&pd_rd_r=53b8994e-ada2-4cf4-9e8e-34e22d70a10c&pd_rd_i=B083MN4LGT&ref_=pd_bap_d_grid_rp_0_1_ec_scp_i&th=1"
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
            
//            Button("TEMP BUTTON TO SAVE") {
//                let apiKey = "YOUR_SCRAPERAPI_KEY"
//                    let targetURL = "https://www.example.com/product-page"
//                    let urlString = "https://api.scraperapi.com/?api_key=\(apiKey)&url=\(targetURL.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!)"
//                    
//                    guard let url = URL(string: urlString) else {
//                        self.pageTitle = "Invalid URL"
//                        return
//                    }
//                    
//                    URLSession.shared.dataTask(with: url) { data, response, error in
//                        if let error = error {
//                            DispatchQueue.main.async {
//                                self.pageTitle = "Error: \(error.localizedDescription)"
//                            }
//                            return
//                        }
//                        
//                        if let data = data, let html = String(data: data, encoding: .utf8) {
//                            do {
//                                let doc = try SwiftSoup.parse(html)
//                                let priceElement = try doc.select(".price-class").first() // Change selector based on site
//                                let price = try priceElement?.text() ?? "Price not found"
//                                
//                                DispatchQueue.main.async {
//                                    self.pageTitle = "Price: \(price)"
//                                }
//                            } catch {
//                                DispatchQueue.main.async {
//                                    self.pageTitle = "Parsing error"
//                                }
//                            }
//                        }
//                    }.resume()
//                
//                //filters the images array to only the ones that are selected and then maps it to be just the actual string names.
//                //TODO: FROM HERE I WILL NEED TO ACTUALLY DOWNLOAD THOSE FILES AND THEN STORE THEM IN THE DOCUMENTS FOLDER OF THE APP, BUT FOR NOW THIS WILL SUFFICE
//                gift.downloadedImages = images.filter() {
//                    $0.isSelected == true
//                }.map({$0.url})
//                
//            }
        }
            .onAppear {
                fetchHTML(from: aeLink) { title, meta, extractedLinks, extractedImages in
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
                        
                        //var testing = try document.select("span[class]")
                       
//                        var testing = try document.getElementsByClass("a-price-whole")
                        var testing = try document.getElementsContainingText("price")
//                        var swag = testing.array()
//                        var newSwag = swag[0].getChildNodes()
                        var testArray = testing.array().compactMap { try? $0.text()
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
                return price
            }
        }
        
        return "Price Not Found"
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
