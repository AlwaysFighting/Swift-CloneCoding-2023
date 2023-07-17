//
//  ViewController.swift
//  AttributedStringTest
//
//  Created by 목정아 on 2023/07/18.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var textView: UITextView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 6.0
        
        let attributes : [NSAttributedString.Key : Any] = [
            .font: UIFont.systemFont(ofSize: 20.0, weight: .semibold),
            .foregroundColor: UIColor.systemBlue,
            .paragraphStyle: paragraphStyle
        ]
        
//        let attributedText = NSAttributedString(string: "여름 장이란 애시당초에 글러서, 해는 아직 중천에 있건만 장판은 벌써 쓸쓸하고 더운 햇발이 벌 여놓은 전 휘장 밑으로 등줄기를 훅훅 볶는다. 마을 사람들은 거의 돌아간 뒤요, 팔리지 못한 나 무꾼패가 길거리에 궁깃거리고들 있으나, 석유병이나 받고 고깃마리나 사면 족할 이 축들을 바 라고 언제까지든지 버티고 있을 법은 없다. 칩칩스럽게 날아드는 파리떼도 장난꾼 각다귀들도 귀찮다. 얽음뱅이요 왼손잡이인 드팀전의 허생원은 기어이 동업의 조선달을 나꾸어보았다.", attributes: attributes)
//
//        textView.attributedText = attributedText
        
        let mutableAttributedString = NSMutableAttributedString(string:  "여름 장이란 애시당초에 글러서, 해는 아직 중천에 있건만 장판은 벌써 쓸쓸하고 더운 햇발이 벌 여놓은 전 휘장 밑으로 등줄기를 훅훅 볶는다. 마을 사람들은 거의 돌아간 뒤요, 팔리지 못한 나 무꾼패가 길거리에 궁깃거리고들 있으나, 석유병이나 받고 고깃마리나 사면 족할 이 축들을 바 라고 언제까지든지 버티고 있을 법은 없다. 칩칩스럽게 날아드는 파리떼도 장난꾼 각다귀들도 귀찮다. 얽음뱅이요 왼손잡이인 드팀전의 허생원은 기어이 동업의 조선달을 나꾸어보았다.", attributes: attributes
        )
        
        paragraphStyle.paragraphSpacing = 10.0
        
        let additionalAttributes : [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 30.0, weight: .bold),
            .foregroundColor: UIColor.systemPink,
            .paragraphStyle: paragraphStyle
        ]
        
        // location : 몇 번째 글자부터
        // length : 몇 개의 길이로?
        mutableAttributedString.addAttributes(additionalAttributes, range: NSRange(location: 3, length: 10))
        
        textView.attributedText = mutableAttributedString
    }


}

