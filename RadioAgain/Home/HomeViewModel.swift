//
//  HomeViewModel.swift
//  RadioAgain
//
//  Created by Keval Patel on 11/18/20.
//

import UIKit
import RxSwift

class HomeViewModelInput: ViewModelInput {
    let buttonClickEvent: Observable<Void>
    let radioManager: RadioManager
    init(buttonClickEvent: Observable<Void>,
         radioManager: RadioManager) {
        self.buttonClickEvent = buttonClickEvent
        self.radioManager = radioManager
    }
}

class HomeViewModel:ViewModel<HomeViewModelInput, PlaceHolderTransitionModel> {
    let clickTitle: Observable<String>
    let navigateToDetail: Observable<DetailHomeTransitionModel>
    let channelsList: Observable<[Channel]>
    public required init(transitionModel: PlaceHolderTransitionModel?, input: HomeViewModelInput) {
        clickTitle = input.buttonClickEvent.map({ Constants.tappedString.rawValue })
        channelsList = input.buttonClickEvent.asObservable()
            .withLatestFrom(input.radioManager.getChannels())
        navigateToDetail = input.buttonClickEvent.map({ (_) -> DetailHomeTransitionModel in
            return DetailHomeTransitionModel(transferedMessage: Observable.just(Constants.messageString.rawValue))
        })
        super.init(transitionModel: transitionModel, input: input)
    }
}

extension HomeViewModel {
    enum Constants: String {
        case tappedString = "Tapped"
        case messageString = "I am Detail Screen"
    }
}



