//
//  RoundedImageView.swift
//  MovieBrowser
//
//  Created by Mohib Malgi on 2020-05-23.
//

import Foundation
import UIKit
import Kingfisher

@IBDesignable class RoundedImageView : UIImageView {
    @IBInspectable var cornerRadius : CGFloat = 0.0{
        didSet{
            self.applyCornerRadius()
        }
    }
    
    @IBInspectable var borderColor : UIColor = UIColor.clear{
        didSet{
            self.applyCornerRadius()
        }
    }
    
    @IBInspectable var borderWidth : Double = 0{
        didSet{
            self.applyCornerRadius()
        }
    }
    
    @IBInspectable var circular : Bool = false{
        didSet{
            self.applyCornerRadius()
        }
    }
    
    func applyCornerRadius()
    {
        if(self.circular) {
            self.layer.cornerRadius = self.bounds.size.height/2
            self.layer.masksToBounds = true
            self.layer.borderColor = self.borderColor.cgColor
            self.layer.borderWidth = CGFloat(self.borderWidth)
        }else {
            self.layer.cornerRadius = cornerRadius
            self.layer.masksToBounds = true
            self.layer.borderColor = self.borderColor.cgColor
            self.layer.borderWidth = CGFloat(self.borderWidth)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.applyCornerRadius()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        applyCornerRadius()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    func loadMovieThumbnai(imageUrl:String?) {
        var movieThumbnailUrl: URL?        
        if imageUrl != nil{
            if imageUrl != ""{
                movieThumbnailUrl = URL(string: imageUrl!)!
                
                if movieThumbnailUrl?.scheme != nil && movieThumbnailUrl?.host != nil {
                    
                } else {
                    
                    movieThumbnailUrl = URL(string:imageUrl!)!
                }
                
                self.kf.setImage(with: movieThumbnailUrl!)
                
            }
            
        } else {
        }
        
    }
}
