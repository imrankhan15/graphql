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
    }

    private var repositories = [Repository]()
    
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
        let cell = tableView.dequeueReusableCell(withIdentifier: Keys.cellIdentifier)!
          cell.textLabel?.text = "name: " + repositories[indexPath.row].name
          cell.detailTextLabel?.text = "star Count: " + repositories[indexPath.row].starCount
          return cell
      }
      
}
