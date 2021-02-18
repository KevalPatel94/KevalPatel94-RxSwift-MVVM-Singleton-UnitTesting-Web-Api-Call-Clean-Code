//
//  Navigation+Configuration.swift
//  RadioAgain
//
//  Created by Keval Patel on 11/18/20.
//

import UIKit
import RxSwift

extension UINavigationController {
    public func push(viewController: RoutableViewController.Type, transitionModel: Any?, animated: Bool) {
        // Build identifier
        let viewControllerIdentifier = "\(viewController)"
        // Build storyboard
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle(identifier: viewControllerIdentifier))
        // Instantiate ViewController
        guard let destinationViewController: RoutableViewController = storyboard.instantiateViewController(identifier: viewControllerIdentifier) as? RoutableViewController else { return
        }
        // Update Transition Model in destination ViewController
        if let model = transitionModel {
            destinationViewController.updateTransitionModel(transitionModel: model)
        }
        // Perform push Navigation
        pushViewController(destinationViewController, animated: true)
    }
}
