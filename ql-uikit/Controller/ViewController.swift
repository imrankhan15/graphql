//
//  ViewController.swift
//  ql-uikit
//
//  Created by Muhammad Faisal Imran Khan on 2021-12-29.
//  Copyright © 2021 Muhammad Faisal Imran Khan. All rights reserved.
//

import UIKit


final class ViewController: UIViewController {
    
    
    var networkService: NetworkService?
    
    @IBOutlet weak var tableView: UITableView!
    
    fileprivate struct Keys {
        static let cellIdentifier = "cell"
        static let nibName =  "TableViewCell"
    }

    private var repositories = [RepositoryModel]()
    
    override func viewWillAppear(_ animated: Bool) {
   
        let nib = UINib(nibName: Keys.nibName, bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: Keys.cellIdentifier)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.networkService = RepositoryQueryService()
        networkService?.fetchingGithubRepo(){ (respositoryFromNetworkLayer) in
          
            self.repositories = respositoryFromNetworkLayer
            self.tableView.reloadData()
           
        }
    }
    
}

extension ViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
          repositories.count
      }
      
      func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      
        
        let cell: TableViewCell = tableView.dequeueReusableCell(withIdentifier: Keys.cellIdentifier) as! TableViewCell
        
        cell.configure(with: TableViewCellViewModel(with: repositories[indexPath.row]))
        
          return cell
      }
      
}
