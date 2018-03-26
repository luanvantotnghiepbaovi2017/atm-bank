//
//  ListOfBanksViewController.swift
//  ATMBank
//
//  Created by Bao on 2/25/18.
//  Copyright © 2018 TranQuocBao. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import PopupDialog

class ListOfBanksViewController: UIViewController {
    // MARK: IBOutlets
    @IBOutlet weak var collectionViewListOfBanks: UICollectionView!
    @IBOutlet weak var viewSearch: UIView!
    @IBOutlet weak var textFieldSearch: UITextField!
    @IBOutlet weak var buttonSearchAndClose: UIButton!
    
    // MARK: Properties
    private var viewModel: ListOfBanksViewModelType!
    private let disposeBag: DisposeBag = DisposeBag()
    private var isShowSearchIcon: Bool = true
    
    // MARK: Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = ListOfBanksViewModel()
        _setupShadow()
        _setUpSearchView()
        _setUpSearchButton()
        _registerCell()
        _configureCollectionViewLayout()
        _bindViewModel()
    }
    
    private func _bindViewModel() {
        viewModel
            .getListOfBanks()
            .asObservable()
            .debug()
            .bind(to: collectionViewListOfBanks.rx.items(cellIdentifier: ListOfBanksCell.nibName, cellType: ListOfBanksCell.self)) { (item, element, cell) in
                cell.bank = element
                cell.buttonMainOption
                    .rx
                    .tap
                    .subscribe { [weak self] _ in
                        guard let strongSelf = self else { return }
                        strongSelf._showPopupDialog(bank: element)
                    }
                    .disposed(by: cell.disposeBag)
            }
            .disposed(by: disposeBag)
    }
    
    private func _configureCollectionViewLayout() {
        collectionViewListOfBanks
            .rx
            .setDelegate(self)
            .disposed(by: disposeBag)
    }
    
    private func _registerCell() {
        let listOfBanksCell = UINib(nibName: ListOfBanksCell.nibName, bundle: nil)
        collectionViewListOfBanks.register(listOfBanksCell, forCellWithReuseIdentifier: ListOfBanksCell.nibName)
    }

    private func _setUpSearchView() {
        textFieldSearch.paddingLeft(value: 20.0)
        textFieldSearch.delegate = self
    }
    
    private func _setUpSearchButton() {
        buttonSearchAndClose
            .rx
            .tap
            .subscribe {[weak self] _ in
                guard let strongSelf = self else { return }
                if !strongSelf.isShowSearchIcon {
                    strongSelf.textFieldSearch.text?.removeAll()
                    strongSelf._updateSearchIcon(value: false)
                    strongSelf.viewModel.resetToOriginalBankList()
                    strongSelf.textFieldSearch.resignFirstResponder()
                }
            }
            .disposed(by: disposeBag)
    }
    
    private func _updateSearchIcon(value: Bool) {
        if value {
            isShowSearchIcon = false
            buttonSearchAndClose.setImage(UIImage(named: "search_close"), for: .normal)
        } else {
            isShowSearchIcon = true
            buttonSearchAndClose.setImage(UIImage(named: "search"), for: .normal)
        }
    }
    
    private func _setupShadow() {
        viewSearch.layer.shadowOffset =  CGSize(width: 1, height: 1)
        viewSearch.layer.shadowColor = UIColor.gray.cgColor
        viewSearch.layer.shadowRadius = 2.0
        viewSearch.layer.shadowOpacity = 0.2
        viewSearch.layer.cornerRadius = 20.0
        viewSearch.clipsToBounds = true
        viewSearch.layer.masksToBounds = false
    }
    
    @objc private func _getHintsFromTextField(textField: UITextField) {
        if let text = textField.text {
            if !Helper.isEmptyData(data: text) {
                viewModel.searchBank(value: text)
            } else {
                viewModel.resetToOriginalBankList()
            }
        }
    }
    
    private func _showPopupDialog(bank: Bank) {
        let dialogAppearance = PopupDialogDefaultView.appearance()
        dialogAppearance.titleFont = Font.Dialog.mainTitle
        
        let defaultButtonAppearance = DefaultButton.appearance()
        defaultButtonAppearance.titleFont = Font.Dialog.optionTitle
        
        let cancelButtonAppearance = CancelButton.appearance()
        cancelButtonAppearance.titleFont = Font.Dialog.optionTitle
        
        let message: String = ""
        var title: String = bank.fullnameVN.uppercased()
        if Language.currentAppleLanguage() == LanguageCode.en {
            title = bank.fullnameEN.uppercased()
        }
        
        let image: UIImage = UIImage(named: bank.thumbnail)!
        let popupDialog = PopupDialog(title: title, message: message, image: image, buttonAlignment: .vertical, transitionStyle: .bounceUp, gestureDismissal: true, hideStatusBar: true)
        
        let buttonWebsite = DefaultButton(title: "WEBSITE") {
            let storyboard = UIStoryboard.storyboard(storyboard: .main)
            let websiteVC: WebsiteViewController = storyboard.instantiateViewController()
            websiteVC.bank = bank
            self.present(websiteVC, animated: true, completion: nil)
        }
        let buttonBranch = DefaultButton(title: "BRANCH") {
            
        }
        let buttonATM = DefaultButton(title: "ATM") {
            
        }
        let buttonPhone = DefaultButton(title: "PHONE") {
            
        }
        let buttonDirection = DefaultButton(title: "DIRECTION") {
            
        }
        let buttonCancel = CancelButton(title: "CANCEL") {
            popupDialog.dismiss()
        }
        popupDialog.addButtons([buttonWebsite, buttonBranch, buttonATM, buttonPhone,buttonDirection, buttonCancel])
        self.present(popupDialog, animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        print("didReceiveMemoryWarning")
    }
}

// MARK: Extension - UICollectionViewDelegateFlowLayout
extension ListOfBanksViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let collectionViewWidthSize = collectionViewListOfBanks.bounds.size.width
        let collectionItemHeightSize = UIScreen.main.bounds.size.height / 6.0
        let collectionItemWidthSize = collectionViewWidthSize - 10 * 2
        return CGSize(width: collectionItemWidthSize, height: collectionItemHeightSize)
    }
}

// MARK: Extension - UITextFieldDelegate
extension ListOfBanksViewController: UITextFieldDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        _updateSearchIcon(value: true)
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        _updateSearchIcon(value: false)
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        // Delay user typing text
        NSObject.cancelPreviousPerformRequests(
            withTarget: self,
            selector: #selector(_getHintsFromTextField),
            object: textField)
        self.perform(
            #selector(_getHintsFromTextField),
            with: textField,
            afterDelay: 0.5)
        return true
    }
}
