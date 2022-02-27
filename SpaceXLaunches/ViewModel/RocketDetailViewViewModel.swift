//
//  RocketDetailViewViewModel.swift
//  SpaceXLaunches
//
//  Created by Ali Hammoud on 27/02/2022.
//

import Foundation

struct RocketDetailViewViewModel {
    let flightNumber: Int? = 0
    let date: String? = ""
    let name: String?
    let description: String?
    let flickr_images: [URL]?
    let wikipedia: URL?
    
    init(with model: RocketResponseModel) {
        self.name = model.name
        self.description = model.description
        self.flickr_images = model.flickr_images
        self.wikipedia = model.wikipedia
    }
}
