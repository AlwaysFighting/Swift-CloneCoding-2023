//
//  ReviewWriteViewController.swift
//  BookReview
//
//  Created by 목정아 on 2023/07/28.
//

import UIKit
import SnapKit
import Kingfisher

final class ReviewWriteViewController : UIViewController {
    private lazy var presenter = ReviewWritePresenter(viewController: self)

    private lazy var bookTitleButton : UIButton = {
        let button = UIButton()
        button.setTitle("책 제목", for: .normal)
        button.setTitleColor(.tertiaryLabel, for: .normal)
        button.contentHorizontalAlignment = .left
        button.titleLabel?.font = .systemFont(ofSize: 23.0, weight: .bold)
        button.addTarget(self, action: #selector(didTapBookTitleButton), for: .touchUpInside)
        
        return button
    }()
    
    private lazy var contentTextView : UITextView = {
        let textView = UITextView()
        textView.textColor = .tertiaryLabel
        textView.text = presenter.contentsTextViewPlaceholderText
        textView.font = .systemFont(ofSize: 16.0, weight: .medium)
        textView.delegate = self
        
        return textView
    }()
    
    private lazy var imageView : UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.backgroundColor = .secondarySystemBackground
        
        return imageView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
    }
    
}

extension ReviewWriteViewController : UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        guard textView.textColor == .tertiaryLabel else {  return }
        
        textView.text = nil
        textView.textColor = .label
    }
}

extension ReviewWriteViewController: ReviewWriteProtocol {
    func setupNavigationBar() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .close,
            target: self,
            action: #selector(didTapLeftBarButton)
        )
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .save,
            target: self,
            action: #selector(didTapRightBarButton)
        )
    }
    
    func showCloseAlertController() {
        let alertController = UIAlertController(title: "작성 중인 내용이 있습니다.", message: nil, preferredStyle: .alert)
        
        let closeAction = UIAlertAction(title: "닫기", style: .destructive) { [weak self] _ in
            self?.dismiss(animated: true)
        }
        
        let cancleAction = UIAlertAction(title: "취소", style: .cancel)
        
        [ closeAction, cancleAction].forEach { alertController.addAction($0) }
        
        self.present(alertController, animated: true)
    }
    
    func close() {
        dismiss(animated: true)
    }
    
    func setupLayout() {
        
        view.backgroundColor = .systemBackground
        
        [
            bookTitleButton,
            contentTextView,
            imageView,
        ].forEach { view.addSubview($0) }
        
        bookTitleButton.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(20.0)
            $0.trailing.equalToSuperview().inset(20.0)
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(20.0)
        }
        
        contentTextView.snp.makeConstraints {
            $0.leading.equalTo(bookTitleButton.snp.leading)
            $0.trailing.equalTo(bookTitleButton.snp.trailing)
            $0.top.equalTo(bookTitleButton.snp.bottom).offset(20.0)
        }
        
        imageView.snp.makeConstraints {
            $0.leading.equalTo(contentTextView.snp.leading)
            $0.trailing.equalTo(contentTextView.snp.trailing)
            $0.top.equalTo(contentTextView.snp.bottom).offset(16.0)
            
            $0.height.equalTo(200.0)
            $0.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    func presentToSearchBookViewController() {
        let vc = UINavigationController(rootViewController: SearchBookViewController(searchBookDelegate: presenter as SearchBookDelegate))
        present(vc, animated: true)
    }
    
    func updateViews(title: String, imageURL: URL?) {
        bookTitleButton.setTitle(title, for: .normal)
        bookTitleButton.setTitleColor(.label, for: .normal)
        imageView.kf.setImage(with: imageURL)
    }
    
}

private extension ReviewWriteViewController {
    @objc func didTapLeftBarButton() {
        presenter.didTapLeftBarButton()
    }
    
    @objc func didTapRightBarButton() {
        presenter.didTapRightBarButton(contentsText: contentTextView.text)
    }
    
    @objc func didTapBookTitleButton() {
        presenter.didTapBookTitleButton()
    }
}
