//
//  MainViewController.swift
//  SearchDaumBlog
//
//  Created by 목정아 on 2023/07/14.
//

import RxSwift
import RxCocoa

class MainViewController: UIViewController {
    
    let disposeBag = DisposeBag()
    
    let searchBar = SearchBar()
    let listView = BlogListView()
    
    let alertActionTapped = PublishRelay<AlertAction>()
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
        self.bind()
        self.attribute()
        self.layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

private extension MainViewController {
    
    func bind() {
        let alertSheetForSorting = listView.headerView.sortButtonTapped
            .map { _ -> Alert in
                return (title: nil, message: nil, actions: [.title, .datetime, .cancel], style: .actionSheet)
            }
        
        alertSheetForSorting
            .asSignal(onErrorSignalWith: .empty())
            .flatMapLatest { alert -> Signal<AlertAction> in
                let alertController = UIAlertController(title: alert.title, message: alert.message, preferredStyle: alert.style)
            }
            .emit(to: alertActionTapped)
            .disposed(by: disposeBag)
    }
    
    func attribute() {
        title = "다음 블로그 검색"
        view.backgroundColor = .white
    }
    
    func layout() {
        [searchBar, listView].forEach { view.addSubview($0) }
        
        searchBar.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.leading.trailing.equalToSuperview()
        }
        
        listView.snp.makeConstraints {
            $0.top.equalTo(searchBar.snp.bottom)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }
    
}

extension MainViewController {
    typealias Alert = (title: String?, message: String?, actions: [AlertAction], style: UIAlertController.Style)
    
    enum AlertAction: AlertActionConvertible {
        
        case title, datetime, cancel
        case confirm
        
        var title: String {
            switch self {
            case .title :
                return "Title"
            case .datetime:
                return "DateTime"
            case .cancel:
                return "취소"
            case .confirm:
                return "확인"
            }
        }
        
        var style: UIAlertAction.Style {
            switch self {
            case .title, .datetime:
                return .default
            case .cancel, .confirm:
                return .cancel
            }
        }
        
        func presentAlertController<Action: AlertActionConvertible>(_ alertController: UIAlertController, actions: [Action]) -> Signal<Action> {
            if actions.isEmpty { return .empty() }
            return Observable
                .create { [unowned self] observer in
                    for action in actions {
                        alertController.addAction(
                            UIAlertAction(
                                title: action.title,
                                style: action.style,
                                handler: { _ in
                                    observer.onNext(action)
                                    observer.onCompleted()
                                }
                            )
                        )
                    }
                
                    self. (alertController, animated: true, completion: nil)
                    
                    return Disposables.create {
                        alertController.dismiss(animated: true, completion: nil)
                    }
                }
                .asSignal(onErrorSignalWith: .empty())
        }
    }
}


