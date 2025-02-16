//
//  testview.swift
//  SeeGiftNew
//
//  Created by Chris Rogers on 2/16/25.
//

import SwiftUI

struct testview: View {
    @Binding var show: Bool
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

#Preview {
    testview(show: .constant(false))
}
