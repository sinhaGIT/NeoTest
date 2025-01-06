//
//  CarModelSearchHeaderView.swift
//  NeoTest
//
//  Created by Bajrang Sinha on 12/12/24.
//

import UIKit

protocol SearchHeaderDelegate: AnyObject {
    func textDidChange(_ searchText: String)
    func textFieldDidEndEditing(_ textField: UITextField)
}

class CarModelSearchHeaderView: UITableViewHeaderFooterView {

    @IBOutlet weak var txtSearch: UITextField!
    
    private var searchDebounceWorkItem: DispatchWorkItem?
    private let debounceDelay: TimeInterval = 0.3
    weak var delegate: SearchHeaderDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        txtSearch.setLeftImage(imageName: "search")
        txtSearch.delegate = self
        txtSearch.addTarget(self, action: #selector(textDidChange(_:)), for: .editingChanged)
    }

    @objc func textDidChange(_ textField: UITextField) {
        searchDebounceWorkItem?.cancel()
        searchDebounceWorkItem = DispatchWorkItem(block: {[weak self] in
            self?.delegate?.textDidChange(textField.text ?? "")
        })
        
        DispatchQueue.main.asyncAfter(deadline: .now() + debounceDelay, execute: searchDebounceWorkItem!)
        
    }
}

extension CarModelSearchHeaderView: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        self.delegate?.textFieldDidEndEditing(textField)
    }
}
