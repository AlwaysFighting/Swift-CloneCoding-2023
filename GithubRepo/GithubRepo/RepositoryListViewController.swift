//
//  RepositoryListViewController.swift
//  GithubRepo
//
//  Created by 목정아 on 2023/07/13.
//

import UIKit
import RxSwift
import RxCocoa

class RepositoryListViewController : UITableViewController {
    
    private let organization = "Apple"
    
    private let repositories = BehaviorSubject<[Repository]>(value: [])
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = organization + "Repository"
        
        self.refreshControl = UIRefreshControl()
        
        let refreshControl = self.refreshControl!
        refreshControl.tintColor = .darkGray
        refreshControl.backgroundColor = .white
        refreshControl.attributedTitle = NSAttributedString(string: "당겨서 새로고침")
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        
        tableView.register(RepositoryListCell.self, forCellReuseIdentifier: "RepositoryListCell")
        tableView.rowHeight = 140
    }
    
    // MARK: - refreshControl
    @objc func refresh() {
        DispatchQueue.global(qos: .background).async { [weak self] in
            guard let self = self else { return }
            self.fetchRepositories(of: self.organization)
        }
    }
    
    // MARK: - Fetch_Data Network ⭐️

    func fetchRepositories(of organization: String) {
        Observable.from([organization])
            .map { organization -> URL in
                return URL(string: "https://api.github.com/orgs/\(organization)/repos")!
            }
            .map { url -> URLRequest in
                var request = URLRequest(url: url)
                request.httpMethod = "GET"
                return request
            }
            .flatMap { request -> Observable<(response: HTTPURLResponse, data: Data)> in
                return URLSession.shared.rx.response(request: request)
            }
            // filter 을 사용해서 응답과 잘 오지 못한 응답을 구분하겠다.
            .filter { responds, _ in
                // 200 ~ 300 번대 경우에만 넘겨줘
                return 200..<300 ~= responds.statusCode
            }
            // 이번엔 데이터를 받을건데, 나중에 Any 타입을 다른 타입으로 변경할거다.
            .map { _, data -> [[String:Any]] in
                guard let json = try? JSONSerialization.jsonObject(with: data, options: []),
                      let result = json as? [[String: Any]] else {
                        return []
                }
                return result
            }
            // 만약 데이터가 빈 배열, 즉 0이라면 무시하겠다
            .filter { result in
                return result.count > 0
            }
            // 어떠한 형태든 json 데이터를 받은 것을 내가 원하는 엔티티로 변경해주겠다.
            // dictionary 에서 못풀면 nil 값으로 풀겠다. CompactMap 에서 nil 값을 자동적으로 없애고 나오도록 하겠다.
            // 내가 파일에서 설정한 변수 이름을 알려준다.
            .map { objects in
                return objects.compactMap { dictionary -> Repository? in
                    guard let id = dictionary["id"] as? Int,
                          let name = dictionary["name"] as? String,
                          let description = dictionary["description"] as? String,
                          let staragazersCount = dictionary["stargazers_count"] as? Int,
                    let language = dictionary["language"] as? String else { return nil}
                    
                    return Repository(id: id, name: name, description: description, staragazersCount: staragazersCount, language: language)
                 }
            }
            // ⭐️ 반드시 구독해주기!!
            .subscribe(onNext: { [weak self] newRepositories in
                self?.repositories.onNext(newRepositories)
                
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                    self?.refreshControl?.endRefreshing() // 새로운 아이템 받았으면 그만해
                }
            }).disposed(by: disposeBag)
    }
    
}

// MARK: - UITableView
extension RepositoryListViewController  {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        do {
            return try repositories.value().count
        } catch {
            return 0
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "RepositoryListCell", for: indexPath) as? RepositoryListCell else { return UITableViewCell() }
        
        var currentRepo: Repository? {
            do {
                return try repositories.value()[indexPath.row]
            } catch {
                return nil
            }
        }
        
        cell.repository = currentRepo
        
        return cell
    }
}
