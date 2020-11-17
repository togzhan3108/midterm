//
//  Holiday.swift
//  Midterm
//
//  Created by Тогжан Салимова on 10/16/20.
//  Copyright © 2020 Тогжан Салимова. All rights reserved.
//

import Foundation

struct HolidayResponse:Decodable {
    var response:Holidays
}

struct Holidays:Decodable {
    var holidays:[HolidayDetails]
}

struct HolidayDetails:Decodable {
    var name: String
    var date:DateInfo
}

struct DateInfo:Decodable{
    var iso:String
    
}
