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
        setupShadow()
        setUpSearchView()
        setUpSearchButton()
        registerCell()
        configureCollectionViewLayout()
        bindViewModel()
        modelSelected()
    }
    
    private func bindViewModel() {
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
                        let storyboard = UIStoryboard.storyboard(storyboard: .main)
                        let bankOptionVC: BankOptionViewController = storyboard.instantiateViewController()
                        let optionWebsite = BankOption(id: "1", title: "Trang chủ", type: .website)
                        let optionPhone = BankOption(id: "2", title: "Điện thoại", type: .phone)
                        let optionDirection = BankOption(id: "3", title: "Chỉ đường", type: .direction)
                        let options = [optionWebsite, optionPhone, optionDirection]
                        bankOptionVC.viewModel = BankOptionViewModel(options: options)
                        bankOptionVC.selectedBank = element
                        strongSelf.present(bankOptionVC, animated: true, completion: nil)
                    }
                    .disposed(by: cell.disposeBag)
            }
            .disposed(by: disposeBag)
    }
    
    private func modelSelected() {
        collectionViewListOfBanks
            .rx
            .modelSelected(Bank.self)
            .subscribe(onNext: { [weak self] (bank) in
                guard let strongSelf = self else { return }
                let storyboard = UIStoryboard.storyboard(storyboard: .main)
                let bankOptionVC: BankOptionViewController = storyboard.instantiateViewController()
                let optionBranch = BankOption(id: "1", title: "Chi nhánh", type: .branch)
                let optionATM = BankOption(id: "2", title: "ATM", type: .atm)
                let options = [optionBranch, optionATM]
                bankOptionVC.viewModel = BankOptionViewModel(options: options)
                bankOptionVC.selectedBank = bank
                strongSelf.present(bankOptionVC, animated: true, completion: nil)
            })
            .disposed(by: disposeBag)
    }
    
    private func configureCollectionViewLayout() {
        collectionViewListOfBanks
            .rx
            .setDelegate(self)
            .disposed(by: disposeBag)
    }
    
    private func registerCell() {
        let listOfBanksCell = UINib(nibName: ListOfBanksCell.nibName, bundle: nil)
        collectionViewListOfBanks.register(listOfBanksCell, forCellWithReuseIdentifier: ListOfBanksCell.nibName)
    }

    private func setUpSearchView() {
        textFieldSearch.paddingLeft(value: 20.0)
        textFieldSearch.delegate = self
    }
    
    private func setUpSearchButton() {
        buttonSearchAndClose
            .rx
            .tap
            .subscribe {[weak self] _ in
                guard let strongSelf = self else { return }
                if !strongSelf.isShowSearchIcon {
                    strongSelf.textFieldSearch.text?.removeAll()
                    strongSelf.updateSearchIcon(value: false)
                    strongSelf.viewModel.resetToOriginalBankList()
                    strongSelf.textFieldSearch.resignFirstResponder()
                }
            }
            .disposed(by: disposeBag)
    }
    
    private func updateSearchIcon(value: Bool) {
        if value {
            isShowSearchIcon = false
            buttonSearchAndClose.setImage(UIImage(named: "search_close"), for: .normal)
        } else {
            isShowSearchIcon = true
            buttonSearchAndClose.setImage(UIImage(named: "search"), for: .normal)
        }
    }
    
    private func setupShadow() {
        viewSearch.layer.shadowOffset =  CGSize(width: 1, height: 1)
        viewSearch.layer.shadowColor = UIColor.gray.cgColor
        viewSearch.layer.shadowRadius = 2.0
        viewSearch.layer.shadowOpacity = 0.2
        viewSearch.layer.cornerRadius = 20.0
        viewSearch.clipsToBounds = true
        viewSearch.layer.masksToBounds = false
    }
    
    @objc private func getHintsFromTextField(textField: UITextField) {
        if let text = textField.text {
            if !Helper.isEmptyData(data: text) {
                viewModel.searchBank(value: text)
            } else {
                viewModel.resetToOriginalBankList()
            }
        }
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
        updateSearchIcon(value: true)
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        updateSearchIcon(value: false)
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        // Delay user typing text
        NSObject.cancelPreviousPerformRequests(
            withTarget: self,
            selector: #selector(getHintsFromTextField),
            object: textField)
        self.perform(
            #selector(getHintsFromTextField),
            with: textField,
            afterDelay: 0.5)
        return true
    }
}
