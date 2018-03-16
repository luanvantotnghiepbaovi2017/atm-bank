//
//  BankOptionViewController.swift
//  ATMBank
//
//  Created by Bao on 3/5/18.
//  Copyright © 2018 TranQuocBao. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class BankOptionViewController: UIViewController {
    
    // MARK: IBOutlets
    @IBOutlet weak var tableViewBankOption: UITableView!
    @IBOutlet weak var heightConstraintContainerView: NSLayoutConstraint!
    
    // MARK: IBActions
    
    @IBAction func buttonClose(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    // MARK: Properties
    var viewModel: BankOptionViewModelType!
    var selectedBank: Bank!
    private let disposeBag: DisposeBag = DisposeBag()
    private let optionItemHeight: CGFloat = 90.0
    
    // MARK: Methods
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        heightConstraintContainerView.constant = optionItemHeight * CGFloat(viewModel.getOptionCount()) - 1
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTableView()
        bindViewModel()
    }
    
    private func bindViewModel() {
        viewModel
            .getBankOptions()
            .asObservable()
            .debug()
            .bind(to: tableViewBankOption
                .rx
                .items(
                    cellIdentifier: BankOptionCell.nibName,
                    cellType: BankOptionCell.self)) { (index, element, cell) in
                        cell.bankOption = element
            }
            .disposed(by: disposeBag)
    }
    
    private func setUpTableView() {
        tableViewBankOption
            .rx
            .setDelegate(self)
            .disposed(by: disposeBag)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        print("didReceiveMemoryWarning")
    }
    
    deinit {
        print("BankOptionViewController is deinit")
    }
    
}

// MARK: Extension - UITableViewDelegate
extension BankOptionViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! BankOptionCell
        cell.labelTitle.backgroundColor = Color.TableView.bankOptionBackgroundSelected
        cell.labelTitle.textColor = Color.TableView.bankOptionTextSelected
        let bankOption = viewModel.getBankOption(at: indexPath)
        switch bankOption.type {
        case .branch:
            break
        case .atm:
            break
        case .website:
            let storyboard = UIStoryboard.storyboard(storyboard: .main)
            let websiteVC: WebsiteViewController = storyboard.instantiateViewController()
            websiteVC.bank = selectedBank
            DispatchQueue.main.async(execute: {
                self.present(websiteVC, animated: true, completion: nil)
            })
            break
        case .phone:
            break
        case .direction:
            break
        case .defaultType:
            break
        }
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! BankOptionCell
        cell.labelTitle.backgroundColor = Color.TableView.bankOptionBackgroundNormal
        cell.labelTitle.textColor = Color.TableView.bankOptionTextNormal
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return optionItemHeight
    }
}
