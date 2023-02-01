//
//  AcronymCodeChallenge1App.swift
//  AcronymCodeChallenge1
//
//  Created by admin on 24/01/2023.
//

import SwiftUI

@main
struct AcronymCodeChallenge1App: App {
    var body: some Scene {
        WindowGroup {
            ContentView(viewModel: AcronymViewModel(repository: AcronymListRepositoryImplementation(networkManager: NetworkManager())), alertError: false)
        }
    }
}

extension UIApplication {
    func closeEdit() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
