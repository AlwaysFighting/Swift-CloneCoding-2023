//
//  MainViewModel.swift
//  DanggnMarket
//
//  Created by 목정아 on 2023/07/14.
//

import RxSwift
import RxCocoa

struct MainViewModel {
    let titleTextFieldCellViewModel = TitleTextFieldViewModel()
    let priceTextFieldCellViewModel =  PriceTextFieldCellViewModel()
    let detailWriteFormCellViewModel = DetailWriteFormCellViewModel()
    
    // ViewModel -> View
    let cellData: Driver<[String]>
    let presentAlert: Signal<Alert>
    // 카테고리를 누르면 카테고리 디테일을 보여주는 VC 를 보여주도록 바인드해주는 Driver
    let push: Driver<CategoryViewModel>
    
    // View -> ViewModel
    let itemSelected = PublishRelay<Int>()
    let submitButtonTapped = PublishRelay<Void>()
    
    init(model: MainModel = MainModel()) {
        //MARK:-cell data
        let title = Observable.just("글 제목") // just 를 통해 placeholder
        let categoryViewModel = CategoryViewModel()
        let category = categoryViewModel
            .selectedCategory
            .map { $0.name }
            .startWith("카테고리 선택")
        
        let price = Observable.just("₩ 가격 (선택사항)")
        let detail = Observable.just("내용을 입력하세요.")
        
        self.cellData = Observable
            .combineLatest(
                title,
                category,
                price,
                detail
            ) { [$0, $1, $2, $3] }
            .asDriver(onErrorDriveWith: .empty())
        
        //MARK:-present alert
        let titleMessage = titleTextFieldCellViewModel
            .titleText
            .map { $0?.isEmpty ?? true }
            .startWith(true)
            .map { $0 ? ["- 글 제목을 입력해주세요."] : [] }
        
        let categoryMessage = categoryViewModel
            .selectedCategory
            .map { _ in false }
            .startWith(true)
            .map { $0 ? ["- 카테고리를 선택해주세요."] : [] }
        
        let detailMessage = detailWriteFormCellViewModel
            .contentValue
            .map { $0?.isEmpty ?? true }
            .startWith(true)
            .map { $0 ? ["- 내용을 입력해주세요."] : [] }
        
        let errorMessages = Observable
            .combineLatest(
                titleMessage,
                categoryMessage,
                detailMessage
            ) { $0 + $1 + $2 }
        
        self.presentAlert = submitButtonTapped
            .withLatestFrom(errorMessages) { $1 }
            .map(model.setAlert)
            .asSignal(onErrorSignalWith: .empty())
        
        //MARK:-push
        self.push = itemSelected
            .compactMap { row -> CategoryViewModel? in
                guard case 1 = row else {
                    return nil
                }
                return categoryViewModel
            }
            .asDriver(onErrorDriveWith: .empty())
    }
}
