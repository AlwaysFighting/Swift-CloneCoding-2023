import RxSwift

let disposing = DisposeBag()

print("---publishSubject---")
let publishSubject = PublishSubject<String>()

publishSubject.onNext("여러분 안녕하세요?")

let 구독자1 = publishSubject
    .subscribe(onNext: {
    print("첫 번째 구독자 : \($0)")
})

publishSubject.onNext("들리세요?")
publishSubject.on(.next("안들리시나요?"))

구독자1.dispose()

let 구독자2 = publishSubject.subscribe(onNext: {
    print("두 번째 구독자 : \($0)")
})

publishSubject.onNext("4.여보세요")
publishSubject.onCompleted()

publishSubject.onNext("5. 끝났어요")

구독자2.dispose()

publishSubject
    .subscribe {
        print("3번째 구독:", $0.element ?? $0)
    }

publishSubject.onNext("6. 찍힐까요?")

print("\n---behaviorSubject---")

enum SubjectError: Error {
    case error1
}

let behaviorSubject = BehaviorSubject<String>(value: "초기값")

behaviorSubject.onNext("1. 첫 번째 값")
behaviorSubject.subscribe {
    print("첫 번째 구독 : ", $0.element ?? $0)
}.disposed(by: disposing)

//behaviorSubject.onError(SubjectError.error1)

behaviorSubject.subscribe {
    print("두번째구독: ", $0.element ?? $0)
}.disposed(by: disposing)

// behaviorSubject 는 Value 를 뽑을 수 있다.
let value = try? behaviorSubject.value()
print(value) // 가장 첫번째 값을 호출한다. -> 잘 사용 안 함

print("\n---replaySubject---")
// 몇 개의 이벤트에 대해 버퍼를 가질 것인지?
// 제일 최신의 이벤트만 버퍼에 넣는다.
let replaySubject = ReplaySubject<String>.create(bufferSize: 2)

//3개의 이벤트 만들어보기
replaySubject.onNext("1. 여러분")
replaySubject.onNext("2. 힘내세요")
replaySubject.onNext("3. 힘들지만")

// 구독 생성
replaySubject.subscribe {
    print("첫번째 구독: ", $0.element ?? $0)
}.disposed(by: disposing)

replaySubject.subscribe {
    print("두번째 구독: ", $0.element ?? $0)
}.disposed(by: disposing)

replaySubject.onNext("4. 할수있어요")
replaySubject.onError(SubjectError.error1)
replaySubject.dispose()

// 이미 dispose 되었기 때문에 구독을 할 수 없다..
replaySubject.subscribe {
    print("세번째 구독: ", $0.element ?? $0)
}.disposed(by: disposing)
