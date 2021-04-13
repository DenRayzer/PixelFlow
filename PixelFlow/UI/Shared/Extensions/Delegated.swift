//
//  Delegated.swift
//  PixelFlow
//
//  Created by Елизавета on 11.04.2021.
//

import Foundation

class Delegated<Input, Output> {
    private(set) var callBack: ((Input) -> Output?)?

    func delegate<Target: AnyObject>(to target: Target, with callback: @escaping (Target, Input) -> Output) {
        self.callBack = { [weak target] input in
            guard let target = target else { return nil }
            return callback(target, input)
        }
    }

    func call(_ input: Input) -> Output? {
        callBack?(input)
    }

    var isDelegateSet: Bool {
        callBack != nil
    }
}

extension Delegated where Input == Void {
    func delegate<Target: AnyObject>(to target: Target, with callback: @escaping (Target) -> Output) {
        delegate(to: target, with: { target, _ in callback(target) })

        func call(_ input: Input) -> Output? {
            self.call(())
        }
    }
}

extension Delegated where Input == Void, Output == Void {
    func call() {
        self.call(())
    }
}
