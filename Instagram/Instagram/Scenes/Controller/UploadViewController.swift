//
//  UploadViewController.swift
//  Instagram
//
//  Created by 목정아 on 2023/07/11.
//

import UIKit
import SnapKit

final class UploadViewController : UIViewController {
    
    private let uploadImage : UIImage
    private let imageView = UIImageView()
    
    private lazy var textView: UITextView = {
        let textView = UITextView()
        textView.font = .systemFont(ofSize: 15.0)
        textView.textColor = .secondaryLabel
        textView.text = "문구 입력..."
        
        textView.delegate = self
        
        return textView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupNavigationController()
        self.setUpNavigationBar()
        
        self.setupLayout()
        
        imageView.image = uploadImage
    }
    
    init(uploadImage: UIImage) {
        self.uploadImage  = uploadImage

        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}

extension UploadViewController : UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        guard textView.textColor == .secondaryLabel else {return }
        
        textView.text = nil
        textView.textColor  = .label
    }
}

// MARK: - Navigation

private extension UploadViewController {
  func setupNavigationController() {
      view.backgroundColor = .systemBackground
      
      navigationItem.title = "새 게시물"
      navigationItem.largeTitleDisplayMode = .never
  }
  
    func setUpNavigationBar() {
        
        let shareButton = UIBarButtonItem(title: "공유", style: .plain, target: self, action: #selector(didTapRightButton))
        let cancelButton = UIBarButtonItem(title: "취소", style: .plain, target: self, action: #selector(didTapLeftButton))
        
        cancelButton.tintColor = .black
        shareButton.tintColor = .black
        
        navigationItem.rightBarButtonItem = shareButton
        navigationItem.leftBarButtonItem = cancelButton
    }
    
    @objc func didTapLeftButton() {
        dismiss(animated: true)
    }
    
    @objc func didTapRightButton() {
        dismiss(animated: true)
    }
}

// MARK: - Layout

private extension UploadViewController {
    func setupLayout() {
        [
            imageView,
            textView
        ].forEach { view.addSubview($0) }
        
        let imageViewInset : CGFloat = 16.0
        
        imageView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(imageViewInset)
            $0.leading.equalToSuperview().inset(imageViewInset)
            $0.width.equalTo(100.0)
            $0.height.equalTo(imageView.snp.width)
        }
        
        textView.snp.makeConstraints {
            $0.leading.equalTo(imageView.snp.trailing).offset(imageViewInset)
            $0.trailing.equalToSuperview().inset(imageViewInset)
            $0.top.equalTo(imageView.snp.top)
            $0.bottom.equalTo(imageView.snp.bottom)
        }
    }
}
