//
//  ListViewCell.swift
//  RxArch
//
//  Created by Albert Gil Escura on 21-06-19.
//  Copyright © 2019 Albert Gil Escura. All rights reserved.
//

import UIKit

final class ListViewCell: UITableViewCell {

    func setup(with model: Todo) {
        textLabel?.text = model.title
        accessoryType = model.completed ? .checkmark : .none
    }

}
