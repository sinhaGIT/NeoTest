//
//  CarModelListViewControllerBuilder.swift
//  NeoTest
//
//  Created by Bajrang Sinha on 12/12/24.
//

import UIKit

final class CarModelListViewControllerBuilder : ViewControllerBuilderProtocol {
    
    func build() -> UIViewController {
        
        let controller = CarModelListViewController()
        controller.viewModel = CarListViewModel()
        
        return controller
        
    }
}
