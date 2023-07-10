//
//  ImageEnlargeViewController.swift
//  NewsApp
//
//  Created by Durga Ballabha Panigrahi on 10/07/23.
//

import UIKit
import Combine

class ImageEnlargeViewController: UIViewController {

    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var newImageView: UIImageView!
    
    private var cancellable: AnyCancellable?
    var imageURL: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
        loadImage()
    }
    
    private func setupView() {
        closeButton.addTarget(self, action: #selector(closeAction), for: .touchUpInside)
        newImageView.isUserInteractionEnabled = true
        
        let pinchGesture: UIPinchGestureRecognizer = UIPinchGestureRecognizer(
            target: self, action: #selector(pinchGestureAction)
        )
        newImageView.addGestureRecognizer(pinchGesture)
    }
    
    private func loadImage() {
        if let imageURL,
           let finalImageURL = URL(string: imageURL) {
            
            cancellable = ImageLoader().loadImage(from: finalImageURL)
                .sink { [weak self] image in
                    self?.newImageView.image = image
                }
        }
    }

    @objc private func pinchGestureAction(sender: UIPinchGestureRecognizer) {
        if let customTransform: CGAffineTransform = sender.view?.transform.scaledBy(
            x: sender.scale,
            y: sender.scale
        ) {
            sender.view?.transform = customTransform
            sender.scale = 1
        }
    }
    
    @objc private func closeAction() {
        dismiss(animated: true)
    }
}
