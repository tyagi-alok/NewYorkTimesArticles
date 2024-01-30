//
//  PopularArticlesDetailViewController.swift
//  NyTimesApp
//
//  Created by Alok Tyagi on 27/01/2024.
//  Copyright © 2024 Alok. All rights reserved.
//

import UIKit

class PopularArticlesDetailViewController: UIViewController {

    @IBOutlet weak var titleLabel:UILabel!
    @IBOutlet weak var abstractLabel:UILabel!
    @IBOutlet weak var mainImageView:UIImageView!
    
    var imageUrl: String?
    var abstractStr:String?
    var titleStr:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //init the UI
        setUpUI()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = false
    }
    
    func saveData(for article : Articles){
        titleStr = article.title
        abstractStr = article.abstract
        if article.media.count > 0{
            if article.media[0].mediaMetadata.count > 2{
                imageUrl = article.media[0].mediaMetadata[2].imageUrl
            }else{
                imageUrl = ""
            }
        }else{
            imageUrl = ""
        }
    }
    
    private func setUpUI(){
        if let title = titleStr{
            titleLabel.text = title
        }
        
        if let abstract = abstractStr{
            abstractLabel.text = abstract
        }
        if let image = imageUrl{
            mainImageView?.sd_setImage(with: URL( string: image), completed: nil)
        }
        
    }
}
