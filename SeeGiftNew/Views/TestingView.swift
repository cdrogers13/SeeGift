//
//  TestingView.swift
//  SeeGiftNew
//
//  Created by Chris Rogers on 2/23/25.
//

import SwiftUI
import SwiftSoup

struct TestingView: View {
    @State var viewModel: Bool = false
    @State private var pageTitle: String = "Loading..."
       @State private var metaDescription: String = "Loading..."
       @State private var links: [String] = []
       @State private var images: [String] = []
    @State private var productTitle: String = "Enter a link"
        @State private var productImage: String = ""
        @State private var inputURL: String = ""
    @State var productPrice: String = "0.00"
    let aeLink = "https://www.ae.com/us/en/p/men/slim-fit-jeans/slim-straight-jeans-/ae-airflex-slim-straight-jean/0116_6848_001?menu=cat4840004"
    let mozaLink = "https://mozaracing.com/en-us/product/r3-bundle-for-pc/"
    let amazonLink = "https://www.amazon.com/Mintes-Dental-Vet-Recommended-Mint-Flavored-Removes/dp/B083MN4LGT?pd_rd_w=7wEGJ&content-id=amzn1.sym.4cbfbf26-01ab-40e5-a9b2-609425eaa81a&pf_rd_p=4cbfbf26-01ab-40e5-a9b2-609425eaa81a&pf_rd_r=HDEX70TQAXQM007XGJVY&pd_rd_wg=KW1DL&pd_rd_r=53b8994e-ada2-4cf4-9e8e-34e22d70a10c&pd_rd_i=B083MN4LGT&ref_=pd_bap_d_grid_rp_0_1_ec_scp_i&th=1"
    
    var body: some View {
       
            
//            ZStack {
//                    Color.blue
//                    if viewModel {
//                        Color.green
//                    }
//                }
//                .onTapGesture {
//                    viewModel.toggle()
//                }
            
        ScrollView {
            Text(productTitle)
            Image(productImage).resizable().scaledToFit()
            Text(productPrice)
            Button("TEMP BUTTON TO SAVE") {
                let apiKey = "6cf4a9e9ef926ba70f97b913724ee09b"
                let targetURL = mozaLink.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
                    let scraperURL = "https://api.scraperapi.com/?api_key=\(apiKey)&url=\(targetURL)"

                    guard let url = URL(string: scraperURL) else { return }

                    URLSession.shared.dataTask(with: url) { data, _, error in
                        guard let data = data, error == nil, let html = String(data: data, encoding: .utf8) else { return }

                        do {
                            let doc = try SwiftSoup.parse(html)
                            let title = try doc.select("title").text()
                            let price = extractPrice(from: doc)
                            let image = try doc.select("meta[property=og:image]").attr("content")

                            DispatchQueue.main.async {
                                self.productTitle = title
                                self.productImage = image
                                self.productPrice = price
                            }
                        } catch {
                            print("Parsing error: \(error)")
                        }
                    }.resume()
                    
                
            }
//                   VStack(alignment: .leading, spacing: 10) {
//                       Text("Page Title: \(pageTitle)").font(.headline)
//                       Text("Meta Description: \(metaDescription)").font(.subheadline)
//                       
////                       Text("🔗 Links:")
////                       ForEach(links, id: \.self) { link in
////                           Text(link).foregroundColor(.blue)
////                       }
//
//                       Text("🖼 Images:")
//                                       ForEach(images, id: \.self) { img in
//                                           if let url = URL(string: img) {
//                                               if (img.hasSuffix("jpg") || img.contains("fmt=jpeg") ) {
//                                                   AsyncImage(url: url) { phase in
//                                                       if let image = phase.image {
//                                                           image.resizable().scaledToFit()//.frame(height: 150)
//                                                       } else {
//                                                           ProgressView()
//                                                       }
//                                                   }
//                                                   .frame(width: 200, height: 150)
//                                                   .background(Color.gray.opacity(0.2))
//                                                   .cornerRadius(10)
//                                               }
//                                              
//                                           }
//                                       }
//                                   }
//                                   .padding()
               }
        .onAppear {
//            fetchHTML(from: aeLink) { title, meta, extractedLinks, extractedImages in
//                self.pageTitle = title ?? "Failed to load"
//                self.metaDescription = meta ?? "No Meta Description"
//                self.links = extractedLinks
//                self.images = extractedImages
//            }
        }
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
    TestingView()
}
