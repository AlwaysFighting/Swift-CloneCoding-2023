//
//  SearchBar.swift
//  SearchDaumBlog
//
//  Created by 목정아 on 2023/07/14.
//

import UIKit
import RxCocoa
import RxSwift
import SnapKit

class SearchBar: UISearchBar {
    
    let disposeBag = DisposeBag()
    
    let seachButton = UIButton()
    
    // SearchBar Button Tapped Event
    let searchButtonTapped = PublishRelay<Void>()
    
    // SearchBar 외부로 보낼 이벤트
    var shouldLoadResult = Observable<String>.of("")
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.bind()
        self.attribute()
        self.layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
   
}

private extension SearchBar {
    func bind() {
        Observable.merge(
            self.rx.searchButtonClicked.asObservable(),
            seachButton.rx.tap.asObservable()
        ).bind(to: searchButtonTapped)
            .disposed(by: disposeBag)
        
        searchButtonTapped
            .asSignal()
            .emit(to: self.rx.endEditing)
            .disposed(by: disposeBag)
        
        // Search 버튼이 tapped 됐을 때 텍스트 뷰를 내보내줘야 한다.
        self.shouldLoadResult = searchButtonTapped
            .withLatestFrom(self.rx.text) { $1 ?? ""} // 가장 최신 값이 빈값이면 return
            .filter { !$0.isEmpty} // 공백이면 return
            .distinctUntilChanged() // 중복된 값 제거
    }
    
    func attribute() {
        seachButton.setTitle("검색", for: .normal)
        seachButton.setTitleColor(.systemBlue, for: .normal)
    }
    
    func layout() {
        addSubview(seachButton)
        
        searchTextField.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(12)
            $0.trailing.equalTo(seachButton.snp.leading).offset(-12)
            $0.centerY.equalToSuperview()
        }
        
        seachButton.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().inset(12)
        }
    }
}

extension Reactive where Base: SearchBar {
    
    // keyboard 가 내려가도록
    var endEditing: Binder<Void> {
        return Binder(base) { base, _ in
            base.endEditing(true)
        }
    }
}
