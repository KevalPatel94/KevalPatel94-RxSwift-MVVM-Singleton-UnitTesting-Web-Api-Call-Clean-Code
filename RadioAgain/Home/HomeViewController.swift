//
//  ViewController.swift
//  RadioAgain
//
//  Created by Keval Patel on 11/13/20.
//

import UIKit
import RxSwift
import RxCocoa

class HomeViewController: ViewController<HomeViewModel> {

    @IBOutlet weak var channelTableView: UITableView!
    @IBOutlet weak var clickMeButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        channelTableView.estimatedRowHeight = 112
    }
    
    override func generateInput() -> HomeViewModelInput {
        return HomeViewModelInput(buttonClickEvent: clickMeButton.rx.tap.asObservable(),
                                  radioManager: RadioManager.shared)
    }
    
    override func setUpUIBindings(viewModel: HomeViewModel) {
        viewModel.clickTitle
            .bind(to: clickMeButton.rx.title())
            .disposed(by: disposeBag)
        
        viewModel.clickTitle
            .bind(to: self.rx.title)
            .disposed(by: disposeBag)
        
        viewModel.channelsList
            .bind(to: channelTableView.rx.items(cellIdentifier: "ChannelCell", cellType: ChannelCell.self)){
             index, channel, cell in

                let cellModel = ChannelCellModel(title: channel.title,
                                                 channelImageUrl: channel.image,
                                                 dj: channel.dj,
                                                 genre: channel.genre,
                                                 disclabel: channel.description)
//                let cell = ChannelCell()
                cell.update(channelCellModel: cellModel)
//                cell.title.text = channel.title
//                cell.disclabel.text = channel.description
//                cell.genre.text = channel.genre
//                cell.dj.text = channel.dj
            }.disposed(by: disposeBag)
        
    }
    
    override func setUpSubscription(viewModel: HomeViewModel) {
        
        viewModel.channelsList.subscribe(onNext: { [weak self] (channelsList) in
            print(channelsList)
        }).disposed(by: disposeBag)
        
        viewModel.navigateToDetail.subscribe(onNext: { [weak self] (detailTransitionModel) in
//            self?.navigationController?.push(viewController: DetailViewController.self,
//                                             transitionModel: detailTransitionModel,
//                                             animated: true)
            
        }).disposed(by: disposeBag)

    }
}
