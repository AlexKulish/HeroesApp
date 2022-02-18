//
//  HeroesCollectionViewController.swift
//  HeroesApp
//
//  Created by Alex Kulish on 17.02.2022.
//

import UIKit

class HeroesCollectionViewController: UICollectionViewController {
    
    private var heroes: [Hero] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        fetchHeroes()
    }


    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        guard let heroDetailsVC = segue.destination as? HeroDetailsViewController else { return }
        guard let indexPath = collectionView.indexPathsForSelectedItems else { return }
        
        for index in indexPath {
            let hero = heroes[index.item]
            heroDetailsVC.hero = hero
        }        
    }


    // MARK: UICollectionViewDataSource

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        heroes.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "hero", for: indexPath) as! CollectionViewCell
        let hero = heroes[indexPath.item]
        cell.configure(with: hero)
        return cell
    }

    private func fetchHeroes() {
        NetworkManager.shared.fetchData { result in
            switch result {
            case .success(let heroes):
                self.heroes = heroes
                self.collectionView.reloadData()
            case .failure(let error):
                print(error)
            }
        }
    }
    
    
    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

}
