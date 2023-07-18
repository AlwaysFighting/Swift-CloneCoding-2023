//
//  TabBarController.swift
//  TranslateApp
//
//  Created by 목정아 on 2023/07/18.
//

import UIKit

class TabBarController : UITabBarController {
    
    private lazy var translateViewController: UIViewController = {
      let viewcontroller = TranslateViewController()
      
      let tabBarItem = UITabBarItem(
          title: NSLocalizedString("Translate", comment: "번역"),
          image: UIImage(systemName: "mic"),
          selectedImage: UIImage(systemName: "mic.fill")
      )
      
      viewcontroller.tabBarItem = tabBarItem
      
      return viewcontroller
    }()

    private lazy var bookMarkViewController: UIViewController = {
      let viewcontroller = UINavigationController(rootViewController: BookMarkListViewController())
      
      let tabBarItem = UITabBarItem(
          title: NSLocalizedString("Bookmark", comment: "즐겨찾기"),
          image: UIImage(systemName: "star"),
          selectedImage: UIImage(systemName: "star.fill")
      )
      viewcontroller.tabBarItem = tabBarItem
      return viewcontroller
    }()
    
    override func viewDidLoad() {
          super.viewDidLoad()
          tabBar.backgroundColor = .white
          tabBar.tintColor = .systemPink
         viewControllers = [translateViewController, bookMarkViewController]
      }
}
