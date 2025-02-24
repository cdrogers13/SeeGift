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
    let aeLink = "https://www.ae.com/us/en/p/men/slim-fit-jeans/slim-straight-jeans-/ae-airflex-slim-straight-jean/0116_6848_001?menu=cat4840004"
    let mozaLink = "https://mozaracing.com/en-us/product/r3-bundle-for-pc/"
    let amazonLink = "https://www.amazon.com/Cl%C3%A9-Peau-Beaut%C3%A9-Clarifying-Cleansing/dp/B0977YGCS4?ie=UTF8&ASIN=B0977YGCS4&sr=1-2&qid=1740337287&_encoding=UTF8&content-id=amzn1.sym.74b5cdc5-f065-4d74-a6b6-32a79a8204a6&pd_rd_w=Uzuh4&dib=eyJ2IjoiMSJ9.Eq45uRRU0g7LymhSKKr5oZ0fbWozohw_rq5ZwZW0i11fbhPeMxSOOA0LbwZ5aMr6Ak1uXq_MVh7ZFcRcpkexemaZkD8_PPhJdJz8yXXw5QgkqKEy5IB5qNma-PH-WWiv56w4MAJ0Vw5tD8L3L182NvX88tEixhmorJgcHgl0TK41rpwWMBCZM9SM_jn6rbS1dO-9xoxzJ3LfQdcXddCXtT9WuH0w8U6I6mfE7ulCsOIyVkxS--ETcHtqD30CMJVZqXYJvLZbmVa5w69e5M3VJp8oLCEdTi5uVAvZ2ypF2dM.OoGF97BlqfBmFmbEkaU1rHqj2SeKji-GrMvn2eRro80&rnid=20657941011&dib_tag=se&pd_rd_wg=VMZrT&pd_rd_r=b0eae4d0-33e9-42bc-92a9-75039335ee99&ref_=lx_bd"
    
    var body: some View {
       
            
            ZStack {
                    Color.blue
                    if viewModel {
                        Color.green
                    }
                }
                .onTapGesture {
                    viewModel.toggle()
                }
            
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
            fetchHTML(from: aeLink) { title, meta, extractedLinks, extractedImages in
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
    TestingView()
}
