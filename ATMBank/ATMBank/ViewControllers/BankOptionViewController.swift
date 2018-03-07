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
    
    // MARK: IBActions
    
    @IBAction func buttonClose(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    // MARK: Properties
    private var viewModel: BankOptionViewModelType!
    private let disposeBag: DisposeBag = DisposeBag()
    
    // MARK: Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = BankOptionViewModel()
        bindViewModel()
        setUpTableView()
    }
    
    private func bindViewModel() {
        viewModel
            .getBankOptions()
            .asObservable()
            .debug()
            .bind(to: tableViewBankOption.rx.items(cellIdentifier: BankOptionCell.nibName, cellType: BankOptionCell.self)) { (index, element, cell) in
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
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! BankOptionCell
        cell.labelTitle.backgroundColor = Color.TableView.bankOptionBackgroundNormal
        cell.labelTitle.textColor = Color.TableView.bankOptionTextNormal
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80.0
    }
}
