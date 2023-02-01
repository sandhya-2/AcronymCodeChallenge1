//
//  ContentView.swift
//  AcronymCodeChallenge1

//  Created by admin on 24/01/2023.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var viewModel: AcronymViewModel
    @State var alertError: Bool
    
    var body: some View {
        NavigationStack {
            
            VStack (alignment: .center, spacing: 0){
                Text("What Is This Acronym?")
                    .font(.headline)
                    .padding()
                SearchBar(searchText: $viewModel.searchText)
                    .padding(20)
                    .onChange(of: viewModel.error) { newValue in
                        if viewModel.error != nil {
                            alertError = true
                        } else {
                            alertError = false
                        }
                    }
                
                if viewModel.error != nil {
                    
                    ProgressView().alert(isPresented: $alertError) {
                        Alert(title: Text("Oops!"), message: Text("Invalid data"), dismissButton: .default(Text("OK")))
                    }
                    
                } else {
                    List{
                        ForEach (viewModel.result?.lfs ?? []) {
                            acronym in
                            NavigationLink {
                                DetailScreen(acronymlfs: acronym).navigationTitle("Acronym Detail Screen")
                            } label: {
                                Text(acronym.lf)
                            }
                            
                        }
                        
                    }
                    
                }
                Spacer()
            }.onAppear {
                if viewModel.error != nil {
                    alertError = true
                } else {
                    alertError = false
                }
            }
        }
    }
    
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(viewModel: AcronymViewModel(repository: AcronymListRepositoryImplementation(networkManager: NetworkManager())), alertError: false)
    }
}
