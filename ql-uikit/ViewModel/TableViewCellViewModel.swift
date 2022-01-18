//
//  cellViewModel.swift
//  ql-uikit
//
//  Created by Muhammad Faisal Imran Khan on 2022-01-18.
//  Copyright © 2022 Muhammad Faisal Imran Khan. All rights reserved.
//

import Foundation

struct TableViewCellViewModel {
    let name: String
    let starCount: String
    
    init(with model: RepositoryModel) {
        name = model.name
        starCount = model.starCount
    }
}
