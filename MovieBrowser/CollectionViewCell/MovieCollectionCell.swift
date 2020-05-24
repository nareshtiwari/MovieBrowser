//
//  MovieCollectionCell.swift
//  MovieBrowser
//
//  Created by Mohib Malgi on 2020-05-22.
//

import UIKit

class MovieCollectionCell: UICollectionViewCell {

    @IBOutlet var movieTitleLbl: UILabel!
    @IBOutlet var moviePosterImg: RoundedImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func loadMovieData(movieInfo:MovieModel) {
        moviePosterImg.image = nil
        movieTitleLbl.text = movieInfo.original_title
        let urlString:String?
        if movieInfo.poster_path != ""{
          urlString =  URLConstants.imageBaseUrl + movieInfo.poster_path
        }
        else{
          urlString =  URLConstants.imageBaseUrl + movieInfo.backdrop_path
        }
        moviePosterImg.loadMovieThumbnai(imageUrl: urlString)
    }
    
}
