//
//  MovieController.swift
//  MovieBrowser
//
//  Created by Mohib Malgi on 2020-05-22.
//

import UIKit

class MovieController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    @IBOutlet var transparentView: UIView!
    @IBOutlet var filterView: RoundedView!
    @IBOutlet var movieCollectionView: UICollectionView!
    private let reuseIdentifier = ReuseIdentifier.collectionReuseIdentifier.rawValue
    private var pageNumber = 1
    private var movieModel = [MovieModel]()
    private var movieBysort = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Define collectionView layout
        movieCollectionView.register(UINib.init(nibName: reuseIdentifier, bundle: nil), forCellWithReuseIdentifier: reuseIdentifier)
        movieCollectionView.delegate = self
        movieCollectionView.dataSource = self
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 5
        layout.minimumInteritemSpacing = 5
        layout.scrollDirection = .vertical
        movieCollectionView.collectionViewLayout = layout
        movieCollectionView.isPagingEnabled = false
        
        // Add tapgesture on filter view
        let tapOnFilter = UITapGestureRecognizer(target: self, action: #selector(self.handleTapOnFilter(_:)))
        filterView.addGestureRecognizer(tapOnFilter)
        filterView.isUserInteractionEnabled = true
        
        // Add tap gesture on transparent view
        let tapOnTransparent = UITapGestureRecognizer(target: self, action: #selector(self.handleTapOnTransparent(_:)))
        transparentView.addGestureRecognizer(tapOnTransparent)
        transparentView.isUserInteractionEnabled = true
        
        callMoviesList(page: pageNumber)
    }
    
    @objc func handleTapOnFilter(_ sender: UITapGestureRecognizer) {
        transparentView.isHidden = false
    }
    @objc func handleTapOnTransparent(_ sender: UITapGestureRecognizer) {
        transparentView.isHidden = true
    }
    
    //MARK:- Method for call movie list API
    func callMoviesList(page:Int){
        let movieService = MovieService()
        movieService.getAllMovieList(parameter: ["page":page]) { (response:Any?) in
            if response != nil{
                if let json = response as? [String:Any]{
                    if let data = json[ResponseKey.result.rawValue]{
                        guard let jsonArray = data as? [[String: Any]] else {
                            return
                         }
                        if jsonArray.count > 0{
                            if page == 1{
                                self.movieModel = [MovieModel]()
                            }
                            for dic in jsonArray{
                                self.movieModel.append(MovieModel(dic))
                            }
                            self.movieCollectionView.reloadData()
                        }
                    }
                }
            }
             
        }
        
    }
    
    //MARK:- Method for call most popular movie API
    func sortMovieByPopular(page:Int){
        let movieService = MovieService()
        movieService.movieByMostPopular(parameter: ["page":page]) { (response:Any?) in
            if response != nil{
                if let json = response as? [String:Any]{
                    if let data = json[ResponseKey.result.rawValue]{
                        guard let jsonArray = data as? [[String: Any]] else {
                            return
                         }
                        if jsonArray.count > 0{
                            if page == 1{
                                self.movieModel = [MovieModel]()
                            }
                            for dic in jsonArray{
                                self.movieModel.append(MovieModel(dic))
                            }
                            self.movieCollectionView.reloadData()
                        }
                    }
                }
            }
             
        }
        
    }
    
    //MARK:- Method for call most highest rating movie API
    func sortMovieByRating(page:Int){
        let movieService = MovieService()
        movieService.movieByHighestRating(parameter: ["page":page]) { (response:Any?) in
            if response != nil{
                if let json = response as? [String:Any]{
                    if let data = json[ResponseKey.result.rawValue]{
                        guard let jsonArray = data as? [[String: Any]] else {
                            return
                         }
                        if jsonArray.count > 0{
                            if page == 1{
                                self.movieModel = [MovieModel]()
                            }
                            for dic in jsonArray{
                                self.movieModel.append(MovieModel(dic))
                            }
                            self.movieCollectionView.reloadData()
                        }
                    }
                }
            }
             
        }
        
    }
    
    //MARK:- CollectionView delegate and datasource methods
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movieModel.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath as IndexPath) as! MovieCollectionCell
        cell.loadMovieData(movieInfo: movieModel[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailView = self.storyboard?.instantiateViewController(withIdentifier: "MovieDetailController") as! MovieDetailController
        detailView.movieId = movieModel[indexPath.row].id
        self.navigationController?.pushViewController(detailView, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
           
        let collectionViewSizeWidth = collectionView.frame.size.width - 8
        let collectionViewSizeHeight = collectionView.frame.size.height
           
        return CGSize(width:collectionViewSizeWidth * 0.5, height:collectionViewSizeHeight * 0.4)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 1.0, left: 1.0, bottom: 1.0, right: 1.0)
    }
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        DispatchQueue.global(qos: .userInitiated).async {
            var lastElement:Int?
            if self.movieModel.count > 10{
                lastElement = self.movieModel.count - 7
            }
            else{
                lastElement = self.movieModel.count
            }
            if indexPath.row == lastElement{
                self.pageNumber += 1
                if self.movieBysort == SortType.mostRated.rawValue{
                    self.sortMovieByRating(page: self.pageNumber)
                }
                else if self.movieBysort == SortType.mostPopular.rawValue{
                    self.sortMovieByPopular(page: self.pageNumber)
                }
                else{
                   self.callMoviesList(page: self.pageNumber)
                }
                
            }
        }
    }
    
    @IBAction func mostPopularBtnAction(_ sender: Any) {
        pageNumber = 1
        sortMovieByPopular(page: pageNumber)
        transparentView.isHidden = true
    }
    @IBAction func highestRatingBtnAction(_ sender: Any) {
        pageNumber = 1
        sortMovieByRating(page: pageNumber)
        transparentView.isHidden = true
    }
}
