//
//  PopularArticlesDetailViewController.swift
//  NyTimesApp
//
//  Created by Alok Tyagi on 27/01/2024.
//  Copyright © 2024 Alok. All rights reserved.
//

import UIKit

class PopularArticlesDetailViewController: UIViewController {
    
    @IBOutlet private weak var titleLabel:UILabel!
    @IBOutlet private weak var abstractLabel:UILabel!
    @IBOutlet private weak var mainImageView:UIImageView!
    
    private var imageUrl: String?
    private var abstractStr:String?
    private var titleStr:String?
    
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
