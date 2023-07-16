//
//  CenterNetwork.swift
//  Corona19VaccineCenter
//
//  Created by 목정아 on 2023/07/16.
//

import Foundation
import Combine

class CenterNetwork {
    private let session: URLSession
    let api = CenterAPI()
    
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    // AnyPublisher: 기본 데이터 뿐만 아니라 에러를 기본적으로 제공해줘야 한다.
    func getCenterList() -> AnyPublisher<[Center], URLError> {
        guard let url = api.getCenterListComponents().url else {
            return Fail(error: URLError(.badURL)).eraseToAnyPublisher()
        }
        
        var request = URLRequest(url: url)
        request.setValue("Infuser DECODING_KEY", forHTTPHeaderField: "Authorization")
        
        return session.dataTaskPublisher(for: request)
            .tryMap { data, response in
                guard let httpResponse = response as? HTTPURLResponse else {
                    throw URLError(.unknown) // 모르는 에러라고 내보내기
                }
                
                // 통과했다면 다음과 같이 상태를 알아보자
                switch httpResponse.statusCode {
                case 200..<300:
                    return data  // Success
                case 400..<500:
                    throw URLError(.clientCertificateRejected) // ClientError
                case 500..<599:
                    throw URLError(.badServerResponse) // Server Error
                default:
                    throw URLError(.unknown) // 실패지만, 우리가 모르는 에러
                }
            }
            .decode(type: CenterAPIResponse.self, decoder: JSONDecoder()) // Combine 의 Decode 형태! 짱 유용함
            .map { $0.data }
            .mapError { $0 as! URLError }
            .eraseToAnyPublisher()
    }
}
