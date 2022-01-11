//
//  ViewController.swift
//  ql-uikit
//
//  Created by Muhammad Faisal Imran Khan on 2021-12-29.
//  Copyright © 2021 Muhammad Faisal Imran Khan. All rights reserved.
//

import UIKit

final class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    typealias repository = (name: String, starCount: String)
    
    private var repositories = [repository]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        networkCall()
    }
    
    // with this network call we fetch the repository name and star count of the first 50 repositories from public GitHub GraphQL API which are satisfying search query, "topic:ios".
    
    func networkCall(){
        Network.shared.apollo.fetch(query: SpecificPostsQuery()){result in
            
            // this specificPostsQuery is created in the Apollo.swift file that wraps the graphql query in Queries.grpahql file into a form accessible via swift
            
            switch result{
            case .success(let graphQLResult):
                DispatchQueue.main.async {
                    guard let nodes = graphQLResult.data?.search.nodes else {
                        return
                    }
                    for node in nodes {
                      let repoName = node?.jsonObject["name"]
                        let repoStarCount = node?.jsonObject["stargazerCount"] as! Int
                        self.repositories.append((repoName as! String, repoStarCount.description))
                        
                    }
                    self.tableView.reloadData()
                }
                
            case .failure(let error):
                print("Error: \(error)")
            }
        }
    }

  
    
}

extension ViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
          repositories.count
      }
      
      func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
          let cell = tableView.dequeueReusableCell(withIdentifier: "cell")!
          cell.textLabel?.text = "name: " + repositories[indexPath.row].name
          cell.detailTextLabel?.text = "star Count: " + repositories[indexPath.row].starCount
          return cell
      }
      
}
