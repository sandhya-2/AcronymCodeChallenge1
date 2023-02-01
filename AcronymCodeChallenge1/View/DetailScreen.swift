//
//  DetailScreen.swift
//  AcronymCodeChallenge1
//
//  Created by admin on 30/01/2023.
//

import SwiftUI

struct DetailScreen: View {
    
    @State var acronymlfs: SpecificAcronym
    
    var body: some View {
        VStack (alignment: .leading){
            
                Text("Title : \(acronymlfs.lf)").font(.headline).padding(20)
                Text("Frequency : \(acronymlfs.freq)").font(.subheadline).padding(20)
                Text("Since : \(acronymlfs.since)").font(.subheadline).padding(20)
            Spacer()
        }
       
    }
}

struct DetailScreen_Previews: PreviewProvider {
    static var previews: some View {
        DetailScreen(acronymlfs: SpecificAcronym(lf: "SOS", freq: 100, since: 1985, variations: []))
    }
}
