//
//  StationDetailCollectionViewCell.swift
//  SubWay
//
//  Created by 목정아 on 2023/07/06.
//

import UIKit
import SnapKit

class StationDetailCollectionViewCell : UICollectionViewCell {
    
    private lazy var lineLabel : UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15.0, weight: .bold)
        
        return label
    }()
    
    private lazy var remainTimeLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15.0, weight: .medium)
        
        return label
    }()
    
    func setup(with realTimeArrival: StationArrivalDatResponseModel.RealTimeArrival) {
        
        layer.cornerRadius = 12.0
        layer.shadowColor = UIColor.black.withAlphaComponent(0.5).cgColor
        layer.shadowOpacity = 0.2
        layer.shadowRadius  = 5
        
        backgroundColor = .systemBackground
        
        [
            lineLabel,
            remainTimeLabel
        ].forEach {
            addSubview($0)
        }
        
        lineLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(16.0)
            $0.trailing.equalToSuperview().inset(16.0)
            $0.top.equalToSuperview().inset(16.0)
        }
        
        remainTimeLabel.snp.makeConstraints {
            $0.leading.equalTo(lineLabel.snp.leading)
            $0.top.equalTo(lineLabel.snp.bottom).offset(16.0)
            $0.bottom.equalToSuperview().inset(16.0)
        }
        
        lineLabel.text = realTimeArrival.line
        remainTimeLabel.text = realTimeArrival.remainTime
    }
    
}
