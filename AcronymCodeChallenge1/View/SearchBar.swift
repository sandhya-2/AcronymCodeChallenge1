//
//  SearchBar.swift
//  AcronymCodeChallenge1
//
//  Created by admin on 30/01/2023.
//

import SwiftUI

struct SearchBar: View {
    
    @Binding var searchText: String
    
    var body: some View {
        
        HStack {
            TextField(" Search Acronym (Ex. DOD)", text: $searchText)
                .frame(width: 320, height: 40)
                .overlay(RoundedRectangle(cornerRadius: 10).strokeBorder(Color.black, style: StrokeStyle(lineWidth: 1.0)))
                .font(.headline)
                .overlay(
                    Image(systemName: "xmark.circle.fill")
                        .padding()
                        .offset(x: 10)
                        .foregroundColor(Color.red)
                        .opacity(searchText.isEmpty ? 0.0 : 1.0)
                        .onTapGesture {
                            UIApplication.shared.closeEdit()
                            searchText = ""
                        }
                    ,alignment: .trailing)
        }
    }
}

struct SearchBar_Previews: PreviewProvider {
    @State static var searchWord = ""
    
    static var previews: some View {
        SearchBar(searchText: $searchWord)
    }
}
