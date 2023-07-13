import RxSwift

let disposeBag = DisposeBag()

print("----------startWith----------")

// 네트워크 연결 상태같이 현재 상태, 초기값이 필요한 경우가 있다. 이럴 때 startWith 를 사용한다.

let 노랑반 = Observable.of("👧🏼", "🧒🏻", "👦🏽")
    
노랑반
    .enumerated() // 인덱스와 element 를 보여주는 것
    .map {
        $0.element + "어린이" + "\($0.index)"
    }
    .startWith("👨🏻선생님") // Observable 과 같은 타입, 즉 현재는 String 으로 같은 타입으로 맞춰야 한다.
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)

print("\n----------concat1----------")

// startWith 의 변환 형태라고 볼 수 있다.

let 노랑반어린이들 = Observable.of("👧🏼", "🧒🏻", "👦🏽")
let 선생님 = Observable.of("👨🏻")

let 줄서서걷기 = Observable
    .concat([선생님, 노랑반어린이들])
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)

print("\n----------concat2----------")

선생님
    .concat(노랑반어린이들)
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)

print("\n----------concatMap----------")

// flatmap 과 유사함.
// 각각의 시퀀스가 다음 시퀀스가 구독되기 전에 합쳐지는 것을 뜻한다.

let 어린이집 = [
    "노랑반": Observable.of("👧🏼", "🧒🏻", "👦🏽"),
    "파랑반": Observable.of("👶🏾", "👶🏻")
]

Observable.of("노랑반", "파랑반")
    .concatMap { 반 in
        어린이집[반] ?? .empty()
    }
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)

print("\n----------merge1----------")

// 시퀀스를 합친다.

let 강북 = Observable.from(["강북구", "성북구", "동대문구", "종로구"])
let 강남 = Observable.from(["강남구", "강동구", "영등포구", "양천구"])

Observable.of(강북, 강남)
    .merge()
    .subscribe(onNext: {
        print("서울특별시의 구:", $0)
    })
    .disposed(by: disposeBag)

print("\n----------merge2----------")

Observable.of(강북, 강남)
    .merge(maxConcurrent: 1)
    .subscribe(onNext: {
        print("서울특별시의 구:", $0)
    })
    .disposed(by: disposeBag)

print("\n----------combineLatest1----------")

// 값을 방출할 때마다 제공되는 클로저를 호출하게 되고, 받은 시퀀스의 최종 시퀀스를 받는다.
// 각각의 최신의 값으로 각각 방출된다.
// 여러 텍스트필드를 한 번에 관찰하고 값을 결합하거나 여러 소스들을 보는 앱 같은 경우 많이 쓰인다.

let 성 = PublishSubject<String>()
let 이름 = PublishSubject<String>()

let 성명 = Observable.combineLatest(성, 이름) { 성, 이름 in
    성 + 이름
}

성명
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)

성.onNext("김") // "성" 에 대한 최신값 = "김"
이름.onNext("똘똘") // "이름" 에 대한 최신값 = "똘똘"
이름.onNext("영수") // "이름" 에 대한 최신값 = "영수"
이름.onNext("은영") // "이름" 에 대한 최신값 = "은영"
성.onNext("박") // "성" 에 대한 최신값 = "박"
성.onNext("이") // "성" 에 대한 최신값 = "이"
성.onNext("조") // "성" 에 대한 최신값 = "조"

print("\n----------combineLatest2----------")

// 날짜가 짧은 형태 & 긴 형태로 출력되게 한다.
let 날짜표시형식 = Observable<DateFormatter.Style>.of(.short, .long)
let 현재날짜 = Observable<Date>.of(Date())

let 현재날짜표시 = Observable
    .combineLatest(
        날짜표시형식,
        현재날짜,
        resultSelector: { 형식, 날짜 -> String in
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = 형식
            return dateFormatter.string(from: 날짜)
        }
    )

현재날짜표시
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)

print("\n----------combineLatest3----------")

let lastName = PublishSubject<String>()     //성
let firstName = PublishSubject<String>()    //이름

let fullName = Observable.combineLatest([firstName, lastName]) { name in
    name.joined(separator: " ")
}

fullName
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)

lastName.onNext("Kim")
firstName.onNext("Paul")
firstName.onNext("Stella")
firstName.onNext("Lily")

print("\n----------zip----------")

// zip 은

enum 승패 {
    case 승
    case 패
}

let 승부 = Observable<승패>.of(.승, .승, .패, .승, .패)
let 선수 = Observable<String>.of("🇰🇷", "🇨🇭", "🇺🇸", "🇧🇷", "🇯🇵", "🇨🇳")

// 승부와 선수 의 element 를 받아서 출력하고 있다.
let 시합결과 = Observable.zip(승부, 선수) { 결과, 대표선수 in
    return 대표선수 + "선수" + " \(결과)!"
}

시합결과
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)

print("----------withLatestFrom1----------")

// 트리거 성격 (방아쇠 역할)
// 둘 중의 하나의 옵저버블이 시작하면 그 시점을 토대로 작동하는, 방아쇠 역할을 하는 메서드이다.

let 💥🔫 = PublishSubject<Void>()
let 달리기선수 = PublishSubject<String>()

💥🔫.withLatestFrom(달리기선수)
//    .distinctUntilChanged()     //Sample과 똑같이 쓰고 싶을 때
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)

달리기선수.onNext("🏃🏻‍♀️")
달리기선수.onNext("🏃🏻‍♀️ 🏃🏽‍♂️")
달리기선수.onNext("🏃🏻‍♀️ 🏃🏽‍♂️ 🏃🏿")

💥🔫.onNext(Void())
💥🔫.onNext(Void())

print("\n----------sample----------")
let 🏁출발 = PublishSubject<Void>()
let F1선수 = PublishSubject<String>()

F1선수.sample(🏁출발)
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)

F1선수.onNext("🏎")
F1선수.onNext("🏎   🚗")
F1선수.onNext("🏎      🚗   🚙")
🏁출발.onNext(Void())
🏁출발.onNext(Void())
🏁출발.onNext(Void())

print("----------amb----------")

// "모호한"의 약자
// 두 가지 시퀀스를 가지는데, 둘 다 애매할 경우 사용하는 메서드
// 두 가지 옵저블을 모두 구독하긴 하는데, 어떤 것이든 먼저 방출하는 애가 생기면 나머지는 구독하지 않게 된다.

let 🚌버스1 = PublishSubject<String>()
let 🚌버스2 = PublishSubject<String>()

let 🚏버스정류장 = 🚌버스1.amb(🚌버스2)

🚏버스정류장.subscribe(onNext: {
    print($0)
})
.disposed(by: disposeBag)

🚌버스2.onNext("버스2-승객0: 👩🏾‍💼")
🚌버스1.onNext("버스1-승객0: 🧑🏼‍💼")
🚌버스1.onNext("버스1-승객1: 👨🏻‍💼")
🚌버스2.onNext("버스2-승객1: 👩🏻‍💼")
🚌버스1.onNext("버스1-승객1: 🧑🏻‍💼")
🚌버스2.onNext("버스2-승객2: 👩🏼‍💼")

print("\n----------switchLatest----------")

let 👩🏻‍💻학생1 = PublishSubject<String>()
let 🧑🏽‍💻학생2 = PublishSubject<String>()
let 👨🏼‍💻학생3 = PublishSubject<String>()

let 손들기 = PublishSubject<Observable<String>>()

let 손든사람만말할수있는교실 = 손들기.switchLatest()
손든사람만말할수있는교실
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)

손들기.onNext(👩🏻‍💻학생1)
👩🏻‍💻학생1.onNext("👩🏻‍💻학생1: 저는 1번 학생입니다.")
🧑🏽‍💻학생2.onNext("🧑🏽‍💻학생2: 저요 저요!!!")

손들기.onNext(🧑🏽‍💻학생2)
🧑🏽‍💻학생2.onNext("🧑🏽‍💻학생2: 저는 2번이예요!")
👩🏻‍💻학생1.onNext("👩🏻‍💻학생1: 아.. 나 아직 할말 있는데")

손들기.onNext(👨🏼‍💻학생3)
🧑🏽‍💻학생2.onNext("🧑🏽‍💻학생2: 아니 잠깐만! 내가! ")
👩🏻‍💻학생1.onNext("👩🏻‍💻학생1: 언제 말할 수 있죠")
👨🏼‍💻학생3.onNext("👨🏼‍💻학생3: 저는 3번 입니다~ 아무래도 제가 이긴 것 같네요.")

손들기.onNext(👩🏻‍💻학생1)
👩🏻‍💻학생1.onNext("👩🏻‍💻학생1: 아니, 틀렸어.")
👩🏻‍💻학생1.onNext("👩🏻‍💻학생1: 승자는 나야.")
🧑🏽‍💻학생2.onNext("🧑🏽‍💻학생2: ㅠㅠ")
👨🏼‍💻학생3.onNext("👨🏼‍💻학생3: 이긴 줄 알았는데")
🧑🏽‍💻학생2.onNext("🧑🏽‍💻학생2: 이거 이기고 지는 손들기였나요?")
👩🏻‍💻학생1.onNext("👩🏻‍💻학생1: 🙋")

print("\n----------reduce----------")

Observable.from((1...10))
    .reduce(10, accumulator: { summary, newValue in
        return summary + newValue
    })
//    .reduce(0, accumulator: +)
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)

print("\n----------scan----------")


Observable.from((1...10))
    .scan(10, accumulator: +)
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)
