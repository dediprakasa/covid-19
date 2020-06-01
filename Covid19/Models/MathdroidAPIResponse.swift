//
//  MathdroidAPIResponse.swift
//  Covid19
//
//  Created by Dedi Prakasa on 5/7/20.
//  Copyright © 2020 Dedi Prakasa. All rights reserved.
//

import Foundation

struct MathdroidAPIResponse: Decodable {
    
    let confirmed: Confirmed
    let recovered: Recovered
    let deaths: Deaths
}

struct Confirmed: Decodable {
    let value: Int
    let detail: String
}

struct Recovered: Decodable {
    let value: Int
    let detail: String
}

struct Deaths: Decodable {
    let value: Int
    let detail: String
}

struct Country: Decodable {
    let name: String
    let iso2: String?
}
