//
//  SwiftUIView.swift
//  
//
//  Created by nura on 28/08/1444 AH.
//

import Foundation
import Fluent
import FluentPostgresDriver
struct CreateDesigns: Migration {
    func prepare(on database: Database) ->EventLoopFuture<Void> {
        return database.schema("designs")
            .id()
            .field("name", .string, .required)
            .field("info", .string, .required)
            .create()
    }
    
    func revert(on database: FluentKit.Database) -> NIOCore.EventLoopFuture<Void> {
        return database.schema("designs").delete()
    }
    
    
    
}
