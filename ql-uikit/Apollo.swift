//
//  Apollo.swift
//  graphQL
//
//  Created by Muhammad Faisal Imran Khan on 2021-12-28.
//  Copyright © 2021 Muhammad Faisal Imran Khan. All rights reserved.
//

import Foundation
import Apollo

// this class is needed for authorization to github api

// this part is taken from stackoverflow https://stackoverflow.com/questions/55395589/how-to-add-header-in-apollo-graphql-ios

final class Network {
   static let shared = Network()
  
    private(set) lazy var apollo: ApolloClient = {
        let client = URLSessionClient()
        let cache = InMemoryNormalizedCache()
        let store = ApolloStore(cache: cache)
        let provider = NetworkInterceptorProvider(client: client, store: store)
        let url = URL(string: "https://api.github.com/graphql")!
        let transport = RequestChainNetworkTransport(interceptorProvider: provider,
                                                     endpointURL: url)
        return ApolloClient(networkTransport: transport)
    }()
}

// these two classes is needed  add authorization in the bearer token

final class NetworkInterceptorProvider: LegacyInterceptorProvider {
    override func interceptors<Operation: GraphQLOperation>(for operation: Operation) -> [ApolloInterceptor] {
      var interceptors = super.interceptors(for: operation)
        interceptors.insert(CustomInterceptor(), at: 0)
        return interceptors
    }
}

final class CustomInterceptor: ApolloInterceptor {

    let token = "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" // this is the access token from my github account
    
    func interceptAsync<Operation: GraphQLOperation>(
        chain: RequestChain,
        request: HTTPRequest<Operation>,
        response: HTTPResponse<Operation>?,
        completion: @escaping (Result<GraphQLResult<Operation.Data>, Error>) -> Void) {
        
        request.addHeader(name: "authorization", value: "Bearer \(token)") // adding the access token for authorization

        chain.proceedAsync(request: request,
                           response: response,
                           completion: completion)
    }
}
