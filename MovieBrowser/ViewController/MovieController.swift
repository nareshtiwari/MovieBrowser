//
//  MovieController.swift
//  MovieBrowser
//
//  Created by Mohib Malgi on 2020-05-22.
//

import UIKit

class MovieController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    @IBOutlet var movieCollectionView: UICollectionView!
    let reuseIdentifier = "MovieCollectionCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        movieCollectionView.register(UINib.init(nibName: reuseIdentifier, bundle: nil), forCellWithReuseIdentifier: reuseIdentifier)
        movieCollectionView.delegate = self
        movieCollectionView.dataSource = self
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 5
        layout.minimumInteritemSpacing = 5
        layout.scrollDirection = .vertical
        movieCollectionView.collectionViewLayout = layout
        movieCollectionView.isPagingEnabled = false
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 50
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath as IndexPath) as! MovieCollectionCell
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
           
        let collectionViewSizeWidth = collectionView.frame.size.width - 8
        let collectionViewSizeHeight = collectionView.frame.size.height
           
        return CGSize(width:collectionViewSizeWidth * 0.5, height:collectionViewSizeHeight * 0.45)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 1.0, left: 1.0, bottom: 1.0, right: 1.0)
    }
}
