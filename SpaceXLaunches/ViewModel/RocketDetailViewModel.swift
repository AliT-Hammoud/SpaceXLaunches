//
//  RocketDetailViewModel.swift
//  SpaceXLaunches
//
//  Created by Ali Hammoud on 2/26/22.
//

import Foundation

protocol RocketDetailViewModelType {
    func fetchRocket(rocketName: String, completionHandler: ((RocketDetailViewViewModel?)->())?)
}

class RocketDetailViewModel: RocketDetailViewModelType {
    let apiService: APIServiceProtocol
    
    init(apiService: APIServiceProtocol = APIService()) {
        self.apiService = apiService
    }
    
    convenience init(rocketName: String, apiService: APIServiceProtocol = APIService()) {
        self.init(apiService: apiService)
        fetchRocket(rocketName: rocketName) {_ in}
    }
    func fetchRocket(rocketName: String, completionHandler: ((RocketDetailViewViewModel?)->())? ) {
        _ = apiService.fetchRocket(rocketName: rocketName, completion: { [weak self] (rocket, error, _) in
            guard let strongSelf = self else { return }
            guard error == nil else {return}
            if let rocket = rocket {
                let rocketViewModel = strongSelf.processFetchedRockets(rocket: rocket)
                completionHandler?(rocketViewModel)
            }
        })
    }
    
    func processFetchedRockets(rocket: RocketResponseModel) -> RocketDetailViewViewModel {
        return RocketDetailViewViewModel(with: rocket)
    }
}


