//
//  HeroDetailsViewController.swift
//  HeroesApp
//
//  Created by Alex Kulish on 17.02.2022.
//

import UIKit

class HeroDetailsViewController: UIViewController {
    
    @IBOutlet weak var heroImageView: UIImageView!
    @IBOutlet weak var downloadDataLabel: UILabel!
    
    var hero: Hero?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        downloadDataLabel.text = hero?.name
        getImage()
    }
    
    private func getImage() {
        
        guard let url = URL(string: hero?.images.lg ?? "") else { return }
        
        NetworkManager.shared.fetchImage(from: url) { result in
            switch result {
            case .success(let image):
                self.heroImageView.image = UIImage(data: image)
            case .failure(let error):
                print(error)
            }
            
        }
        
    }
    
}
