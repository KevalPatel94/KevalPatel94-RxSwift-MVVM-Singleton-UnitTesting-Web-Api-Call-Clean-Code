//
//  ViewController.swift
//  RadioAgain
//
//  Created by Keval Patel on 11/14/20.
//

import UIKit
import RxSwift

class ViewController<ViewModel: ViewModelable>: RoutableViewController {
    
    private var transitionModel: ViewModel.TransitionModelType?
    public let disposeBag = DisposeBag()

    // Build ViewModel
    private lazy var viewModel: ViewModel = {
        return generateViewModel()
    }()
    // Build inputModel from ViewController
    private lazy var inputModel: ViewModel.InputType = {
        return generateInput()
    }()
    
    // This method generates input from ViewController
    open func generateInput() -> ViewModel.InputType {
        fatalError("failed to generate inputModel")
    }
        
    // Generate ViewModel using input and transitionModekl
    func generateViewModel() -> ViewModel {
       return ViewModel(transitionModel: transitionModel, input: inputModel)
    }
    
    // Provides results from View Model
    open func setUpSubscription(viewModel: ViewModel) {}
    
    // Provide results from View Model for UI elements set up in viewWillAppear
    open func setUpUIBindings(viewModel: ViewModel) {}
    
    // Act as delegate pattern of communication, helps receieve data from source ViewController
    override func updateTransitionModel(transitionModel: Any) {
        super.updateTransitionModel(transitionModel: transitionModel)
        if let transition = transitionModel as? ViewModel.TransitionModelType {
            self.transitionModel = transition
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpSubscription(viewModel: viewModel)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setUpUIBindings(viewModel: viewModel)
    }
}
