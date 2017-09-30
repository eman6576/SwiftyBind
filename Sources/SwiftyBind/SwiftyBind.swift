//MIT License
//
//Copyright (c) 2017 Manny Guerrero
//
//Permission is hereby granted, free of charge, to any person obtaining a copy
//of this software and associated documentation files (the "Software"), to deal
//in the Software without restriction, including without limitation the rights
//to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//copies of the Software, and to permit persons to whom the Software is
//furnished to do so, subject to the following conditions:
//
//The above copyright notice and this permission notice shall be included in all
//copies or substantial portions of the Software.
//
//THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//SOFTWARE.

import Foundation

// MARK: - Typealias
public typealias Listener<T> = (T) -> Void
public typealias GetValueHandler<T> = () -> T
fileprivate typealias BindSingleHandler<T> = (Listener<T>?) -> Void
fileprivate typealias BindAndFireSingleHandler<T> = BindSingleHandler<T>

/// A struct representing public attributes and methods for accessing instances of `SwiftyBind`.
public struct SwiftyBindInterface<T> {
    
    // MARK: - Public Instance Attributes
    
    /// Returns the current value that was set.
    var value: T { return getValueHandler() }
    
    
    // MARK: - Private Instance Attributes
    
    /// Handler for getting the current value set.
    fileprivate let getValueHandler: GetValueHandler<T>
    
    /// Handler for when the value is set.
    fileprivate let bindHandler: BindSingleHandler<T>
    
    /// Handler for when the value is set and fires immediately.
    fileprivate let bindAndFireHandler: BindAndFireSingleHandler<T>
    
    
    // MARK: - Public Instance Methods
    
    /// Binds the listener for listening for changes to the value.
    ///
    /// - Parameter listener: A `Listener?` representing the closure that gets invoked when the value changes.
    public func bind(_ listener: Listener<T>?) {
        bindHandler(listener)
    }
    
    /// Binds the listener for listening for changes to the value. It immediately gets fired.
    ///
    /// - Parameter listener: A `Listener?` representing the closure that gets invoked when the value changes.
    public func bindAndFire(_ listener: Listener<T>?) {
        bindAndFireHandler(listener)
    }
}

/// Generic class for binding values and listening for value changes.
public final class SwiftyBind<T> {
    
    // MARK: - Public Instance Attributes
    
    /// The `SwiftyBindInterface` for registerting for value changes.
    private(set) var interface: SwiftyBindInterface<T>!
    
    /// The current value set.
    var value: T {
        didSet {
            listener?(value)
        }
    }
    
    
    // MARK: - Private Instance Attributes
    private var listener: Listener<T>?
    
    
    // MARK: - Initializers
    
    /// Initializes an instance of `DynamicBinder`.
    ///
    /// - Parameter value: A `T` representing the value to bind and listen for changes.
    public init(_ value: T) {
        self.value = value
        interface = SwiftyBindInterface(getValueHandler: { [weak self] in
            guard let strongSelf = self else { return value }
            return strongSelf.value
            }, bindHandler: { [weak self] (listener) in
                guard let strongSelf = self else { return }
                strongSelf.bind(listener)
            }, bindAndFireHandler: { [weak self] (listener) in
                guard let strongSelf = self else { return }
                strongSelf.bindAndFire(listener)
        })
    }
    
    
    // MARK: - Private Instance Methods
    
    /// Binds the listener for listening for changes to the value.
    ///
    /// - Parameter listener: A `Listener<T>?` representing the closure that gets invoked when the value
    ///                       changes.
    private func bind(_ listener: Listener<T>?) {
        self.listener = listener
    }
    
    /// Binds the listener for listening for changes to the value. It immediately gets fired.
    ///
    /// - Parameter listener: A `Listener<T>?` representing the closure that gets invoked when the value
    ///                       changes.
    private func bindAndFire(_ listener: Listener<T>?) {
        self.listener = listener
        self.listener?(value)
    }
}

