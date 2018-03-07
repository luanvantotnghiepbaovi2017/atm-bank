//
//  BankOptionCell.swift
//  ATMBank
//
//  Created by Bao on 3/5/18.
//  Copyright © 2018 TranQuocBao. All rights reserved.
//

import UIKit

class BankOptionCell: UITableViewCell {

    // MARK: IBOutlets
    @IBOutlet weak var labelTitle: UILabel!
    
    // MARK: Properties
    var bankOption: BankOption! {
        didSet {
            configureCell()
        }
    }
    
    // MARK: Methods
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    private func configureCell() {
        labelTitle.text = bankOption.title
    }
}
