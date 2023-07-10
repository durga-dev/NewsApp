//
//  NewsListViewModel.swift
//  NewsApp
//
//  Created by User on 08/07/23.
//

import Foundation

protocol NewsListViewModelProtocol: BaseViewModelProtocol {
    var onContentLoaded : ((NewsResponseModel?) -> ())? { get set }
    var updateAPIState : ((APIState?) -> ())? { get set }
    func fetchNewsList()
}

public class NewsListViewModel: NewsListViewModelProtocol {
    
    var onContentLoaded: ((NewsResponseModel?) -> ())?
    var updateAPIState : ((APIState?) -> ())?
    
    private let resource: NewsListResource
    private var page: Int = 1
    private var limit: Int = 3
    
    init(resource: NewsListResource) {
        self.resource = resource
    }
    
    func viewDidLoad() {
        fetchNewsList()
    }
    
    func fetchNewsList() {
        if page > APIConfiguration.MAXPAGELIMIT {
            return
        }
        updateAPIState?(.inProgress)
        let newsListRequest = NewsRequestModel(limit: limit, page: page)
        resource.getNewsList(request: newsListRequest) { [weak self] response in
            self?.onContentLoaded?(response)
            self?.updateAPIState?(.completed)
            if response?.data?.count == self?.limit {
                self?.page += 1
            }
        }
    }
}
