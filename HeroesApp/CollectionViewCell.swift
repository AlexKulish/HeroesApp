//
//  CollectionViewCell.swift
//  HeroesApp
//
//  Created by Alex Kulish on 17.02.2022.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var descriptionHeroLabel: UILabel!
    @IBOutlet weak var heroImageView: UIImageView! {
        didSet {
            heroImageView.layer.cornerRadius = 15
        }
    }
    
    private var imageUrl: URL? {
        didSet {
            heroImageView.image = nil
            updateImage()
        }
    }
    
    private var activityIndicator: UIActivityIndicatorView?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        activityIndicator = showSpinner(in: heroImageView)
    }
    
    func configure(with hero: Hero) {
        descriptionHeroLabel.text = hero.name
        imageUrl = URL(string: hero.images.lg)
    }
    
    private func updateImage() {
        guard let url = imageUrl else { return }
        getImage(with: url) { result in
            switch result {
            case .success(let image):
                if url == self.imageUrl {
                    self.heroImageView.image = image
                    self.activityIndicator?.stopAnimating()
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private func getImage(with url: URL, completion: @escaping(Result<UIImage, Error>) -> Void) {
        
        // Get image from cache
        
        if let imageCached = ImageCache.shared.object(forKey: url.lastPathComponent as NSString) {
            print("Image from cache: ", url.lastPathComponent)
            completion(.success(imageCached))
            return
        }
        
        // Download image from network

        NetworkManager.shared.fetchImage(from: url) { result in
            switch result {
            case .success(let data):
                guard let image = UIImage(data: data) else { return }
                ImageCache.shared.setObject(image, forKey: url.lastPathComponent as NSString)
                print("Image from network: ", url.lastPathComponent)
                completion(.success(image))
            case .failure(let error):
                completion(.failure(error))
            }
        }

    }
    
    private func showSpinner(in view: UIView) -> UIActivityIndicatorView {
        let activityIndicator = UIActivityIndicatorView(style: .medium)
        activityIndicator.color = .white
        activityIndicator.startAnimating()
        activityIndicator.center = view.center
        activityIndicator.hidesWhenStopped = true
        
        view.addSubview(activityIndicator)
        
        return activityIndicator
    }
}
