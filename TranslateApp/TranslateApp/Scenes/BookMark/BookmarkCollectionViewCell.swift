//
//  BookmarkCollectionViewCell.swift
//  TranslateApp
//
//  Created by 목정아 on 2023/07/18.
//

import UIKit
import SnapKit

final class BookmarkCollectionViewCell : UICollectionViewCell {
    
    static let identifier = "BookmarkCollectionViewCell"
    
    private var sourceBookmarkTextStackView = BookmarkTextStackView(language: .ko, text: "", type: .source)
    private var targetBookmarkTextStackView = BookmarkTextStackView(language: .en, text: "", type: .target)
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.spacing = 16.0
        
        stackView.layoutMargins = UIEdgeInsets(top: 16.0, left: 16.0, bottom: 16.0, right: 16.0)
        stackView.isLayoutMarginsRelativeArrangement = true
        
        return stackView
    }()
    
    func setup(from bookmark : Bookmark) {
        backgroundColor = .white
        layer.cornerRadius = 12.0
        
        sourceBookmarkTextStackView = BookmarkTextStackView(
            language: bookmark.sourceLanguage,
            text: bookmark.sourceText,
            type: .source
        )
        
        targetBookmarkTextStackView = BookmarkTextStackView(
            language: bookmark.translatedLanguage,
            text: bookmark.translatedText,
            type: .target
        )
        
        stackView.subviews.forEach { $0.removeFromSuperview() }
        
        [
            sourceBookmarkTextStackView,
            targetBookmarkTextStackView
        ].forEach { stackView.addArrangedSubview($0) }
        
        addSubview(stackView)
        stackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.width.equalTo(UIScreen.main.bounds.size.width - 32.0)
        }
        
        // 레이아웃을 한 번 더 업데이트하기
        layoutIfNeeded()
        
    }
}
