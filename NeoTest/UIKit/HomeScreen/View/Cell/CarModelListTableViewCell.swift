//
//  CarModelListTableViewCell.swift
//  NeoTest
//
//  Created by Bajrang Sinha on 12/12/24.
//

import UIKit

class CarModelListTableViewCell: UITableViewCell {
    
    @IBOutlet weak var lblCarModelName: UILabel!
    @IBOutlet weak var lblCarModelPrice: UILabel!
    
    @IBOutlet weak var imgViewCarModel: UIImageView!
    @IBOutlet weak var viewContainer: UIView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        viewContainer.layer.cornerRadius = 12.0
        viewContainer.layer.masksToBounds = true
        imgViewCarModel.layer.cornerRadius = 8.0
        imgViewCarModel.layer.masksToBounds = true
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imgViewCarModel.image = nil
    }
    
    func setupCell(carModel: CarModel) {
        lblCarModelName.text = carModel.modelName
        lblCarModelPrice.text = carModel.price
        imgViewCarModel.image = UIImage(named: carModel.imageUrl)
    }
    
}
