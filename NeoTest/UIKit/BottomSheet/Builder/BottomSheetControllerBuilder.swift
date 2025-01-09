//
//  BottomSheetBuilder.swift
//  NeoTest
//
//  Created by Bajrang Sinha on 29/12/24.
//

//  This class is responsible for creating instances of Bottom Sheet View Controller
//  and ensuring that their dependencies (e.g., view models, services) are properly injected.
//  The builder pattern is used to keep the view controller initialization logic
//  encapsulated, promoting better separation of concerns and testability.

import UIKit

/*
 
 */

class BottomSheetControllerBuilder : ViewControllerBuilderProtocol {
    
    let carModels:[CarModel]
    
    init(carModels:[CarModel]) {
        self.carModels = carModels
    }
    
    /// Creates an instance of the `BottomSheetViewController`.
    ///
    /// - Returns: A fully configured instance of `BottomSheetViewController`.
    ///
    func build() -> UIViewController {
        
        let controller = BottomSheetViewController()
        let vm = BottomSheetViewModel(carModels: self.carModels)
        controller.viewModel = vm
        return controller
        
    }
}
