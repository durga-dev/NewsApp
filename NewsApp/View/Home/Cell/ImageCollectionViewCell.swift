//
//  ImageCollectionViewCell.swift
//  NewsApp
//
//  Created by User on 08/07/23.
//

import UIKit
import Combine

class ImageCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var newsImageView: UIImageView!
    
    private var cancellable: AnyCancellable?
    private var animator: UIViewPropertyAnimator?
    
    var data: NewModel? {
        didSet {
            setImage(url: data?.imageURL)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override public func prepareForReuse() {
        super.prepareForReuse()
        newsImageView.image = nil
        newsImageView.alpha = 0.0
        animator?.stopAnimation(true)
        cancellable?.cancel()
    }

    private func setImage(url: String?) {
        guard let url,
              let imageURL: URL = URL(string: url)
        else { return }
        
        cancellable = ImageLoader().loadImage(from: imageURL)
            .sink { [weak self] responseImage in
                self?.showImage(image: responseImage)
            }
    }
    
    private func showImage(image: UIImage?) {
        newsImageView.alpha = 0.0
        animator?.stopAnimation(false)
        newsImageView.image = image
        newsImageView.contentMode = .scaleAspectFill
        newsImageView.clipsToBounds = true
        animator = UIViewPropertyAnimator.runningPropertyAnimator(withDuration: 0.3, delay: 0, options: .curveLinear, animations: {
            self.newsImageView.alpha = 1.0
        })
    }
}
