//
//  Models.swift
//  Midterm
//
//  Created by Тогжан Салимова on 10/17/20.
//  Copyright © 2020 Тогжан Салимова. All rights reserved.
//

import Foundation

class UsersResponse {
    var users : [Data]?
    var page : Int?
    var perPage : Int?
    var total : Int?
    var totalPages : Int?
}

struct Data : Decodable {
    let avatar : String
    let email : String
    let firstName : String
    let id : Int
    let lastName : String
}
