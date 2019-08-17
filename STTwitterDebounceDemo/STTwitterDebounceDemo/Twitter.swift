//
//  Twitter.swift
//  STTwitterDebounceDemo
//
//  Created by Vinicius Mangueira on 10/08/19.
//  Copyright © 2019 Vinicius Mangueira . All rights reserved.
//

import Foundation

struct Tweet: Decodable {
    let text: String
    let user: User
    let image: String?
}

struct User: Decodable {
    let name, profileImageUrl: String
}
