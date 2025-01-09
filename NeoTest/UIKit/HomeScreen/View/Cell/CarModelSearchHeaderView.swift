//
//  CarModelSearchHeaderView.swift
//  NeoTest
//
//  Created by Bajrang Sinha on 12/12/24.
//

import UIKit

protocol SearchHeaderDelegate: AnyObject {
    func textDidChange(_ searchText: String)
}

class CarModelSearchHeaderView: UITableViewHeaderFooterView {

    //MARK: - OUTLETS
    
    @IBOutlet weak var txtSearch: UITextField!
    
    //MARK: - PROPERTIES
    
    /// A `DispatchWorkItem` used for implementing a debounce mechanism.
    /// This helps delay the execution of search-related tasks, ensuring that
    /// search logic is not triggered for every keystroke, but only after the user
    /// has stopped typing for a specified delay.
    private var searchDebounceWorkItem: DispatchWorkItem?
    
    /// The delay (in seconds) used for the debounce mechanism.
    /// Controls how long the app waits after the user stops typing before executing
    /// the search logic. Defaults to `0.3` seconds.
    private let debounceDelay: TimeInterval = 0.3
    
    /// A weak reference to the delegate that conforms to `SearchHeaderDelegate`.
    /// The delegate is notified of search-related actions or updates.
    /// - Note: The use of `weak` prevents strong reference cycles.
    weak var delegate: SearchHeaderDelegate?
    
    //MARK: - Header View Life Cycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        txtSearch.setLeftImage(imageName: Constants.IconNames.search)
        txtSearch.addTarget(self, action: #selector(textDidChange(_:)), for: .editingChanged)
    }
    
    /// Observer for text editing changes for text field.
    ///
    /// - Parameters:
    ///   - textField: The text field for which observer called.
    ///
    @objc func textDidChange(_ textField: UITextField) {
        searchDebounceWorkItem?.cancel()
        searchDebounceWorkItem = DispatchWorkItem(block: {[weak self] in
            self?.delegate?.textDidChange(textField.text ?? "")
        })
        
        DispatchQueue.main.asyncAfter(deadline: .now() + debounceDelay, execute: searchDebounceWorkItem!)
        
    }
}
