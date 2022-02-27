//
//  RocketResponseModel.swift
//  SpaceXLaunches
//
//  Created by Ali Hammoud on 2/26/22.
//

import Foundation

struct RocketResponseModel: Codable, Equatable {
    let name: String?
    let description: String?
    let flickr_images: [URL]?
    let wikipedia: URL?
    
    init(name: String?, description: String?, flickr_images: [URL]?, wikipedia: URL?) {
        self.name = name
        self.description = description
        self.flickr_images = flickr_images
        self.wikipedia = wikipedia
    }
}



struct RocketDetailViewViewModel {
    let flightNumber: Int? = 0
    let date: String? = ""
    let name: String?
    let description: String?
    let flickr_images: [URL]?
    let wikipedia: URL?
    
    init(with model: RocketResponseModel) {
//        self.flightNumber = model.flightNumber
//        self.date = model.date
        self.name = model.name
        self.description = model.description
        self.flickr_images = model.flickr_images
        self.wikipedia = model.wikipedia
    }
}
