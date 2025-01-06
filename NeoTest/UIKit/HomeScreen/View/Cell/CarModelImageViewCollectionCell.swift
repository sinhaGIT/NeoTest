//
//  CarModelImageViewCollectionCell.swift
//  NeoTest
//
//  Created by Bajrang Sinha on 12/12/24.
//

import UIKit

class CarModelImageViewCollectionCell: UICollectionViewCell {
    
    @IBOutlet weak var imgViewCarManuf: UIImageView!

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
