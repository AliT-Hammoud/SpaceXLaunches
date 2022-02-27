//
//  RocketLaunchesCollectionViewCellViewModel.swift
//  SpaceXLaunches
//
//  Created by Ali Hammoud on 2/25/22.
//

import Foundation

struct RocketLaunchesCollectionViewCellViewModel {
    let flightNumberS: Int?
    var date: String?
    let name: String?
    let upcoming: Bool?
    let isSuccess: Bool?
    let rocket: String?
    
    init(with model: Launch) {
        self.flightNumberS = model.flightNumber
        self.date = Self.convertDateFormatter(date: model.date_local ?? "")
        self.name = model.name
        self.upcoming = model.upcoming
        self.isSuccess = model.isSuccess
        self.rocket = model.rocket
    }
    
    private static func convertDateFormatter(date: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        let convertedDate = dateFormatter.date(from: date)

        guard dateFormatter.date(from: date) != nil else {
            return ""
        }

        dateFormatter.dateFormat = "d MMM yyyy, HH:mm zz"
        let timeStamp = dateFormatter.string(from: convertedDate!)
        return timeStamp
    }
}
