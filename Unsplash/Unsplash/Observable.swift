//
//  Observable.swift
//  Unsplash
//
//  Created by Ion Belous on 10.10.2023.
//

final class Observable<T> {
    
    init(_ value: T) {
        self.value = value
    }
    
    var value: T {
        didSet {
            listener?(value)
        }
    }
    
    private var listener: ((T) -> Void)?
    
    func bind(fire: Bool, _ closure: @escaping (T) -> Void) {
        if fire {
            closure(value)
        }
        listener = closure
    }
}
