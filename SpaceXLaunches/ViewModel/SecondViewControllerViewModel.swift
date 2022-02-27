//
//  SecondViewControllerViewModel.swift
//  SpaceXLaunches
//
//  Created by Ali Hammoud on 27/02/2022.
//

import Foundation

struct SecondViewControllerViewModel {
    var rocket: String
    let date: String?
    let flightNumberS: Int?
    let dateLocal: String?

    init(with viewModel: RocketLaunchesCollectionViewCellViewModel) {
        self.rocket = viewModel.rocket ?? ""
        self.date = viewModel.date
        self.flightNumberS = viewModel.flightNumberS
        self.dateLocal = viewModel.date
    }
}
