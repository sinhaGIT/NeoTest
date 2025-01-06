//
//  BottomSheetBuilder.swift
//  NeoTest
//
//  Created by Bajrang Sinha on 29/12/24.
//

import UIKit

class BottomSheetControllerBuilder : ViewControllerBuilderProtocol {
    
    let carModels:[CarModel]
    
    init(carModels:[CarModel]) {
        self.carModels = carModels
    }
    
    func build() -> UIViewController {
        
        let controller = BottomSheetViewController()
        let vm = BottomSheetViewModel(carModels: self.carModels)
        controller.viewModel = vm
        return controller
        
    }
}
