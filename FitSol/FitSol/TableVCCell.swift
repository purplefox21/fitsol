//
//  TableVCCell.swift
//  FitSol
//
//  Created by Berat Ölekli on 8.10.2024.
//

import UIKit

class TableVCCell: UITableViewCell {

    
    
    @IBOutlet weak var btnCell: UIButton!
    
    @IBOutlet weak var lblCell: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
