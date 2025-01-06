//
//  CarModel.swift
//  NeoTest
//
//  Created by Bajrang Sinha on 12/12/24.
//

import Foundation

struct CarBrandModel : Decodable {
    let id : String
    let brandName : String
    let manufacturer : String
    let imageUrl : String
    var models : [CarModel]
}


struct CarModel : Decodable {
    let id : String
    let modelName : String
    let imageUrl : String
    let price : String
}
