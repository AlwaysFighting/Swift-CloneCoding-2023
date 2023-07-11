import RxSwift

let disposeBag = DisposeBag()

enum TraitsError: Error {
    case single
    case maybe
    case completable
}

print("----Single1----")
Single<String>.just("✅")
    .subscribe(
        onSuccess: {
            print($0)
        },
        onFailure: { _ in
            print("Error")
        },
        onDisposed: {
            print("Disposed")
        }
    ).disposed(by: disposeBag)

print("\n----Single2----")
Observable<String>
    .create { observer -> Disposable in
        observer.onError(TraitsError.single)
        return Disposables.create()
    }
    .asSingle()
    .subscribe(
        onSuccess: {
            print($0)
        },
        onFailure: {
            print("Error: \($0.localizedDescription)")
        },
        onDisposed: {
            print("dispose")
        }
    ).disposed(by: disposeBag)

print("\n----Single3----")
struct SomeJSON: Decodable {
    let name : String
}

enum JSONError: Error {
    case decodingError
}

let json1 = """
    {"name":"Mok"}
"""
let json2 = """
    {"my_name":"jeongah"}
"""

func decode(json: String) -> Single<SomeJSON> {
    Single<SomeJSON>.create { observer -> Disposable in
        guard let data = json.data(using: .utf8),
              let json = try? JSONDecoder().decode(SomeJSON.self, from: data)
        else {
            observer(.failure(JSONError.decodingError))
            return Disposables.create()
        }
        
        observer(.success(json))
        return Disposables.create()
    }
}

decode(json: json1)
    .subscribe {
        switch $0 {
        case .success(let json) :
            print(json.name)
        case .failure(let error):
            print(error)
        }
    }.disposed(by: disposeBag)

print("\n----Maybe1----")
Maybe<String>.just("✅")
    .subscribe(
        onSuccess: {
            print($0)
        },
        onError: {
            print("ERROR: \($0)")
        },
        onCompleted: {
            print("completed")
        },
        onDisposed: {
            print("dispose")
        }
    ).disposed(by: disposeBag)


print("\n----Maybe2----")
let t = Observable<String>.create { observer -> Disposable in
    observer.onError(TraitsError.maybe)
    return Disposables.create()
}.asMaybe()
    .subscribe(
        onSuccess: {
            print($0)
        },
        onError: {
            print("ERROR : \($0)")
        },
        onCompleted: {
            print("completed")
        },
        onDisposed: {
            print("dispose")
        }
    ).disposed(by: disposeBag)

print("\n----Completable1----")
Completable.create { observer -> Disposable in
    observer(.error(TraitsError.completable))
    return Disposables.create()
}.subscribe(
    onCompleted: {
        print("Completed")
    },
    onError: {
        print("Error: \($0)")
    },
    onDisposed: {
        print("onDisposed")
    }
).disposed(by: disposeBag)

print("\n----Completable2----")
Completable.create { observer -> Disposable in
    observer(.completed)
    return Disposables.create()
}.subscribe {
    print($0)
}.disposed(by: disposeBag)
