//
//  TableViewCell.swift
//  buttonProgrammatically
//
//  Created by Eugene Izotov on 23.10.2019.
//  Copyright © 2019 Eugene Izotov. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var listLbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
