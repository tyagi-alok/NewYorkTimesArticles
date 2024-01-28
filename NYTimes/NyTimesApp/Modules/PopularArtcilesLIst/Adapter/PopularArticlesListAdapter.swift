//
//  PopularArticlesListAdapter.swift
//  NyTimesApp
//
//  Created by Alok Tyagi on 27/01/2024.
//  Copyright © 2020 Alok. All rights reserved.
//

import UIKit

class PopularArticlesListAdapter: NSObject {

    weak var delegate: ArticleListProtocol?

    // MARK: - Constructor

    init(delegate:ArticleListProtocol) {
        self.delegate = delegate
    }
}

// MARK: - UICollectionViewDataSource Delegate implementation

extension PopularArticlesListAdapter: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      
        guard let cell = tableView.dequeueReusableCell(withIdentifier: tableCellIdentifier, for: indexPath) as? PopularArticleTableViewCell else {
            fatalError("Cell not exists in storyboard")
        }

        cell.selectionStyle = .none
        cell.articlesCellViewModel = delegate?.getData(atIndexPath: indexPath )

        
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return delegate?.retrieveNumberOfSections() ?? 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return delegate?.retrieveNumberOfItems() ?? 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
        
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        delegate?.itemSelected(atIndexPath: indexPath)
        return indexPath
    }

}


