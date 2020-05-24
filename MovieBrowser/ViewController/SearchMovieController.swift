//
//  SearchMovieController.swift
//  MovieBrowser
//
//  Created by Mohib Malgi on 2020-05-23.
//

import UIKit

class SearchMovieController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UITextFieldDelegate {
    
    @IBOutlet var movieCollectionView: UICollectionView!
    @IBOutlet var searchTextField: UITextField!
    private let reuseIdentifier = ReuseIdentifier.collectionReuseIdentifier.rawValue
    private var pageNumber = 1
    private var movieModel = [MovieModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        searchTextField.delegate = self
        
        // Define collectionview layout
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

    //MARK:- TextField Delegate method
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if let text = textField.text as NSString? {
            let txtAfterUpdate = text.replacingCharacters(in: range, with: string)
            if txtAfterUpdate != ""{
                getSearchedMovie(page: 1, searchedText: txtAfterUpdate)
            }
            else{
                movieModel = []
                movieCollectionView.reloadData()
            }
        }
        return true
    }
    
    //MARK: CollectionView Delegate and Datasource method
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
               if self.movieModel.count > 3{
                   lastElement = self.movieModel.count - 1
               }
               else{
                   lastElement = self.movieModel.count
               }
               if indexPath.row == lastElement{
                   self.pageNumber += 1
                   self.getSearchedMovie(page: self.pageNumber, searchedText: self.searchTextField.text!)
               }
           }
       }
    
    @IBAction func searchBtnAction(_ sender: Any) {
        movieModel = []
        if searchTextField.text != ""{
            getSearchedMovie(page: 1, searchedText: searchTextField.text!)
        }
        else{
            movieCollectionView.reloadData()
        }
        
    }
    
    //MARK:- Method for call search movie API
    func getSearchedMovie(page:Int,searchedText:String) {
        
        var dict = [String:Any]()
        dict["page"] = page
        dict["query"] = searchedText
        
        let movieService = MovieService()
        movieService.getSearchMovie(parameter: dict) { (response:Any?) in
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
}
