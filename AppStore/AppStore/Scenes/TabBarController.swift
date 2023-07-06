import UIKit

class TabBarController: UITabBarController {
    
    private lazy var todayViewController: UIViewController = {
        let viewcontroller = TodayViewController()
        let tabBarItem = UITabBarItem(
            title: "투데이",
            image: UIImage(systemName: "mail"),
            tag: 0
        )
        tabBarItem.setTitleTextAttributes([NSAttributedString.Key.font: UIFont.systemFont(ofSize: 12)], for: .normal)
        viewcontroller.tabBarItem = tabBarItem
        return viewcontroller
    }()
    
    private lazy var appViewController: UIViewController = {
        let viewcontroller = UINavigationController(rootViewController: AppViewController())
        let tabBarItem = UITabBarItem(
            title: "앱",
            image: UIImage(systemName: "square.stack.3d.up"),
            tag: 1
        )
        tabBarItem.setTitleTextAttributes([NSAttributedString.Key.font: UIFont.systemFont(ofSize: 12)], for: .normal)
        viewcontroller.tabBarItem = tabBarItem
        return viewcontroller
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBar.backgroundColor = UIColor.white.withAlphaComponent(0.8)
        self.tabBarUI()
    }
}

extension TabBarController {
    private func tabBarUI() {
        tabBar.tintColor = .systemBlue
        viewControllers = [todayViewController, appViewController]
    }
}


