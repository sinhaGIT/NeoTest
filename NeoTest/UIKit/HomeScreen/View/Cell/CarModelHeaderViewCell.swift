//
//  CarModelHeaderViewCell.swift
//  NeoTest
//
//  Created by Bajrang Sinha on 27/12/24.
//

import UIKit

class CarModelHeaderViewCell: UITableViewCell {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var heightConstraint: NSLayoutConstraint!

    var pageDidChange: ((Int) -> Void)?
    private var currentPage: Int = 0 {
        didSet {
            pageControl.currentPage = currentPage
            pageDidChange?(currentPage)
        }
    }
    private var viewModel: CarListViewModel!

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

    func configureCarBrands(withVM: CarListViewModel) {
        viewModel = withVM
        collectionView.registerCell(ofType: CarModelImageViewCollectionCell.self)
        collectionView.dataSource = self
        collectionView.delegate = self
        pageControl.numberOfPages = viewModel.numberOfCarBrands()
    }
}

extension CarModelHeaderViewCell: UICollectionViewDataSource, UICollectionViewDelegate {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfCarBrands()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: CarModelImageViewCollectionCell = collectionView.dequeueCell(indexPath: indexPath)
        
        let imageName = viewModel.getBrandImageName(at: indexPath)
        cell.imgViewCarManuf.image = UIImage(named: imageName)
        
        return cell
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {

        currentPage = Int(scrollView.contentOffset.x) / Int(scrollView.frame.width)
    }

    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {

        currentPage = Int(scrollView.contentOffset.x) / Int(scrollView.frame.width)
    }
}


extension CarModelHeaderViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = screenWidth - 40.0
        let height = (180 / 353) * width
        
        return CGSize(width: width, height: height)
    }
}
