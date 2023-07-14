//
//  TitleTextFieldCell.swift
//  DanggnMarket
//
//  Created by 목정아 on 2023/07/15.
//

import RxSwift
import RxCocoa
import SnapKit
import UIKit

class TitleTextFieldCell: UITableViewCell {
    let disposeBag = DisposeBag()
    let titleInputField = UITextField()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        attribute()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func bind(_ viewModel: TitleTextFieldViewModel) {
        titleInputField.rx.text
            .bind(to: viewModel.titleText)
            .disposed(by: disposeBag)
    }

    private func attribute() {
        titleInputField.font = .systemFont(ofSize: 17)
    }
    
    private func layout() {
        contentView.addSubview(titleInputField)
        
        titleInputField.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(20)
        }
    }
}


