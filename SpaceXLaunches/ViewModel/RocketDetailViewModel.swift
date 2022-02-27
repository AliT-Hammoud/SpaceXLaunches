//
//  RocketDetailViewModel.swift
//  SpaceXLaunches
//
//  Created by Ali Hammoud on 2/26/22.
//

import Foundation

protocol RocketDetailViewModelType {
//    var imageVMs: BehaviorRelay<[RocketDetailImageCollectionViewCellViewModel]> { get }
//    var title: BehaviorRelay<String?> { get }
//    var description: BehaviorRelay<String?> { get }
//    var url: BehaviorRelay<URL?> { get }
//    var buttonTapAction: PublishSubject<Void> { get }
//    var notifyError: BehaviorRelay<Error?> { get }
//    var rocket: BehaviorRelay<Rocket?> { get }
    
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
    
//    convenience init(rocket: RocketResponseModel, apiService: APIServiceProtocol = APIService()) {
//        self.init(apiService: apiService)
//        processFetchedRockets(rocket: rocket)
//    }
    
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
//        title.accept(rocket.name)
//        description.accept(rocket.description)
//        url.accept(rocket.wikipedia)
        
//        imageVMs.accept({ () -> [RocketDetailImageCollectionViewCellViewModel] in
//            return (rocket.flickr_images?.compactMap({ (url) -> RocketDetailImageCollectionViewCellViewModel? in
//                return RocketDetailImageCollectionViewCellViewModel(imageURL: url)
//            }) ?? [])
//        }())
        
//        self.rocket.accept(rocket)

    }
}


