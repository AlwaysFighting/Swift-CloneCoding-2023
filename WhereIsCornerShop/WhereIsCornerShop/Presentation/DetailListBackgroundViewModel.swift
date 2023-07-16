//
//  DetailListBackgroundViewModel.swift
//  WhereIsCornerShop
//
//  Created by 목정아 on 2023/07/16.
//

import RxSwift
import RxCocoa

struct DetailListBackgroundViewModel {
    //viewModel -> view
    // 만약 아무런 데이터가 없다면 보여줘야 한다. 
    let isStatusLabelHidden: Signal<Bool>
    
    //외부에서 전달받을 값
    let shouldHideStatusLabel = PublishSubject<Bool>()
    
    init() {
        isStatusLabelHidden = shouldHideStatusLabel
            .asSignal(onErrorJustReturn: true)
    }
}

