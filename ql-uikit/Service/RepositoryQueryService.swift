//
//  RepositoryQueryService.swift
//  ql-uikit
//
//  Created by Muhammad Faisal Imran Khan on 2022-01-17.
//  Copyright © 2022 Muhammad Faisal Imran Khan. All rights reserved.
//

import Foundation

protocol NetworkService {
    func fetchingGithubRepo(handler: @escaping (([Repository])->Void))
}

typealias Repository = (name: String, starCount: String)
class RepositoryQueryService: NetworkService {
    
    fileprivate struct Keys {
        static let name = "name"
        static let count = "stargazerCount"
    }
    
    
    private var repositories = [Repository]()
    
     /// with this network call we fetch the repository name and star count of the first 50 repositories from public GitHub GraphQL API which are satisfying search query, "topic:ios".
     
     func fetchingGithubRepo(handler: @escaping (([Repository]) -> Void)) {
        Network.shared.apollo.fetch(query: SpecificPostsQuery()){result in
            
            /// this specificPostsQuery is created in the Apollo.swift file that wraps the graphql query in Queries.grpahql file into a form accessible via swift
            
            switch result{
            case .success(let graphQLResult):
                DispatchQueue.main.async {
                    guard let nodes = graphQLResult.data?.search.nodes else {
                        return
                    }
                    for node in nodes {
                        let repoName = node?.jsonObject[Keys.name]
                        let repoStarCount = node?.jsonObject[Keys.count] as! Int
                        self.repositories.append((repoName as! String, repoStarCount.description))
                        
                    }
                    handler(self.repositories)
                }
                
            case .failure(let error):
                print("Error: \(error)")
            }
        }
    }
    
}
