//
//  ViewController.swift
//  Instagram
//
//  Created by 목정아 on 2023/07/08.
//

import UIKit

class FeedViewController: UIViewController {
    
    private lazy var tableView: UITableView  = {
        let tableView = UITableView(frame: .zero)
        tableView.backgroundColor = .systemBackground
        tableView.separatorStyle = .none
        tableView.dataSource = self
        
        tableView.register(FeedTableViewCell.self, forCellReuseIdentifier: "FeedTableViewCell")
        
        return tableView
    }()
    
    private lazy var imagePickerVC : UIImagePickerController = {
        let imagePickerVC = UIImagePickerController()
        imagePickerVC.sourceType = .photoLibrary
        imagePickerVC.allowsEditing = true
        imagePickerVC.delegate = self
        
        return imagePickerVC
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupNavigationController()
        self.setUpNavigationBar()
        self.setTableViewLayout()
    }
    
}

extension FeedViewController : UIImagePickerControllerDelegate, UINavigationControllerDelegate  {
    // image 누르고 선택한 다음에 다음 동작을 실행하는 메서드
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        var selectImage: UIImage?
        
        // info : 선택된 이미지
        if let editedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            // editing 한 이미지
            selectImage = editedImage
        } else if let originImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            // 기존에 선택된 이미지 그대로
            selectImage = originImage
        }
        picker.dismiss(animated: true) { [weak self] in
            let uploadVC = UploadViewController(uploadImage: selectImage ?? UIImage())
            let navigationController = UINavigationController(rootViewController: uploadVC)
            navigationController.modalPresentationStyle = .fullScreen
            
            self?.present(navigationController, animated: true)
        }
    }
}

// MARK: - Navigation
private extension FeedViewController {
    func setupNavigationController() {
        
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 150, height: 40))
        imageView.contentMode = .scaleAspectFit
    
        let image = #imageLiteral(resourceName: "InstagramLogo")
        imageView.image = image
        
        navigationItem.titleView = imageView
        navigationItem.largeTitleDisplayMode = .never
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    func setUpNavigationBar() {
        let uploadButton = UIBarButtonItem(image: UIImage(systemName: "plus.app"), style: .plain, target: self, action: #selector(didTapUpLoadButton))
        navigationItem.rightBarButtonItem = uploadButton
    }
    
    @objc func didTapUpLoadButton() {
        present(imagePickerVC, animated: true)
    }
}

// MARK: - Layout
private extension FeedViewController {
    func setTableViewLayout() {
        view.addSubview(tableView)
        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
      }
}

extension FeedViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "FeedTableViewCell", for: indexPath) as? FeedTableViewCell else { return UITableViewCell() }
        cell.selectionStyle = .none
        cell.setUP()
        
        return cell
    }
    
}
