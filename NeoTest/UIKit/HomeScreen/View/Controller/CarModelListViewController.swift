//
//  CarModelList.swift
//  NeoTest
//
//  Created by Bajrang Sinha on 12/12/24.
//

import UIKit


class CarModelListViewController: UIViewController {
    
    //MARK: - OUTLETS
    
    @IBOutlet weak var tblViewCarModels: UITableView!
    @IBOutlet weak var btnBottomSheet: UIButton!
    
    //MARK: - PROPERTIES
    
    /// The view model that provides data and business logic for the car list.
    /// It is responsible for managing car brand and model information
    /// displayed in the view.
    var viewModel: CarListViewModel?
    
    /// The index of the currently selected car brand.
    /// Used to track which brand is selected and display its associated car models.
    /// Defaults to `0`, representing the first brand in the list.
    var selectedBrandIndex: Int = 0 {
        didSet {
            guard let viewModel else { return }
            viewModel.clearSearch(for: oldValue)
            tblViewCarModels.reloadSections(IndexSet(integer: 1), with: .automatic)
        }
    }
    
    //MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        registerTableViewCell()
        setupUI()
    }
    
    //MARK: - Button Action for presenting Bottom Sheet Controller
    
    @IBAction func bottomSheetAction(_ sender: UIButton) {
        guard let viewModel else { return }
        let allCarModel = viewModel.getAllCarModel(forBrand: selectedBrandIndex)
        let builder = BottomSheetControllerBuilder(carModels: allCarModel)
        let bottomSheetVC = builder.build()
        bottomSheetVC.modalPresentationStyle = .automatic
        present(bottomSheetVC, animated: true, completion: nil)
    }
    
    /// Register cell class for  `CarModelListViewController`.
    ///
    private func registerTableViewCell() {
        tblViewCarModels.registerCell(ofType: CarModelHeaderViewCell.self)
        tblViewCarModels.registerCell(ofType: CarModelListTableViewCell.self)
        tblViewCarModels.registerHeaderFooterView(ofType: CarModelSearchHeaderView.self)
    }
    
    /// Initial setup method for UIElements for this class
    ///
    private func setupUI() {
        btnBottomSheet.layer.cornerRadius = btnBottomSheet.frame.size.height/2.0
        btnBottomSheet.layer.masksToBounds = true
    }
}

//  This extension provides conformance to the `UITableViewDataSource` and `UITableViewDelegate`
//  protocols for the `CarModelListViewController`. It encapsulates the table view's data handling
//  and interaction logic, keeping the main view controller class clean and focused on high-level responsibilities.
//

extension CarModelListViewController: UITableViewDataSource {
    
    /// Returns the number of section in a given table view.
    ///
    /// - Parameters:
    ///   - tableView: The table view requesting the information.
    /// - Returns: The number of section in the table view.
    ///
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    /// Returns the number of rows in a given section of the table view.
    ///
    /// - Parameters:
    ///   - tableView: The table view requesting the information.
    ///   - section: The index of the section.
    /// - Returns: The number of rows in the section.
    ///
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        }else {
            return viewModel?.numberOfModelForBrand(at: selectedBrandIndex) ?? 0
        }
    }
    
    /// Returns a cell configured to display at the specified index path.
    ///
    /// - Parameters:
    ///   - tableView: The table view requesting the cell.
    ///   - indexPath: The index path specifying the location of the cell.
    /// - Returns: A `UITableViewCell` configured for the row.
    ///
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell: CarModelHeaderViewCell = tableView.dequeueCell()
            if let cellVM = viewModel?.getHeaderCellVM() {
                cell.configureCarBrands(withCellVM: cellVM)
            }
            
            cell.pageDidChange = { [weak self] (currentPage) in
                guard let strongSelf = self else { return }
                if currentPage != strongSelf.selectedBrandIndex {
                    strongSelf.selectedBrandIndex = currentPage
                }
            }
            return cell
        }else {
            let cell: CarModelListTableViewCell = tableView.dequeueCell()
            if let model = viewModel?.getCarModel(at: IndexPath(row: indexPath.row, section: selectedBrandIndex)) {
                cell.setupCell(carModel: model)
            }
            return cell
        }
    }
    
}

extension CarModelListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 1 {
            let headerView: CarModelSearchHeaderView = tableView.dequeueHeaderFooterView()
            headerView.txtSearch.text = viewModel?.getSearchText() ?? ""
            headerView.delegate = self
            return headerView
        }
        
        return nil
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 1 {
            return UITableView.automaticDimension
        }
        
        return CGFloat.leastNonzeroMagnitude
    }
}

//  This extension provides conformance to the `SearchHeaderDelegate`
//  protocols for the `CarModelListViewController`. It encapsulates the search data handling
//  and interaction logic, keeping the main view controller class clean and focused on high-level responsibilities.
//

extension CarModelListViewController: SearchHeaderDelegate {
    
    /// Method for getting filtered data as per search text and reloading table view to show updated search data to user
    ///
    /// - Parameters:
    ///   - searchText: this is actual query user typed in search box.
    ///
    func textDidChange(_ searchText: String) {
        guard let viewModel else { return }
        viewModel.filter(by: searchText, for: selectedBrandIndex)
        tblViewCarModels.reloadData()
    }
}
