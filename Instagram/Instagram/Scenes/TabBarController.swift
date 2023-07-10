//
//  TabBarController.swift
//  Instagram
//
//  Created by 목정아 on 2023/07/08.
//

import UIKit

class TabBarController: UITabBarController {
    
    private lazy var feedViewController: UIViewController = {
        let viewcontroller = UINavigationController(rootViewController: FeedViewController())
        
        let tabBarItem = UITabBarItem(
            title: nil,
            image: UIImage(systemName: "house"),
            selectedImage: UIImage(systemName: "house.fill")
        )
        
        viewcontroller.tabBarItem = tabBarItem
        return viewcontroller
    }()
    
    private lazy var profileViewController: UIViewController = {
        let viewcontroller = UINavigationController(rootViewController: ProfileViewController())
        
        let tabBarItem = UITabBarItem(
            title: "",
            image: UIImage(systemName: "person"),
            selectedImage: UIImage(systemName: "person.fill")
        )
        viewcontroller.tabBarItem = tabBarItem
        return viewcontroller
    }()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        viewControllers = [ feedViewController, profileViewController]
        self.setupStyle()
    }
}

private extension TabBarController {
    func setupStyle() {
        UITabBar.clearShadow()
        tabBar.layer.applyShadow(color: .gray, alpha: 0.3, x: 0, y: 0, blur: 12)
    }
}

private extension CALayer {
    // Sketch 스타일의 그림자를 생성하는 유틸리티 함수
    func applyShadow(
        color: UIColor = .black,
        alpha: Float = 0.5,
        x: CGFloat = 0,
        y: CGFloat = 2,
        blur: CGFloat = 2
    ) {
        shadowColor = color.cgColor
        shadowOpacity = alpha
        shadowOffset = CGSize(width: x, height: y)
        shadowRadius = blur / 2.0
    }
}

private extension UITabBar {
    // 기본 그림자 스타일을 초기화해야 커스텀 스타일을 적용할 수 있다.
    static func clearShadow() {
        UITabBar.appearance().shadowImage = UIImage()
        UITabBar.appearance().backgroundImage = UIImage()
        UITabBar.appearance().backgroundColor = UIColor.white
    }
}
