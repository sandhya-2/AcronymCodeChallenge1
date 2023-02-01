//
//  AcronymSearchViewController.swift
//  AcronymCodeChallenge1
//
//  Created by admin on 24/01/2023.
//

import UIKit
import SwiftUI

class AcronymSearchViewController: UIViewController {
    
    let contentView = UIHostingController(rootView: ContentView(viewModel: AcronymViewModel(repository: AcronymListRepositoryImplementation(networkManager: NetworkManager())), alertError: false))

    var viewModel: AcronymViewModelType
    
    init(viewModel: AcronymViewModelType) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        addChild(contentView)
        view.addSubview(contentView.view)
        setUpConstraints()
    }
    
    private func setUpConstraints() {
        contentView.view.translatesAutoresizingMaskIntoConstraints = false
        contentView.view.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        contentView.view.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        contentView.view.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        contentView.view.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
    }

}

