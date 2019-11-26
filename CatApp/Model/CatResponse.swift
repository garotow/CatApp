//
//  CatResponse.swift
//  CatApp
//
//  Created by Henrique Lima on 25/11/19.
//  Copyright © 2019 Henrique Lima. All rights reserved.
//

import Foundation

struct CatResponse: Codable {
    let data: [Cat]
}

struct Cat: Codable {
    let images: [Images]?
}

struct Images: Codable {
    let link: String
}
