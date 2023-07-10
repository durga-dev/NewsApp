//
//  HomeViewController+UICollectionView.swift
//  NewsApp
//
//  Created by User on 08/07/23.
//

import UIKit

extension HomeViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    private var interItemSpacing: CGFloat {
        .zero
    }
    
    private var interLineSpacing: CGFloat {
        .zero
    }
    
    private var itemsPerRow: Int {
        UIDevice.current.userInterfaceIdiom == .pad ? 5 : 3
    }
    
    private func getItemSize() -> CGSize {
        let itemScale: CGFloat = 1.5
        let collectionViewWidth: CGFloat = collectionView.bounds.width
        let itemSpacing: CGFloat = CGFloat((itemsPerRow - 1)) * interItemSpacing
        let finalWidth: CGFloat = collectionViewWidth - itemSpacing
        let itemWidth: CGFloat = finalWidth / CGFloat(itemsPerRow)
        let itemHeight: CGFloat = itemWidth / itemScale
        return CGSize(
            width: itemWidth,
            height: itemHeight
        )
    }
    
    func getCollectionViewLayout() -> UICollectionViewFlowLayout {
        let collectionViewFlowLayout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        collectionViewFlowLayout.minimumInteritemSpacing = interItemSpacing
        collectionViewFlowLayout.minimumLineSpacing = interLineSpacing
        collectionViewFlowLayout.itemSize = getItemSize()
        return collectionViewFlowLayout
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        newsResponse?.data?.count ?? .zero
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let imageCollectionViewCell: ImageCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCollectionViewCell", for: indexPath) as? ImageCollectionViewCell else {
            return UICollectionViewCell()
        }
        imageCollectionViewCell.data = newsResponse?.data?[indexPath.item]
        return imageCollectionViewCell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        openEnlargeImageViewController(imageURL: newsResponse?.data?[indexPath.item].imageURL)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        if indexPath.item == (newsResponse?.data?.count ?? .zero) - 1 {
            newsListViewModel?.fetchNewsList()
        }
    }
}
