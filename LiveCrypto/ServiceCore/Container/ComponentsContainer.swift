//
//  ComponentsContainer.swift
//  LiveCrypto
//
//  Created by Salvatore Raso on 15/02/24.
//

import Foundation

public final class ComponentsContainer {
    var components = [String: Any]()
    
    public init() {}
}

// MARK: - Private

private extension ComponentsContainer {
    func internalResolve<T>(for key: String) throws -> T {
        guard let component = components[key] else {
            throw ContainerError.componentNotFound
        }
        
        if let factory = component as? Factory<T> {
            return try factory(self)
        }
        
        guard let result = component as? T else {
            throw ContainerError.cantCreateComponent
        }
        
        return result
    }
}

// MARK: - Container

extension ComponentsContainer: Container {
    public func register<T>(type: T.Type, instance: T) {
        register(key: "\(type)", instance: instance)
    }
    
    public func register<T>(type: T.Type, factory: @escaping Factory<T>) {
        components["\(type)"] = factory
    }
    
    public func register<T>(key: String, instance: T) {
        components[key] = instance
    }
    
    public func register<T>(key: String, factory: @escaping (Container) throws -> T) {
        components[key] = factory
    }
    
    public func resolve<T>(key: String) throws -> T {
        try internalResolve(for: key)
    }
    
    public func resolve<T>(type: T.Type) -> T? {
        do {
            return try resolve(key: "\(type)")
        } catch {
            return nil
        }
    }
}


