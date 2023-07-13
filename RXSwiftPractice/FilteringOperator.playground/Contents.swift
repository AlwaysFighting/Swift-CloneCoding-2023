import RxSwift

let disposeBag = DisposeBag()

print("---ignoreElements---")
let 취침모드🥱 = PublishSubject<String>()

취침모드🥱
    .ignoreElements()
    .subscribe {
        print("☀️ : \($0)")
    }.disposed(by: disposeBag)

취침모드🥱.onNext("⏰")
취침모드🥱.onNext("⏰")
취침모드🥱.onNext("⏰")

취침모드🥱.onCompleted()

// 특정 인덱스 값만 방출하겠다. (n번째 요소만 방출하겠다.)
print("---elementAt---")
let 두번울면깨는사람 = PublishSubject<String>()

// 2의 인덱스만 방출하고 나머지는 무시하겠다.
두번울면깨는사람
    .element(at: 2)
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)

두번울면깨는사람.onNext("🔔") // index : 0
두번울면깨는사람.onNext("🔔") // index : 1
두번울면깨는사람.onNext("😖") // index : 2
두번울면깨는사람.onNext("🔔") // index : 3

print("---filter---")
// filter : filtering 요구 사항이 한 가지 이상일 때 사용할 수 있다.
Observable.of(1,2,3,4,4,5,6,7,8) // 시퀀스 그대로 순서대로 방출
    .filter { $0 % 2 == 0 }
    .subscribe(onNext : {
        print("짝수만 방출 : \($0)")
    }).disposed(by: disposeBag)

Observable.of(1,2,3,4,4,5,6,7,8)
    .filter { $0  < 7 }
    .subscribe(onNext : {
        print("7 미만 요소만 방출 : \($0)")
    }).disposed(by: disposeBag)

print("---skip---")
Observable.of("😀","👼🏻","⏰","📌","💰","⭐️","🐶")
    .skip(5)
    .subscribe(onNext: {
        print("Skip : \($0)")
    }).disposed(by: disposeBag)

print("---skipWhile---")
// 특정 대상값을 기준으로 다음 값들이 출력된다.
Observable.of("😀","👼🏻","⏰","📌","💰","⭐️","🐶","😻","🐰")
    .skip(while: {
        $0 != "🐶"
    })
    .subscribe(onNext: {
        print("Skipwhile : \($0)")
    }).disposed(by: disposeBag)

print("---skipUntil---")
let customer = PublishSubject<String>()
let openingTime = PublishSubject<String>()

customer
    .skip(until: openingTime)
    .subscribe(onNext: {
        print($0)
    }).disposed(by: disposeBag)

customer.onNext("개장 전 : 😻")
customer.onNext("개장 전 : 🐶")

openingTime.onNext("⏰ 문을 열겠습니다!")
customer.onNext("개장 후 : 🐰")

print("---take---")
// <-> Skip
// take 를 통해서 작성한 카운트값만 실행되고 나머지는 무시한다는 의미
Observable.of("🥇", "🥈", "🥉", "🐶", "😻")
    .take(3)
    .subscribe(onNext: {
        print($0)
    }).disposed(by: disposeBag)

print("---takeWhile---")
// true 에 해당되는 요소만 방출된다. (거짓이 되기 전까지) <-> SkipWhile
Observable.of("🥇", "🥈", "🥉", "🐶", "😻")
    .take(while: {
        $0 != "🥉"
    })
    .subscribe(onNext: {
        print($0)
    }).disposed(by: disposeBag)


print("---enumerated---")
// 방출된 요소의 인덱스를 참고하고 싶을 경우 enumerated 를 사용한다.
// 기존 Swift 문법에도 있다.
Observable.of("🥇", "🥈", "🥉", "🐶", "😻")
    .enumerated()
    .takeWhile {
        $0.index < 3
    }
    .subscribe(onNext: {
        print($0)
    }).disposed(by: disposeBag)

print("---takeUntil---")
let 수강신청 = PublishSubject<String>()
let 신청마감 = PublishSubject<String>()

수강신청
    .take(until: 신청마감)
    .subscribe(onNext: {
        print($0)
    }).disposed(by: disposeBag)

수강신청.onNext("🙋‍♀️")
수강신청.onNext("🙋")

신청마감.onNext("📣")
수강신청.onNext("🙋🏼‍♂️")

print("---distinctUntilChanged---")
// 연달아 같은 값이 이어질때 중복된 값을 막아주는 것

// 뒤에 나온 "저는" 이 앞서 나온 "저는" 도 방출이 되었는데, 이는 "연달아서" 중복되지 않았기 때문에 출력된다.
Observable.of("저는","저는","앵무새","앵무새","앵무새","입니다","입니다","입니다", "저는","앵무새","일까요?","일까요?")
    .distinctUntilChanged()
    .subscribe(onNext: {
        print($0)
    }).disposed(by: disposeBag)
