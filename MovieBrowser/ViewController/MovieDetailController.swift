//
//  MovieDetailController.swift
//  MovieBrowser
//
//  Created by Mohib Malgi on 2020-05-23.
//

import UIKit
import Alamofire

class MovieDetailController: UIViewController {

    @IBOutlet var plotSynopsisLbl: UILabel!
    @IBOutlet var releaseLbl: UILabel!
    @IBOutlet var releaseDateLbl: UILabel!
    @IBOutlet var ratingCountLbl: UILabel!
    @IBOutlet var ratingImg: UIImageView!
    @IBOutlet var movieTitleLbl: UILabel!
    @IBOutlet var movieThumbnailImg: RoundedImageView!
    var movieId:Int?
    private var movieDetailModel:MovieDetailModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getMovieDetails()
    }
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = true
    }
    override func viewWillDisappear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false
    }
    
    @IBAction func backBtnAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    //MARK:- Method for call movie detail API
    func getMovieDetails(){
       
        let token = UserDefaults.standard.object(forKey: UserDefaultKey.apiToken.rawValue) as! String?
        let urlString = URLConstants.BaseURL + URLConstants.movieDetailApi + "\(String(describing: (movieId)!))"
        let request = NSMutableURLRequest(url: NSURL(string: urlString)! as URL)
        request.httpMethod = "GET"
        request.addValue(token!, forHTTPHeaderField: HTTPHeaderConstants.AuthorizationHeaderName)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
               
           URLSession.shared.dataTask(with:request as URLRequest, completionHandler: {(data, response, error) in
                guard let data = data, error == nil else { return }
                   
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as! [String:Any]
                    self.movieDetailModel = MovieDetailModel(json)
                    
                    DispatchQueue.main.async {
                      self.showMovieData()
                    }
                       
                } catch _ as NSError {
                }
            }).resume()
    }
    
    
    //MARK:- Method for show movie data
    func showMovieData() {
        
        movieTitleLbl.text = movieDetailModel!.original_title
        let thumbnailUrl =  URLConstants.imageBaseUrl + movieDetailModel!.backdrop_path
        movieThumbnailImg.loadMovieThumbnai(imageUrl:thumbnailUrl)
        if movieDetailModel!.status == ResponseKey.released.rawValue{
            releaseLbl.text = "Released On:"
            releaseDateLbl.text = movieDetailModel!.release_date
        }
        else{
            releaseLbl.text = "Releasing On:"
            releaseDateLbl.text = movieDetailModel!.release_date
        }
        self.plotSynopsisLbl.text = movieDetailModel?.overview
        if movieDetailModel!.vote_average != 0{
            ratingImg.isHidden = false
            ratingCountLbl.text = "\(Float(movieDetailModel!.vote_average))"
        }
        else{
            ratingImg.isHidden = true
        }
    }
    
}
