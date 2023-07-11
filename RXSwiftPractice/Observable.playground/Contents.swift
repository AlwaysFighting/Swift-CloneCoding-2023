import UIKit
import RxSwift

// MARK: - Observable

// 어떠한 형태의 Element 를 호출할 것인지 설정할 수 있다.
// just : 하나의 Element 만 호출할 수 있다.
print("-----Just------")
Observable<Int>.just(1).subscribe(onNext: {
    print($0) // 1
})

print("-----Of1------")
// 하나 이상의 이벤트를 넣을 수 있다.
// Observable array 를 넣을 수도 있다.
Observable<Int>.of(1,2,3,4,5).subscribe(onNext:  {
    print($0)
})

print("-----Of2------")
Observable.of([1,2,3,4,5]).subscribe(onNext:  {
    print($0)
})

print("-----From------")
Observable.from([1,2,3,4,5]).subscribe(onNext:  {
    print($0)
})

print("-----Subscribe1------")
Observable.of(1,2,3)
    .subscribe {
        print($0)
    }

print("\n-----Subscribe2------")
Observable.of(1,2,3)
    .subscribe {
        if let element = $0.element {
            print(element)
        }
    }

print("\n-----empty------")
Observable<Void>.empty()
    .subscribe  {
            print($0)
    }
       
print("\n-----never------")
Observable<Void>.never()
    .debug("아무 것도 출력되지 않지만 debug 를 넣으면 출력할 수 있다.")
    .subscribe (
        onNext: {
            print($0)
        },
        onCompleted: {
            print("Completed")
        }
    )

print("\n-----range------")
Observable.range(start: 1, count: 9)
    .subscribe (onNext: {
        print("2*\($0)=\(2*$0)")
    })

print("\n-----dispose------")
Observable.of(1,2,3)
    .subscribe (onNext: {
        print($0)
    }).dispose()

print("\n-----disposeBag------")
let disposeBag = DisposeBag()

Observable.of(1,2,3)
    .subscribe {
        print($0)
    }.disposed(by: disposeBag)

print("\n-----create1------")
Observable.create { observer -> Disposable in
    observer.onNext(1)
    observer.onCompleted()
    observer.onNext(2)
    return Disposables.create()
}.subscribe {
    print($0)
}.disposed(by: disposeBag)

print("\n-----error------")
enum MyError: Error {
    case anError
}

Observable<Int>.create { observer -> Disposable in
    observer.onNext(1)
    observer.onError(MyError.anError)
    observer.onCompleted()
    observer.onNext(2)
    return Disposables.create()
}.subscribe(
    onNext: {
        print($0)
    },
    onError: {
        print($0.localizedDescription)
    },
    onCompleted: {
        print("onCompleted")
    },
    onDisposed: {
        print("dispose")
    }
).disposed(by: disposeBag)

print("\n-----deffered------")
Observable.deferred {
    Observable.of(1,2,3)
}.subscribe {
    print($0)
}.disposed(by: disposeBag)

print("\n-----deffered2------")
var 뒤집기 : Bool = false

let factory : Observable<String> = Observable.deferred {
    뒤집기 = !뒤집기
    
    if 뒤집기 {
        return Observable.of("🖕")
    } else {
        return Observable.of("👇")
    }
}

for _ in 0...3 {
    factory.subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)
}
