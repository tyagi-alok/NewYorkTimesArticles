//
//  PopularArticleTableViewCell.swift
//  NyTimesApp
//
//  Created by Alok Tyagi on 27/01/2024.
//  Copyright © 2024 Alok. All rights reserved.
//

import UIKit
import SDWebImage

class PopularArticleTableViewCell: UITableViewCell {
    
    @IBOutlet private weak var mainImageView: UIImageView?
    @IBOutlet private weak var titleLabel: UILabel?
    
    var articlesCellViewModel : Articles? {
        
        didSet {
            
            titleLabel?.text = articlesCellViewModel?.title ?? ""
            
            if articlesCellViewModel?.media.count ?? 0 > 0{
                if articlesCellViewModel?.media[0].mediaMetadata.count ?? 0 > 2{
                    mainImageView?.sd_setImage(with: URL( string: articlesCellViewModel?.media[0].mediaMetadata[0].imageUrl ?? "" )) { (image, error, cache, urls) in
                        if (error != nil) {
                            self.mainImageView?.image = UIImage(named: "placeholder-image")
                        } else {
                            self.mainImageView?.image = image
                        }
                    }
                } else{
                    mainImageView?.image = UIImage(named: "placeholder-image")
                }
            }
            else{
                mainImageView?.image = UIImage(named: "placeholder-image")
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    
}
