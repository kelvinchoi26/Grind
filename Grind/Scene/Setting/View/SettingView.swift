//
//  SettingView.swift
//  Grind
//
//  Created by 최형민 on 2022/10/04.
//

import UIKit

class SettingView: BaseView {
    
    let collectionView: UICollectionView = {
        let configuration = UICollectionLayoutListConfiguration(appearance: .insetGrouped)
        let layout = UICollectionViewCompositionalLayout.list(using: configuration)
        
        let view = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
 
        return view
    }()

    var tableView = UITableView(frame: .zero, style: .insetGrouped)

    override func configureUI() {

        self.backgroundColor = .clear
        
        collectionView.collectionViewLayout = createLayout()


    }

    override func setConstraints() {
        
        self.addSubview(collectionView)

//        self.addSubview(tableView)
//
//        tableView.snp.makeConstraints {
//            $0.edges.equalTo(self.safeAreaLayoutGuide)
//        }
        
        collectionView.snp.makeConstraints {
            $0.edges.equalTo(self.safeAreaLayoutGuide)
        }
    }
}

extension SettingView {
    private func createLayout() -> UICollectionViewLayout {
        var config = UICollectionLayoutListConfiguration(appearance: .insetGrouped)
        config.showsSeparators = false
        config.backgroundColor = .brown
        let layout = UICollectionViewCompositionalLayout.list(using: config)
        return layout
    }
}
