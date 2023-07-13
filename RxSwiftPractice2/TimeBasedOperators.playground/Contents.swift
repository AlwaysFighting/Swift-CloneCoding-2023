import RxSwift
import RxCocoa
import PlaygroundSupport

import UIKit

let disposeBag = DisposeBag()

print("----------replay----------")

// Buffer 연산자 계열
// 언제, 어떻게, 과거와 새로운 요소들을 전달할건지 제어하는 방식을 말한다.
// 시퀀스가 아이템을 방출했을 때 보통 미래에 구독자가 지나간 아이템을 받을 수 있는지 아닌지를 전달해주는 연산자

// 자신이 구독하기 전의 이벤트를 버퍼의 개수만큼 최신 순서대로 받는다.

let 인사말 = PublishSubject<String>()

let 반복하는앵무새🦜 = 인사말.replay(2)
반복하는앵무새🦜.connect()
인사말.onNext("1. hello")
인사말.onNext("2. hi")
반복하는앵무새🦜
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)
인사말.onNext("3. 안녕하세요")

print("\n----------replayAll----------")

let 닥터스트레인지 = PublishSubject<String>()
let 닥터스트레인지의타임스톤 = 닥터스트레인지.replayAll()
닥터스트레인지의타임스톤.connect()

닥터스트레인지.onNext("도르마무")
닥터스트레인지.onNext("거래를 하러왔다")

닥터스트레인지의타임스톤
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)

print("\n----------buffer----------")

//let source = PublishSubject<String>()
//
//var count = 0
//let timer = DispatchSource.makeTimerSource()
//timer.schedule(deadline: .now() + 2, repeating: .seconds(1))
//timer.setEventHandler {
//    count += 1  // 매번 1초마다 반복된다.
//    source.onNext("\(count)")
//}
//timer.resume()
//
//source
//    .buffer(
//        timeSpan: .seconds(2),
//        count: 2,
//        scheduler: MainScheduler.instance
//    )
//    .subscribe(onNext: {
//        print($0)
//    })
//    .disposed(by: disposeBag)

print("\n----------window----------")

//let 만들어낼최대Observable수 = 1
//let 만들시간 = RxTimeInterval.seconds(2)
//
//let window = PublishSubject<String>()
//
//var windowCount = 0
//let windowTimerSource = DispatchSource.makeTimerSource()
//
//windowTimerSource.schedule(deadline: .now() + 2, repeating: .seconds(1))
//windowTimerSource.setEventHandler {
//    windowCount += 1
//    window.onNext("\(windowCount)")
//}
//windowTimerSource.resume()
//
//window
//    .window(
//        timeSpan: 만들시간,
//        count: 만들어낼최대Observable수,
//        scheduler: MainScheduler.instance
//    )
//    .flatMap { windowObservable -> Observable<(index: Int, element: String)> in
//        return windowObservable.enumerated()
//    }
//    .subscribe(onNext: {
//        print("\($0.index)번째 Observable의 요소 \($0.element)")
//    })
//    .disposed(by: disposeBag)

print("\n----------delaySubscription----------")

//let delaySource = PublishSubject<String>()
//
//var delayCount = 0
//let delayTimerSource = DispatchSource.makeTimerSource()
//delayTimerSource.schedule(deadline: .now() + 2, repeating: .seconds(1))
//delayTimerSource.setEventHandler {
//    delayCount += 1
//    delaySource.onNext("\(delayCount)")
//}
//delayTimerSource.resume()
//
//// delaySource 가 이벤트를 방출시킬건데 2초 정도 지연시킨다는 의미 = 구독을 천천히 하겠다
//delaySource
//    .delaySubscription(.seconds(2), scheduler: MainScheduler.instance)
//    .subscribe(onNext: {
//        print($0)
//    })
//    .disposed(by: disposeBag)

print("\n----------delay----------")

//let delaySubject = PublishSubject<Int>()
//
//var delaySubjectCount = 0
//let delaySubjectTimerSource = DispatchSource.makeTimerSource()
//delaySubjectTimerSource.schedule(deadline: .now(), repeating: .seconds(1))
//delaySubjectTimerSource.setEventHandler {
//    delaySubjectCount += 1
//    delaySubject.onNext(delaySubjectCount)
//}
//delaySubjectTimerSource.resume()
//
//delaySubject
//    .delay(.seconds(3), scheduler: MainScheduler.instance)
//    .subscribe(onNext: {
//        print($0)
//    })
//    .disposed(by: disposeBag)

print("\n----------interval----------")

//Observable<Int>
//    .interval(.seconds(3), scheduler: MainScheduler.instance)
//    .subscribe(onNext: {
//        print($0)
//    })
//    .disposed(by: disposeBag)

print("\n----------timer----------")

//Observable<Int>
//    .timer(
//        .seconds(5),    //구독 시작 딜레이
//        period: .seconds(2),    //간격
//        scheduler: MainScheduler.instance
//    )
//    .subscribe(onNext: {
//        print($0)
//    })
//    .disposed(by: disposeBag)

print("\n----------timeout----------")

// TimeOut 이 지나면 안 눌러진다..
let 누르지않으면에러 = UIButton(type: .system)
누르지않으면에러.setTitle("눌러주세요!", for: .normal)
누르지않으면에러.sizeToFit()

PlaygroundPage.current.liveView = 누르지않으면에러

누르지않으면에러.rx.tap
    .do(onNext: {
        print("tap")
    })
    .timeout(.seconds(5), scheduler: MainScheduler.instance)
    .subscribe {
        print($0)
    }
    .disposed(by: disposeBag)
