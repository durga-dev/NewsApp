//
//  HTTPUtility.swift
//  NewsApp
//
//  Created by User on 08/07/23.
//

import Foundation

public struct HTTPUtility {
    func getData<T:Decodable>(
        requestUrl: URL,
        resultType: T.Type,
        completionHandler:@escaping(_ result: T?)-> Void
    ) {
        URLSession.shared.dataTask(with: requestUrl) { (responseData, httpUrlResponse, error) in
            
            guard let responseData = responseData else {
                debugPrint("Error: No Data Found")
                return completionHandler(nil)
            }
            
            do {
                let jsonDecoder = JSONDecoder()
                let jsonData = try jsonDecoder.decode(T.self, from: responseData)
                return completionHandler(jsonData)
            } catch {
                debugPrint("Error: \(error.localizedDescription)")
                return completionHandler(nil)
            }
            
        }.resume()
    }
}
