//
//  CarModelImageViewCollectionCell.swift
//  NeoTest
//
//  Created by Bajrang Sinha on 12/12/24.
//

import UIKit

class CarModelImageViewCollectionCell: UICollectionViewCell {
    
    //MARK: - OUTLETS
    
    @IBOutlet weak var imgViewCarManuf: UIImageView!
    
    //MARK: - Cell Life Cycle

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        imgViewCarManuf.layer.cornerRadius = 12.0
        imgViewCarManuf.layer.masksToBounds = true
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imgViewCarManuf.image = nil
    }

}
