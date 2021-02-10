//
//  Holiday.swift
//  HolidayDetails
//
//  Created by Jovial Software on 10/11/20.
//

import Foundation
struct HolidayResponse:Codable{
    var response:Holidays
}
struct Holidays:Codable{
    var holidays:[HolidayDetail]
}
struct HolidayDetail:Codable{
    var name:String
    var date:DateInfo
}
struct DateInfo:Codable{
    var iso:String
}
