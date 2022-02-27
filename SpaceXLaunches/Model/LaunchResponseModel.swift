//
//  LaunchResponseModel.swift
//  SpaceXLaunches
//
//  Created by Ali Hammoud on 2/25/22.
//

import Foundation

struct LaunchResponseModel: Codable {
    let docs: [Launch]?
}

struct Launch: Codable {
    let id: String?
    let name: String?
    let details: String?
    let date_local: String?
    let upcoming: Bool?
    let isSuccess: Bool?
    let rocket: String?
    let flightNumber: Int?
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case details
        case date_local
        case upcoming
        case isSuccess = "success"
        case rocket
        case flightNumber = "flight_number"
        
    }
}
