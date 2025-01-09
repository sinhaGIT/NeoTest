//
//  CarModelListViewControllerBuilder.swift
//  NeoTest
//
//  Created by Bajrang Sinha on 12/12/24.
//
//  This class is responsible for creating instances of Car Model List View Controller
//  and ensuring that their dependencies (e.g., view models, services) are properly injected.
//  The builder pattern is used to keep the view controller initialization logic
//  encapsulated, promoting better separation of concerns and testability.

import UIKit

final class CarModelListViewControllerBuilder : ViewControllerBuilderProtocol {
    
    /// Creates an instance of the `CarModelListViewController`.
    ///
    /// - Returns: A fully configured instance of `CarModelListViewController`.
    ///
    
    func build() -> UIViewController {
        
        let controller = CarModelListViewController()
        controller.viewModel = CarListViewModel()
        
        return controller
        
    }
}
