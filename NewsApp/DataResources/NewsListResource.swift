//
//  NewsListResource.swift
//  NewsApp
//
//  Created by User on 08/07/23.
//

import Foundation

public struct NewsListResource
{
    private let httpUtility: HTTPUtility
    
    init(httpUtility: HTTPUtility) {
        self.httpUtility = httpUtility
    }
    
    func getNewsList(
        request: RequestModelProtocol,
        completion: @escaping (_ result: NewsResponseModel?) -> Void
    ) {
       
        var urlComponent = URLComponents(string: request.baseURL)
        urlComponent?.path = request.path
        urlComponent?.queryItems = request.queryItems
        
        guard let urlComponent = urlComponent,
        let finalURL = urlComponent.url else {
            return completion(nil)
        }
        
        switch request.httpMethod {
        case .GET:
            httpUtility.getData(
                requestUrl: finalURL,
                resultType: NewsResponseModel.self
            ) { newsResponse in
                
                completion(newsResponse)
            }
        }
    }
}
