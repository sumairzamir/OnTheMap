//
//  TableTabbedViewCell.swift
//  OnTheMap
//
//  Created by Sumair Zamir on 31/03/2020.
//  Copyright © 2020 Sumair Zamir. All rights reserved.
//

import UIKit

class TableTabbedViewCell: UITableViewCell {

    
    @IBOutlet weak var studentNameLabel: UILabel!
    @IBOutlet weak var mediaURLLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
 //   }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
