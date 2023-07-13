import Foundation
import RxSwift

let disposeBag = DisposeBag()

print("--------toArray--------")
// Single 요소를 -> Array 로 방출한다.
Observable.of("A", "B", "C")
    .toArray()
    .subscribe(onSuccess: {
        print($0)
    })
    .disposed(by: disposeBag)

print("\n--------map--------")

// 현재날짜를 출력하는 구문
Observable.of(Date())
    .map { date -> String in
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        dateFormatter.locale = Locale(identifier: "ko_KR")
        return dateFormatter.string(from: date)
    }
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)

print("\n--------flatMap--------")
protocol 선수 {
    var 점수: BehaviorSubject<Int> { get }
}

struct 양궁선수: 선수 {
    var 점수: BehaviorSubject<Int>
}

let 🇰🇷국가대표 = 양궁선수(점수: BehaviorSubject(value: 10))
let 🇺🇸국가대표 = 양궁선수(점수: BehaviorSubject(value: 8))

let 올림픽경기 = PublishSubject<선수>()

// 선수의 점수를 꺼낼 수 있다.
올림픽경기
    .flatMap {
        $0.점수
    }
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)

올림픽경기.onNext(🇰🇷국가대표)
🇰🇷국가대표.점수.onNext(10)

올림픽경기.onNext(🇺🇸국가대표)
🇰🇷국가대표.점수.onNext(10)
🇺🇸국가대표.점수.onNext(9)

// MARK: - flatMapLatest
print("\n--------flatMapLatest--------")
struct 높이뛰기선수: 선수 {
    var 점수: BehaviorSubject<Int>
}

let 서울 = 높이뛰기선수(점수: BehaviorSubject(value: 7))
let 제주 = 높이뛰기선수(점수: BehaviorSubject(value: 6))

let 전국체전 = PublishSubject<선수>()

전국체전
    .flatMapLatest { 선수 in
        선수.점수
    }
    .subscribe(onNext: {
        print("선수 점수 : \($0)")
    })
    .disposed(by: disposeBag)

전국체전.onNext(서울)
서울.점수.onNext(9)

// 서울이 종료되고 제주도가 실행되면 그 다음부터는 서울의 onNext 는 출력되지 않는다.
// 네트워킹 조작에서 많이 사용된다.
// 단어를 검색하는 로직에 많이 사용됨
전국체전.onNext(제주)
서울.점수.onNext(10)
제주.점수.onNext(8)

print("\n--------materialize and dematerialize--------")

// Observable을 Observable 이벤트로 변환할 때의 에러 이벤트 발생
enum 반칙: Error {
    case 부정출발
}

struct 달리기선수: 선수 {
    var 점수: BehaviorSubject<Int>
}

let 김토끼 = 달리기선수(점수: BehaviorSubject(value: 0))
let 박치타 = 달리기선수(점수: BehaviorSubject(value: 1))

let 달리기100M = BehaviorSubject<선수>(value: 김토끼)

달리기100M
    .flatMapLatest {
        $0.점수
            // "이벤트와 함께" 결과값이 도출되게 한다.
            .materialize()    // 1) materialize 추가
    }
    //  2) demeterialize 추가
    .filter {
        guard let error = $0.error else {
            return true
        }
        print(error)
        return false
    }
    // 원래의 상태로 돌려준다.
    .dematerialize()
    
    .subscribe(onNext: {
        print("점수 : \($0)")
    })
    .disposed(by: disposeBag)

김토끼.점수.onNext(1)
김토끼.점수.onError(반칙.부정출발)
김토끼.점수.onNext(2)

달리기100M.onNext(박치타)

print("\n--------전화번호 11자리--------")

let input = PublishSubject<Int?>()

let list: [Int] = [1]
input
    .flatMap {
        $0 == nil ? Observable.empty() : Observable.just($0)
    }
    .map { $0! }
    .skip(while: { $0 != 0 })
    .take(11)
    .toArray()
    .asObservable()
    .map {
        $0.map { "\($0)" }
    }
    .map { numbers in
        var numberList = numbers
        numberList.insert("-", at: 3)
        numberList.insert("-", at: 8)
        let number = numberList.reduce(" ", +)
        return number
    }
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)

input.onNext(10)
input.onNext(0)
input.onNext(nil)
input.onNext(1)
input.onNext(0)
input.onNext(4)
input.onNext(3)
input.onNext(nil)
input.onNext(1)
input.onNext(8)
input.onNext(9)
input.onNext(4)
input.onNext(9)
input.onNext(4)
