//
//  ViewModel.swift
//  RadioAgain
//
//  Created by Keval Patel on 11/14/20.
//

import Foundation

protocol ViewModelable {
    associatedtype InputType: ViewModelInput
    associatedtype TransitionModelType: TransitionModel
    init(transitionModel: TransitionModelType?, input: InputType)
}
protocol TransitionModel {}
protocol ViewModelInput {}

// Use Placeholder classes when model is not needed.
class PlaceHolderTransitionModel: TransitionModel {}
class PlaceHolderInputModel: ViewModelInput {}

class ViewModel<_InputType: ViewModelInput, _TransitionModelType: TransitionModel>: ViewModelable{
    public typealias InputType = _InputType
    public typealias TransitionModelType = _TransitionModelType
    public required init(transitionModel: _TransitionModelType?, input: _InputType) {}
}
