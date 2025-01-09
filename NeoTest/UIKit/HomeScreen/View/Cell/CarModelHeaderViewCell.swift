//
//  CarModelHeaderViewCell.swift
//  NeoTest
//
//  Created by Bajrang Sinha on 27/12/24.
//

import UIKit

class CarModelHeaderViewCell: UITableViewCell {
    
    //MARK: - OUTLETS
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var heightConstraint: NSLayoutConstraint!
    
    //MARK: - Properties

    /// A closure that gets called whenever the page changes.
    /// - Parameter page: The index of the newly selected page.
    /// This can be used to notify other components or update the UI
    /// based on the current page selection.
    var pageDidChange: ((Int) -> Void)?
    
    /// The index of the currently selected page.
    /// Tracks the page currently being viewed by the user in a paginated view.
    /// - Note: This property is private and any updates to it should trigger
    /// logic for notifying changes through `pageDidChange`.
    private var currentPage: Int = 0 {
        didSet {
            pageControl.currentPage = currentPage
            pageDidChange?(currentPage)
        }
    }
    
    /// The cell view model of the header view
    /// - Note: This property is private
    private var cellViewModel: CarBrandHeaderViewModel?
    
    //MARK: - Cell Life Cycle Method

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        let width = screenWidth - 40.0
        let height = (180 / 353) * width
        
        heightConstraint.constant = height
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    /// Configure header view with cell view model.
    ///
    /// - Parameter cellVM: A view model for handling business logic.
    ///
    func configureCarBrands(withCellVM cellVM: CarBrandHeaderViewModel) {
        cellViewModel = cellVM
        collectionView.registerCell(ofType: CarModelImageViewCollectionCell.self)
        collectionView.dataSource = self
        collectionView.delegate = self
        pageControl.numberOfPages = cellVM.numberOfCarBrands()
    }
}

//  This extension provides conformance to the `UICollectionViewDataSource` and `UICollectionViewDelegate`
//  protocols for the `CarModelHeaderViewCell`. It encapsulates the table header view's data handling
//  and interaction logic, keeping the header view class clean and focused on high-level responsibilities.
//
extension CarModelHeaderViewCell: UICollectionViewDataSource, UICollectionViewDelegate {

    /// Returns the number of items in a given section of the collection view.
    ///
    /// - Parameters:
    ///   - collectionView: The collection view requesting the information.
    ///   - section: The index of the section.
    /// - Returns: The number of items in the section.
    ///
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cellViewModel?.numberOfCarBrands() ?? 0
    }
    
    /// Returns a cell configured to display at the specified index path.
    ///
    /// - Parameters:
    ///   - collectionView: The collection view requesting the cell.
    ///   - indexPath: The index path specifying the location of the cell.
    /// - Returns: A `UICollectionViewCell` configured for the row.
    ///
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: CarModelImageViewCollectionCell = collectionView.dequeueCell(indexPath: indexPath)
        
        if let vm = cellViewModel {
            let imageName = vm.getBrandImageName(at: indexPath)
            cell.imgViewCarManuf.image = UIImage(named: imageName)
        }
        
        return cell
    }
    
    /// For updating page number
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {

        currentPage = Int(scrollView.contentOffset.x) / Int(scrollView.frame.width)
    }

    /// For updating page number 
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {

        currentPage = Int(scrollView.contentOffset.x) / Int(scrollView.frame.width)
    }
}

//  This extension provides conformance to the `UICollectionViewDelegateFlowLayout`
// For calculating item size i.e height and width
//
extension CarModelHeaderViewCell: UICollectionViewDelegateFlowLayout {
    
    /// Returns a size to use at the specified index path.
    ///
    /// - Parameters:
    ///   - collectionView: The collection view requesting the cell.
    ///   - collectionViewLayout: layout used by collection view
    ///   - indexPath: The index path specifying the location of the cell.
    /// - Returns: A `CGSize` calculated for the row.
    ///
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = screenWidth - 40.0
        let height = (180 / 353) * width
        
        return CGSize(width: width, height: height)
    }
}
