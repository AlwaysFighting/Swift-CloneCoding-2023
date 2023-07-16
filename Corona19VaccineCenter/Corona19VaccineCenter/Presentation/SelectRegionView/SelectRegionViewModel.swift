//
//  SelectRegionViewModel.swift
//  Corona19VaccineCenter
//
//  Created by 목정아 on 2023/07/16.
//

import Foundation
import Combine

// ObservableObject : 외부에서 바라볼 때의 Observable
class SelectRegionViewModel : ObservableObject {
    
    @Published var centers = [Center.Sido: [Center]]() // dictionary 형태
    private var cancellables = Set<AnyCancellable>() // RX 의 disposeBag 의 역할
    
    init(centerNetwork: CenterNetwork = CenterNetwork()) {
        centerNetwork.getCenterList()
            .receive(on: DispatchQueue.main) // 실제로 View 에 나와야 하기에 -> main 스레드에 뿌려야 한다.
            .sink(receiveCompletion: { [weak self] in
                guard case .failure(let error) = $0 else { return }
                print("Error : \(error)")
                self?.centers = [Center.Sido: [Center]]()
            }, receiveValue: { [weak self] centers in
                // 받은 데이터의 sido 라는 기준으로 Centers 로 구룹핑 하라는 의미
                self?.centers = Dictionary(grouping: centers, by: { $0.sido })
            }).store(in: &cancellables) // dispose 와 똑같
    }
    
}
