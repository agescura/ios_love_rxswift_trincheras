//
//  ListViewController.swift
//  RxArch
//
//  Created by Albert Gil Escura on 17-06-19.
//  Copyright © 2019 Albert Gil Escura. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources

final class ListViewController: UIViewController {

    // MARK: Dispose Bag
    
    private let bag = DisposeBag()
    
    // MARK: ViewModel
    
    var viewModel: ListViewModelProtocol!
    
    // MARK: Outlets
    
    @IBOutlet weak var tableView: UITableView! {
        didSet { tableView.tableFooterView = UIView() }
    }
    
    // MARK: Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.title
            .drive(navigationItem.rx.title)
            .disposed(by: bag)
        
        viewModel.todos
            .drive(tableView.rx.items(cellIdentifier: "ListViewCell",
                                      cellType: ListViewCell.self)) { _, model, cell in
                cell.setup(with: model)
            }
            .disposed(by: bag)
    }
}

