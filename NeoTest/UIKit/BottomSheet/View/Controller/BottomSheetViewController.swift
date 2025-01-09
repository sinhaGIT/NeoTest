//
//  BottomSheetViewController.swift
//  NeoTest
//
//  Created by Bajrang Sinha on 29/12/24.
//

import UIKit

class BottomSheetViewController: UIViewController {
    
    //MARK: - OUTLETS

    @IBOutlet weak var tblViewStatistic: UITableView!
    @IBOutlet weak var lblCharacterCount: UILabel!
    @IBOutlet weak var lblItemCount: UILabel!
    
    //MARK: - PROPERTIES
    
    var viewModel: BottomSheetViewModel?
    
    //MARK: - View Life Cycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()

        registerCell()
        setupView()
    }
    
    /// Register cell class for  `BottomSheetViewController`.
    ///
    private func registerCell() {
        tblViewStatistic.register(UITableViewCell.self, forCellReuseIdentifier: Constants.CellIdentifiers.statisticCell)
    }
    
    
    /// Initial setup method for labels for this class
    ///
    private func setupView() {
        guard let viewModel else { return }
        lblItemCount.text = viewModel.getTotalItemText()
        lblCharacterCount.text = viewModel.getSectionTitle()
    }
}

//  This extension provides conformance to the `UITableViewDataSource` and `UITableViewDelegate`
//  protocols for the `BottomSheetViewController`. It encapsulates the table view's data handling
//  and interaction logic, keeping the main view controller class clean and focused on high-level responsibilities.
//

extension BottomSheetViewController: UITableViewDataSource, UITableViewDelegate {
    
    /// Returns the number of rows in a given section of the table view.
    ///
    /// - Parameters:
    ///   - tableView: The table view requesting the information.
    ///   - section: The index of the section.
    /// - Returns: The number of rows in the section.
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.numberOfRows() ?? 0
    }
    
    /// Returns a cell configured to display at the specified index path.
    ///
    /// - Parameters:
    ///   - tableView: The table view requesting the cell.
    ///   - indexPath: The index path specifying the location of the cell.
    /// - Returns: A `UITableViewCell` configured for the row.
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: Constants.CellIdentifiers.statisticCell)
        cell.selectionStyle = .none
        cell.textLabel?.text = viewModel?.getFormattedText(forRow: indexPath.row)
        return cell
    }
}

