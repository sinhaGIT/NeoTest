//
//  CarModelList.swift
//  NeoTest
//
//  Created by Bajrang Sinha on 12/12/24.
//

import UIKit


class CarModelListViewController: UIViewController {
    
    @IBOutlet weak var tblViewCarModels: UITableView!
    @IBOutlet weak var btnBottomSheet: UIButton!
    
    var viewModel: CarListViewModel!
    var selectedBrandIndex: Int = 0 {
        didSet {
            viewModel.isSearchStarted = false
            viewModel.clearSearch(for: oldValue)
            tblViewCarModels.reloadSections(IndexSet(integer: 1), with: .automatic)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tblViewCarModels.registerCell(ofType: CarModelHeaderViewCell.self)
        tblViewCarModels.registerCell(ofType: CarModelListTableViewCell.self)
        tblViewCarModels.registerHeaderFooterView(ofType: CarModelSearchHeaderView.self)
        btnBottomSheet.layer.cornerRadius = btnBottomSheet.frame.size.height/2.0
        btnBottomSheet.layer.masksToBounds = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
    }
    
    @IBAction func bottomSheetAction(_ sender: UIButton) {
        let builder = BottomSheetControllerBuilder(carModels: viewModel.getAllCarModel(forBrand: selectedBrandIndex))
        let bottomSheetVC = builder.build()
        bottomSheetVC.modalPresentationStyle = .automatic
        present(bottomSheetVC, animated: true, completion: nil)
    }
}


extension CarModelListViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        }else {
            return viewModel.numberOfModelForBrand(at: selectedBrandIndex)
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell: CarModelHeaderViewCell = tableView.dequeueCell()
            cell.configureCarBrands(withVM: viewModel)
            cell.pageDidChange = { [weak self] (currentPage) in
                guard let strongSelf = self else { return }
                if currentPage != strongSelf.selectedBrandIndex {
                    strongSelf.selectedBrandIndex = currentPage
                }
            }
            return cell
        }else {
            let cell: CarModelListTableViewCell = tableView.dequeueCell()
            let model = viewModel.getCarModel(at: IndexPath(row: indexPath.row, section: selectedBrandIndex))
            cell.setupCell(carModel: model)
            return cell
        }
    }
    
}

extension CarModelListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 1 {
            let headerView: CarModelSearchHeaderView = tableView.dequeueHeaderFooterView()
            headerView.txtSearch.text = viewModel.getSearchText()
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

extension CarModelListViewController: SearchHeaderDelegate {
    func textDidChange(_ searchText: String) {
        let oldCount = viewModel.numberOfModelForBrand(at: selectedBrandIndex)
        viewModel.filter(by: searchText, for: selectedBrandIndex)
        let newCount = viewModel.numberOfModelForBrand(at: selectedBrandIndex)
        tblViewCarModels.reloadRowsInSection(section: 1, oldCount: oldCount, newCount: newCount)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        viewModel.isSearchStarted = false
    }
}
