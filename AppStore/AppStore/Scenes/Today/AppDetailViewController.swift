//
//  AppDetailViewController.swift
//  AppStore
//
//  Created by 목정아 on 2023/07/06.
//

import UIKit
import SnapKit
import Kingfisher

class AppDetailViewController : UIViewController {
    
    private let today: Today
    
    private let appIconImageView : UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 8.0
        imageView.image = #imageLiteral(resourceName: "Water_Bottle")
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        
        return imageView
    }()
    
    private let titleLabel :UILabel = {
        let label = UILabel()
        label.text = "물 마시기 운동"
        label.font = .systemFont(ofSize: 20, weight: .bold)
        
        return label
    }()
    
    private let subTitleLabel : UILabel = {
        let label = UILabel()
        label.text = "하루에 2리터, 도전해보세요"
        label.font = .systemFont(ofSize: 14, weight: .medium)
        label.textColor = .secondaryLabel
        
        return label
    }()
    
    private let downloadButton: UIButton = {
        let button = UIButton()
        button.setTitle("받기", for: .normal)
        button.titleLabel?.textColor = .white
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 12.0
        button.titleLabel?.font = .systemFont(ofSize: 13.0, weight: .bold)
        
        return button
    }()
    
    private let shareButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "square.and.arrow.up"), for: .normal)
        button.tintColor = .systemBlue
        button.addTarget(self, action: #selector(didTapShareButton), for: .touchUpInside)
        
        return button
    }()
    
    init(today: Today) {
        self.today = today
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground

        setupViews()
        
        titleLabel.text = today.title
        subTitleLabel.text = today.subTitle
        if let imageURL = URL(string: today.imageURL){
          appIconImageView.kf.setImage(with: imageURL)
        }
    }
}

private extension AppDetailViewController {
    func setupViews() {
        [
            appIconImageView,
            titleLabel,
            subTitleLabel,
            downloadButton,
            shareButton
        ].forEach { view.addSubview($0) }
        
        appIconImageView.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(16.0)
            $0.top.equalToSuperview().inset(32.0)
            $0.height.equalTo(100.0)
            $0.width.equalTo(appIconImageView.snp.height)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(appIconImageView.snp.top)
            $0.leading.equalTo(appIconImageView.snp.trailing).offset(16.0)
            $0.trailing.equalToSuperview().inset(16.0)
        }
        
        subTitleLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(4.0)
            $0.leading.equalTo(titleLabel.snp.leading)
        }
        
        downloadButton.snp.makeConstraints {
            $0.bottom.equalTo(appIconImageView.snp.bottom)
            $0.height.equalTo(24.0)
            $0.leading.equalTo(titleLabel.snp.leading)
            $0.width.equalTo(60.0)
        }
        
        shareButton.snp.makeConstraints {
            $0.bottom.equalTo(appIconImageView.snp.bottom)
            $0.height.equalTo(32.0)
            $0.trailing.equalTo(titleLabel.snp.trailing)
            $0.width.equalTo(32.0)
        }
    }
    
    @objc func didTapShareButton() {
        let activityItems: [Any] = [today.title]
        let activityVC = UIActivityViewController(activityItems: activityItems, applicationActivities: nil)
        present(activityVC, animated: true)
    }
}
