//
//  HomeViewController.swift
//  Grind
//
//  Created by 최형민 on 2022/09/14.
//

import UIKit
import SnapKit
import Then

final class HomeViewController: BaseViewController {
    
    required init?(coder: NSCoder) {
        super.init(coder: <#T##NSCoder#>)
    }
    private lazy var collectionView: UICollectionView {
        let view = UICollectionView(frame: CGRect(), collectionViewLayout: )
        view.backgroundColor = .clear
        view
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func configureUI() {
        
    }
    
    override func setConstraints() {
        <#code#>
    }
}

extension HomeViewController {
    func configureCellLayout() {
        // 컬렉션뷰의 셀 크기, 셀 사이 간격 등 설정
        let layout = UICollectionViewFlowLayout()
        // FlowLayout!
        let spacing: CGFloat = 10
        let width = UIScreen.main.bounds.width - (spacing * 4)
        // 여백없이 디바이스를 3으로 나눔
        layout.itemSize = CGSize(width: width / 3, height: (width / 3) * 1.2)
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: spacing, left: spacing, bottom: spacing, right: spacing)
        layout.minimumLineSpacing = spacing
        layout.minimumInteritemSpacing = spacing
        collectionView.collectionViewLayout = layout
    }
}
