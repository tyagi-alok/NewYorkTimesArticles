//
//  PopularArticlesListViewController.swift
//  NyTimesApp
//
//  Created by Alok Tyagi on 27/01/2024.
//  Copyright © 2024 Alok. All rights reserved.
//

import UIKit

class PopularArticlesListViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView?
    @IBOutlet weak var errorLabel: UILabel?

    @IBOutlet weak var activityIndicator: UIActivityIndicatorView?

    var adapter : PopularArticlesListAdapter?
    var router : PopularArticlesListRouter?
    
    var viewModel : PopularArticlesListViewModel?

    // MARK: - Module Creation
   static func createPopularArticleList() -> UIViewController {
        let articlesController = mainStoryboard.instantiateViewController(withIdentifier: popularArtcilesListVCIdentifier) as! PopularArticlesListViewController
        articlesController.viewModel = DependencyContainer.getViewModelDependency() as? PopularArticlesListViewModel
        
       articlesController.router = PopularArticlesListRouter()
       articlesController.router?.viewController = articlesController
        
        return articlesController
    }
    
    // MARK: - View Controller Methods

    override func viewDidLoad() {
        super.viewDidLoad()

        // Init the static view
        initView()
        
        // init view model
        initVM()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        //set up Nav Bar
        setUpTitle()
    }
    
    func setUpTitle(){
        
        self.navigationItem.title = APP_TITLE

    }
    
    func initView() {
        
        adapter = PopularArticlesListAdapter(delegate: self)
        tableView?.delegate = adapter
        tableView?.dataSource = adapter

        tableView?.estimatedRowHeight = 150
        tableView?.rowHeight = UITableView.automaticDimension
    }

    func initVM() {
        
        // Naive binding
        viewModel?.showAlertClosure = { [weak self] () in
            DispatchQueue.main.async {
                if let message = self?.viewModel?.alertMessage {
                    self?.showAlert( message )
                }
            }
        }
        
        //For show/hide loader
        viewModel?.updateLoadingStatus = { [weak self] () in
            DispatchQueue.main.async {
                let isLoading = self?.viewModel?.isLoading ?? false
                if isLoading {
                    self?.activityIndicator?.startAnimating()
                    UIView.animate(withDuration: 0.2, animations: {
                        self?.tableView?.alpha = 0.0
                    })
                }else {
                    self?.activityIndicator?.stopAnimating()
                    if self?.viewModel?.cellViewModels == nil {
                        self?.errorLabel?.isHidden = false
                    }
                    UIView.animate(withDuration: 0.2, animations: {
                        self?.tableView?.alpha = 1.0
                    })
                }
            }
        }
        
        // for reloading tableview after response
        viewModel?.reloadTableViewClosure = { [weak self] () in
            DispatchQueue.main.async {
                self?.tableView?.reloadData()
            }
        }
        
        Task{
           await viewModel?.getPopularArticles()
            
        }

    }
    
/*--showing the error message if no data receive from the API--*/
  private func showAlert( _ message: String ) {
        let alert = UIAlertController(title: ALERT_TITLE, message: message, preferredStyle: .alert)
        alert.addAction( UIAlertAction(title: ALERT_OK_BUTTON_TITLE, style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}


// MARK: - Delegate Methods

//Conforming to the protocols for the adapter class
extension PopularArticlesListViewController : ArticleListProtocol {
    func getData(atIndexPath: IndexPath) -> Articles? {
        return viewModel?.getCellViewModel(at: atIndexPath)
    }
    
    func retrieveNumberOfSections()->Int {
        return 1
    }

    func retrieveNumberOfItems()->Int {
        return self.viewModel?.numberOfCells ?? 0
    }
    
    func itemSelected(atIndexPath: IndexPath) {
        if let article = viewModel?.getCellViewModel(at: atIndexPath),article.abstract != nil{
            router?.navigateToScreen(screenType: .PopularArticlesDetail, data: article)
        }
    }
}
