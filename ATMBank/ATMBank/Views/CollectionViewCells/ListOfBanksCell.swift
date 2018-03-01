//
//  ListOfBanksCell.swift
//  ATMBank
//
//  Created by Bao on 2/26/18.
//  Copyright © 2018 TranQuocBao. All rights reserved.
//

import UIKit

class ListOfBanksCell: UICollectionViewCell {

    // MARK: IBOutlets
    @IBOutlet weak var imageViewBank: UIImageView!
    @IBOutlet weak var labelBankFullName: UILabel!
    @IBOutlet weak var labelBankShortName: UILabel!
    
    // MARK: Properties
    var bank: Bank! {
        didSet {
            configureCell()
        }
    }
    
    // MARK: Methods
    override func awakeFromNib() {
        super.awakeFromNib()
        setupShadow()
    }

    private func configureCell() {
        if currentLanguage == LanguageCode.vn {
            labelBankFullName.text = "\(bank.fullnameVN)"
        } else {
            labelBankFullName.text = "\(bank.fullNameENForSearch)"
        }
        labelBankShortName.text = bank.shortname
        imageViewBank.image = UIImage(named: bank.thumbnail)
    }
    
    private func setupShadow() {
        self.layer.shadowOffset =  CGSize(width: 1, height: 1)
        self.layer.shadowColor = UIColor.gray.cgColor
        self.layer.shadowRadius = 2.0
        self.layer.shadowOpacity = 0.2
        self.layer.cornerRadius = 1
        self.clipsToBounds = true
        self.layer.masksToBounds = false
    }
}
