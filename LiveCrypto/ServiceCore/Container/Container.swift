//
//  Container.swift
//  LiveCrypto
//
//  Created by Salvatore Raso on 15/02/24.
//

import Foundation

/// Dependency Injection Container
/// Responsible for recording, deciding, and settling all the dependencies.
/// The DI container needs to know about the constructor arguments and the relationships between the objects.
/// T is -usually- a Service (Check Core class)
public protocol Container: AnyObject {
    typealias Factory<T> = (Container) throws -> T
    
    func register<T>(key: String, instance: T)
    func register<T>(key: String, factory: @escaping Factory<T>)
    
    func register<T>(type: T.Type, instance: T)
    func register<T>(type: T.Type, factory: @escaping Factory<T>)
    
    // func resolve<T>() throws -> T
    func resolve<T>(key: String) throws -> T
    func resolve<T>(type: T.Type) -> T?
}

public enum ContainerError: Swift.Error {
    case componentNotFound
    case cantCreateComponent
}
