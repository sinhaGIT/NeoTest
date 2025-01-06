//
//  CarMakerModel.swift
//  NeoTest
//
//  Created by Bajrang Sinha on 05/01/25.
//

import Foundation

struct CarMakerModel : Identifiable, Decodable {
    let id : String
    let brandName : String
    let manufacturer : String
    let imageUrl : String
    var models : [CarSubModel]
}


struct CarSubModel : Identifiable, Decodable {
    let id : String
    let modelName : String
    let imageUrl : String
    let price : String
}
