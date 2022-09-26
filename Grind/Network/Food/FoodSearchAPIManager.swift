//
//  FatSecretManager.swift
//  Grind
//
//  Created by 최형민 on 2022/09/23.
//

import Foundation
import Alamofire
import SwiftyJSON

final class FoodSearchAPIManager {
    
    private init() {}
    
    // Singleton
    static let shared = FoodSearchAPIManager()
    
//    func fetchImageUrl(page: Int, query: String, completionHandler: @escaping ([FatSecretModel]) -> ()) {
//
//        let url = Endpoint.unsplashURL + "page=\(page)&query=\(query)&client_id=\(APIKey.unsplashAccessKey)"
//
//        AF.request(url, method: .get).validate().responseData { response in
//            switch response.result {
//            case .success(let value):
//                let json = JSON(value)
//                let imageList: [ImageSearchModel] = json["results"].arrayValue.map { ImageSearchModel(full_url: $0["urls"]["full"].stringValue) }
//                completionHandler(imageList)
//
//            case .failure(let error):
//                print(error)
//            }
//        }
//    }
}
