//
//  APIService.swift
//  SpaceXLaunches
//
//  Created by Ali Hammoud on 2/25/22.
//

import Alamofire

protocol APIServiceProtocol {
    func fetchLaunchesWithQuery(startDate: Date, endDate: Date, completion: @escaping (LaunchResponseModel?, Error?, AFDataResponse<Any>) -> Void) -> DataRequestProtocol
    func fetchRocket(rocketName: String, completion: @escaping (RocketResponseModel?, Error?, AFDataResponse<Any>) -> Void) -> DataRequestProtocol
}

extension APIServiceProtocol {
    @discardableResult func fetchLaunchesWithQuery(
        startDate: Date = Calendar.current.date(byAdding: .year, value: -3, to: Date()) ?? Date(),
        endDate: Date = Date(),
        completion: @escaping (LaunchResponseModel?, Error?, AFDataResponse<Any>) -> Void) -> DataRequestProtocol {
        return fetchLaunchesWithQuery(startDate: startDate, endDate: endDate, completion: completion)
    }
    
    @discardableResult func fetchRocket(rocketName: String, completion: @escaping (RocketResponseModel?, Error?, AFDataResponse<Any>) -> Void) -> DataRequestProtocol {
        return fetchRocket(rocketName: rocketName, completion: completion)
    }
}

class APIService: APIServiceProtocol {
    let baseUrlString: String
    var sessionManager: SessionProtocol
    
    init(baseUrlString: String = "https://api.spacexdata.com/v4",
         sessionManager: SessionProtocol = AF) {
        self.baseUrlString = baseUrlString
        self.sessionManager = sessionManager
    }
    
    @discardableResult func fetchLaunchesWithQuery(startDate: Date, endDate: Date, completion: @escaping (LaunchResponseModel?, Error?, AFDataResponse<Any>) -> Void) -> DataRequestProtocol {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyyMMdd'T'HHmmssZ"
        let parameters = [
            "query": [
//                TODO: data_utc < 3 && (upcomming == true || success == true)
//                "upcoming" : true,
//                "success" : true,
                "date_utc": [
                    "$gte": dateFormatter.string(from: startDate),
                    "$lte": dateFormatter.string(from: endDate)
                ],
            ],
            "options": [
                "sort": [
                    "utc_date": "asc"
                ],
                "pagination": false
            ]
        ]
        
        let postLaunchesQueryEndpoint = "\(baseUrlString)/launches/query"
        let method: HTTPMethod = .post
        let headers: HTTPHeaders? = nil
        
        return sessionManager.request(postLaunchesQueryEndpoint, method: method, parameters: parameters, encoding: method == .get ? URLEncoding.default : JSONEncoding.default, headers: headers)
            .responseJSON { dataResponse in
                guard let data = dataResponse.data else { return }
                
                let decoder = JSONDecoder()
                do {
                    let launches = try decoder.decode(LaunchResponseModel.self, from: data)
                    completion(launches, nil, dataResponse)
                } catch {
                    completion(nil, error, dataResponse)
                }
            }
    }
    
    @discardableResult func fetchRocket(rocketName: String, completion: @escaping (RocketResponseModel?, Error?, AFDataResponse<Any>) -> Void) -> DataRequestProtocol {

        let postLaunchesQueryEndpoint = "\(baseUrlString)/rockets/\(rocketName)"

        return sessionManager.request(postLaunchesQueryEndpoint, method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil)
            .responseJSON { dataResponse in
                guard let data = dataResponse.data else { return }

                let decoder = JSONDecoder()
                do {
                    let rocket = try decoder.decode(RocketResponseModel.self, from: data)
                    completion(rocket, nil, dataResponse)
                } catch {
                    completion(nil, error, dataResponse)
                }
            }
    }
}

protocol SessionProtocol {
    func request(_ convertible: URLConvertible,
                      method: HTTPMethod,
                      parameters: Parameters?,
                      encoding: ParameterEncoding,
                      headers: HTTPHeaders?) -> DataRequestProtocol
}

protocol DataRequestProtocol {
    func responseJSON(completionHandler: @escaping (AFDataResponse<Any>) -> Void) -> Self
}

extension Alamofire.Session: SessionProtocol {
    func request(_ convertible: URLConvertible, method: HTTPMethod, parameters: Parameters?, encoding: ParameterEncoding, headers: HTTPHeaders?) -> DataRequestProtocol {
        return request(convertible, method: method, parameters: parameters, encoding: encoding, headers: headers, interceptor: nil, requestModifier: nil)
    }
}

extension DataRequest: DataRequestProtocol {
    func responseJSON(completionHandler: @escaping (AFDataResponse<Any>) -> Void) -> Self {
        return responseJSON(queue: .main, dataPreprocessor: JSONResponseSerializer.defaultDataPreprocessor, emptyResponseCodes: JSONResponseSerializer.defaultEmptyResponseCodes, emptyRequestMethods: JSONResponseSerializer.defaultEmptyRequestMethods, options: .allowFragments, completionHandler: completionHandler)
    }
}
