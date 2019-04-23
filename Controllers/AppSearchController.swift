//
//  AppSearchControllerCollectionViewController.swift
//  appStore
//
//  Created by Alex Beattie on 4/22/19.
//  Copyright © 2019 Alex Beattie. All rights reserved.
//

import UIKit


class AppSearchController: UICollectionViewController, UICollectionViewDelegateFlowLayout {

    fileprivate let cellId = "id1234"
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.backgroundColor = .white
        collectionView.register(SearchResultsCell.self, forCellWithReuseIdentifier: cellId)
        fetchItunesApps()
        
    }
    fileprivate var appResults = [Result]()
    
   // 1 - populate our cells with our itunes api data
   // 2 - extract this function outside of controller
    
    fileprivate func fetchItunesApps() {
        let urlString = "http://itunes.apple.com/search?term=instagram&entity=software"
        guard let url = URL(string: urlString) else { return }
        //fetch data
        URLSession.shared.dataTask(with: url) { (data, resp, err) in
            if let err = err {
                print("Failed to fetch apps", err)
                return
            }
            guard let data = data else { return }
            do {
                let searchResult = try JSONDecoder().decode(SearchResult.self, from:data)
                
                self.appResults = searchResult.results
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
                
            } catch let jsonErr {
                print("failed to decode", jsonErr)
            }
                
       
        }.resume()
        
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: view.frame.width, height: 300)
    }
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return appResults.count
    }
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! SearchResultsCell

        let appResult = appResults[indexPath.item]

        cell.nameLabel.text = appResult.trackName
        cell.categoryLabel.text = appResult.primaryGenreName
        cell.ratingsLabel.text = "Rating: \(appResult.averageUserRating ?? 0)"

        return cell
    }
    init() {
        super.init(collectionViewLayout: UICollectionViewFlowLayout())
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
