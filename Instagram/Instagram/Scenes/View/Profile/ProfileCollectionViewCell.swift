//
//  ProfileCollectionViewCell.swift
//  Instagram
//
//  Created by 목정아 on 2023/07/08.
//

import UIKit
import SnapKit

class ProfileCollectionViewCell : UICollectionViewCell {
    
    private let imageView = UIImageView( )
    
    func setup(with image: UIImage) {
        addSubview(imageView)
        imageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        imageView.backgroundColor = .tertiaryLabel
    }
}
