//
//  DetailViewModel.swift
//  RadioAgain
//
//  Created by Keval Patel on 11/18/20.
//

import RxSwift

class DetailViewModel: ViewModel<PlaceHolderInputModel, DetailHomeTransitionModel> {
    let passedMessage: Observable<String>
    public required init(transitionModel: DetailHomeTransitionModel?, input: PlaceHolderInputModel) {
        self.passedMessage = transitionModel?.transferedMessage ?? Observable.just("No Value")
        super.init(transitionModel: transitionModel, input: input)
    }
}

class DetailViewModelInput: ViewModelInput {
    let buttonEvents: Observable<Void>
    init(buttonEvents: Observable<Void>) {
        self.buttonEvents = buttonEvents
    }
}

class DetailHomeTransitionModel: TransitionModel {
    let transferedMessage: Observable<String>
    init(transferedMessage: Observable<String>) {
        self.transferedMessage = transferedMessage
    }
}
