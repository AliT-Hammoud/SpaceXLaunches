//
//  LaunchListViewModel.swift
//  SpaceXLaunches
//
//  Created by Ali Hammoud on 2/25/22.
//

import Foundation

protocol LaunchListViewModelType {
    func fetchLaunchesWithQuery(completionHandle: (([RocketLaunchesCollectionViewCellViewModel]?)->())?)
}

class LaunchListViewModel: LaunchListViewModelType {
    
    let apiService: APIServiceProtocol
    
    init(apiService: APIServiceProtocol = APIService()) {
        self.apiService = apiService
        self.fetchLaunchesWithQuery(){_ in}
    }
    
    func fetchLaunchesWithQuery(completionHandle: (([RocketLaunchesCollectionViewCellViewModel]?)->())?) {
        apiService.fetchLaunchesWithQuery { [weak self] (launchResponse, error, _)  in
            guard let strongSelf = self else { return }
            guard error == nil  else {return}
            if let launchResponse = launchResponse {
                guard let launchResponseViewModel = strongSelf.processFetchedLaunches(launchResponse: launchResponse) else {
                    completionHandle?(nil)
                    return
                }
                completionHandle?(launchResponseViewModel)
            }
        }
    }
    
    func processFetchedLaunches(launchResponse: LaunchResponseModel) -> [RocketLaunchesCollectionViewCellViewModel]?{
        guard let launches = launchResponse.docs else { return nil}
        return self.convertLaunchesToLaunchListTableViewCellViewModels(launches: launches)
    }
    
    func convertLaunchesToLaunchListTableViewCellViewModels(launches: [Launch]) -> [RocketLaunchesCollectionViewCellViewModel] {
        var launchListTableViewCellViewModels: [RocketLaunchesCollectionViewCellViewModel] = []
        for launch in launches {
            if launch.isSuccess == true || launch.upcoming == true {
                launchListTableViewCellViewModels.append(RocketLaunchesCollectionViewCellViewModel(with: launch))
            }
        }
        return launchListTableViewCellViewModels
    }
}
