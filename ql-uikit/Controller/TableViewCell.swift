//
//  TableViewCell.swift
//  ql-uikit
//
//  Created by Muhammad Faisal Imran Khan on 2022-01-18.
//  Copyright © 2022 Muhammad Faisal Imran Khan. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var repositoryName: UILabel!
    @IBOutlet weak var repositoryStarCount: UILabel!
    
    private var viewModel: TableViewCellViewModel?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(with viewModel: TableViewCellViewModel){
        self.viewModel = viewModel
        repositoryName.text = viewModel.name
        repositoryStarCount.text = viewModel.starCount
        
    }
    
}
