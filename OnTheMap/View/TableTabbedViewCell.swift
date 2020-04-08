//
//  TableTabbedViewCell.swift
//  OnTheMap
//
//  Created by Sumair Zamir on 31/03/2020.
//  Copyright © 2020 Sumair Zamir. All rights reserved.
//

import UIKit

// This class calls specific elements defined in the TableViewCell. These are called in the TableView controller.

class TableTabbedViewCell: UITableViewCell {

    // MARK:- IBOutlets
    
    // These are called in the TableView controller.
    
    @IBOutlet weak var studentNameLabel: UILabel!
    @IBOutlet weak var mediaURLLabel: UILabel!
    
    // MARK: - View methods
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }

}
