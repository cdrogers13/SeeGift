//
//  GiftListScrollView.swift
//  SeeGiftNew
//
//  Created by Chris Rogers on 1/26/25.
//

import SwiftUI

struct GiftListScrollView: View {
    let elements = ["Reservation", "Contacts", "Restaurant Locations"]
    var body: some View {
         List {
            Section(header: Text("Important Information")) {
                Text("This List shows information about our restaurant pages")
                    .font(.headline)
            }

            ForEach(elements, id: \.self) {element in
                Text(element)
            }

            Section(footer: Text("More Information")) {
                Text("Contact us as (212) 555 3231")
            }
        }
    }
}

#Preview {
    GiftListScrollView()
}
