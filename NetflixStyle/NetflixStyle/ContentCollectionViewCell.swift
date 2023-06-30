import UIKit
import SnapKit

class ContentCollectionViewCell: UICollectionViewCell {
    let imageView = UIImageView()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.UI()
    }
    
    private func UI() {
        contentView.backgroundColor = .white
        contentView.layer.cornerRadius = 5
        contentView.clipsToBounds = true
        
        imageView.contentMode = .scaleAspectFill
        
        contentView.addSubview(imageView)
        
        imageView.snp.makeConstraints {
            // 부모 뷰의 모든 공간을 채우도록 제약 조건이 설정
            $0.edges.equalToSuperview()
        }
    }
}
