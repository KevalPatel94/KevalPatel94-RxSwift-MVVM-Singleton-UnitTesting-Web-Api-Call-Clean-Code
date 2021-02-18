//
//  DetailViewController.swift
//  RadioAgain
//
//  Created by Keval Patel on 11/14/20.
//

import UIKit
import RxSwift
import RxCocoa

class DetailViewController: ViewController<DetailViewModel> {

    override func generateInput() -> PlaceHolderInputModel {
        return PlaceHolderInputModel()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func setUpUIBindings(viewModel: DetailViewModel) {
        viewModel.passedMessage
            .bind(to: self.rx.title)
            .disposed(by: disposeBag)
    }
}
