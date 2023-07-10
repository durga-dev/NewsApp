//
//  HomeViewController.swift
//  NewsApp
//
//  Created by User on 08/07/23.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var newsListViewModel : NewsListViewModelProtocol?
    
    private(set) var newsResponse: NewsResponseModel?
    private var apiState: APIState? {
        didSet {
            if let apiState {
                updateUI(for: apiState)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        initialSetup()
    }

    private func setupUI() {
        collectionView.collectionViewLayout = getCollectionViewLayout()
        collectionView.register(
            UINib(nibName: "ImageCollectionViewCell", bundle: nil),
            forCellWithReuseIdentifier: "ImageCollectionViewCell"
        )
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    private func initialSetup() {
        let httpUtility: HTTPUtility = HTTPUtility()
        let newsListResource: NewsListResource = NewsListResource(httpUtility: httpUtility)
        newsListViewModel = NewsListViewModel(resource: newsListResource)

        newsListViewModel?.updateAPIState = { [weak self] apiState in
            DispatchQueue.main.async {
                self?.apiState = apiState
            }
        }
        
        newsListViewModel?.onContentLoaded = { [weak self] newsListResponse in
            if newsListResponse?.meta?.page == 1{
                self?.newsResponse = newsListResponse
            } else {
                self?.newsResponse?.data?.append(contentsOf: newsListResponse?.data ?? [])
            }
            
            DispatchQueue.main.async {
                self?.collectionView.reloadData()
            }
        }
        newsListViewModel?.viewDidLoad()
    }

    func openEnlargeImageViewController(imageURL: String?) {
        if let imageURL,
           let enlargeImageViewController: ImageEnlargeViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ImageEnlargeViewController") as? ImageEnlargeViewController {
            enlargeImageViewController.imageURL = imageURL
            enlargeImageViewController.modalTransitionStyle = .coverVertical
            enlargeImageViewController.modalPresentationStyle = .overFullScreen
            present(enlargeImageViewController, animated: true)
        }
    }
    
    private func updateUI(for apiState: APIState) {
        switch apiState {
        case .none:
            activityIndicator.stopAnimating()
            activityIndicator.hidesWhenStopped = true
        case .inProgress:
            activityIndicator.isHidden = false
            activityIndicator.startAnimating()
        case .completed:
            activityIndicator.stopAnimating()
            activityIndicator.hidesWhenStopped = true
        }
    }
}

