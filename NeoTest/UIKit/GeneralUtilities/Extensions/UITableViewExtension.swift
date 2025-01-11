//
//  UITableViewExtension.swift
//  NeoTest
//
//  Created by Bajrang Sinha on 12/12/24.
//

import UIKit

extension UITableView {
    
    /**
     Registers a cell with the table view.
     Depends on the assumption that the cell's reuse identifier matches its class name.
     If a nib is found in the main app bundle with a filename matching the cell's class name, that nib is registered with the table view. Otherwise, the cell's class is registered with the table view.
     - parameters:
     - type: The class type of the cell to register.
     */
    func registerCell<T: UITableViewCell>(ofType type: T.Type) {
        let cellName = String(describing: T.self)
        
        if Bundle.main.path(forResource: cellName, ofType: Constants.FileExtensionNames.nib) != nil {
            let nib = UINib(nibName: cellName, bundle: Bundle.main)
            register(nib, forCellReuseIdentifier: cellName)
        } else {
            register(T.self, forCellReuseIdentifier: cellName)
        }
    }
    
    func registerHeaderFooterView<T: UITableViewHeaderFooterView>(ofType type: T.Type) {
        let headerName = String(describing: T.self)
        if Bundle.main.path(forResource: headerName, ofType: Constants.FileExtensionNames.nib) != nil {
            let nib = UINib(nibName: headerName, bundle: Bundle.main)
            register(nib, forHeaderFooterViewReuseIdentifier: headerName)
        }
    }
    
    
    /**
     Dequeues a cell that has been previously registered for use with the table view.
     Depends on the assumption that the cell's class name and reuse identifier are the same.
     - returns: A UITableViewCell already typed to match the `type` provided to the function.
     */
    func dequeueCell<T: UITableViewCell>() -> T     {
        let cellName = String(describing: T.self)
        
        return dequeueReusableCell(withIdentifier: cellName) as! T
    }
    
    func dequeueHeaderFooterView<T: UITableViewHeaderFooterView>() -> T {
        let headerFooterName = String(describing: T.self)
        
        return dequeueReusableHeaderFooterView(withIdentifier: headerFooterName) as! T
    }
}


extension UICollectionView {
    /**
     Registers a cell with the table view.
     Depends on the assumption that the cell's reuse identifier matches its class name.
     If a nib is found in the main app bundle with a filename matching the cell's class name, that nib is registered with the table view. Otherwise, the cell's class is registered with the table view.
     - parameters:
     - type: The class type of the cell to register.
     */
    func registerCell<T: UICollectionViewCell>(ofType type: T.Type) {
        let cellName = String(describing: T.self)
        
        if Bundle.main.path(forResource: cellName, ofType: Constants.FileExtensionNames.nib) != nil {
            let nib = UINib(nibName: cellName, bundle: Bundle.main)
            register(nib, forCellWithReuseIdentifier: cellName)
        } else {
            register(T.self, forCellWithReuseIdentifier: cellName)
        }
    }
    
    
    /**
     Dequeues a cell that has been previously registered for use with the table view.
     Depends on the assumption that the cell's class name and reuse identifier are the same.
     - returns: A UITableViewCell already typed to match the `type` provided to the function.
     */
    func dequeueCell<T: UICollectionViewCell>(indexPath: IndexPath) -> T     {
        let cellName = String(describing: T.self)
        
        return dequeueReusableCell(withReuseIdentifier: cellName, for: indexPath) as! T
    }
}
