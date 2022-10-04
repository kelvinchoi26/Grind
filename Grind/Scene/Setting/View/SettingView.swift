//
//  SettingView.swift
//  Grind
//
//  Created by 최형민 on 2022/10/04.
//

import UIKit

class SettingView: BaseView {

    var tableView = UITableView(frame: .zero, style: .insetGrouped)

    override func configureUI() {

        self.backgroundColor = Constants.Color.backgroundColor

        tableView.backgroundColor = .clear
    }

    override func setConstraints() {

        self.addSubview(tableView)

        tableView.snp.makeConstraints {
            $0.edges.equalTo(self.safeAreaLayoutGuide)
        }
    }
}
