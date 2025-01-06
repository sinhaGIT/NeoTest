//
//  BottomSheetViewController.swift
//  NeoTest
//
//  Created by Bajrang Sinha on 29/12/24.
//

import UIKit

class BottomSheetViewController: UIViewController {

    @IBOutlet weak var tblViewStatistic: UITableView!
    @IBOutlet weak var lblCharacterCount: UILabel!
    @IBOutlet weak var lblItemCount: UILabel!
    
    var viewModel: BottomSheetViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        tblViewStatistic.register(UITableViewCell.self, forCellReuseIdentifier: "statisticCell")
        lblItemCount.text = viewModel.getTotalItemText()
        lblCharacterCount.text = viewModel.getSectionTitle()
    }
}

extension BottomSheetViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "statisticCell")
        cell.selectionStyle = .none
        cell.textLabel?.text = viewModel.getFormattedText(forRow: indexPath.row)
        return cell
    }
}

