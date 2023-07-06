//
//  ExchangeCodeButtonView.swift
//  AppStore
//
//  Created by 목정아 on 2023/07/05.
//

import UIKit
import SnapKit

final class ExchangeCodeButtonView: UIView {
    
    private lazy var exchangeButton: UIButton = {
        let button = UIButton()
        button.setTitle("코드 교환", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 15.0, weight: .semibold)
        button.setTitleColor(.systemBlue, for: .normal)
        button.backgroundColor = .tertiarySystemGroupedBackground
        button.layer.cornerRadius = 7.0
        
        return button
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

private extension ExchangeCodeButtonView {
    func setup() {
        addSubview(exchangeButton)
        
        exchangeButton.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(16.0)
            $0.trailing.equalToSuperview().inset(16.0)
            $0.top.equalToSuperview().inset(32.0)
            $0.bottom.equalToSuperview().inset(32.0)
            $0.height.equalTo(40.0)
        }
        
    }
}
