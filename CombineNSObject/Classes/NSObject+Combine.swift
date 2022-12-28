//
//  NSObject+Combine.swift
//
//  Created by Duc on 22/7/2021.
//

import Combine
import Foundation

private class Wrapper {
    var cancellables: Set<AnyCancellable>

    init(_ cancellables: Set<AnyCancellable>) {
        self.cancellables = cancellables
    }
}

public extension NSObject {
    private enum AssociatedKeys {
        static var cancellables = "cancellables"
    }

    private func synchronizedBag<T>(_ action: () -> T) -> T {
        objc_sync_enter(self)
        let result = action()
        objc_sync_exit(self)
        return result
    }

    var cancellables: Set<AnyCancellable> {
        get {
            synchronizedBag {
                if let disposeObject = objc_getAssociatedObject(self, &AssociatedKeys.cancellables) as? Wrapper {
                    return disposeObject.cancellables
                }
                let disposeObject = Wrapper(Set<AnyCancellable>())
                objc_setAssociatedObject(self, &AssociatedKeys.cancellables, disposeObject, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
                return disposeObject.cancellables
            }
        }

        set {
            synchronizedBag {
                objc_setAssociatedObject(self, &AssociatedKeys.cancellables, Wrapper(newValue), .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            }
        }
    }
}
