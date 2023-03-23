//
//  SwiftUIView.swift
//  
//
//  Created by nura on 28/08/1444 AH.
//

import Fluent
import Vapor

struct DesignsControllr: RouteCollection {
    func boot(routes: RoutesBuilder) throws {
        let designs = routes.grouped("designs")
        designs.get(use: index)
        designs.get(":designsID",use: getid)
        designs.post(use: create)
        designs.put(":designsID",use: update)
        designs.delete(":designsID",use: delete(req:))
    }
    

    func index(req: Request) async throws -> [Designs] {
        try await Designs.query(on: req.db).all()
    }
    
    

    func create(req: Request) async throws -> Designs {
        let designs = try req.content.decode(Designs.self)
        try await designs.save(on: req.db)
        return designs
    }

    
    func delete(req: Request) async throws -> HTTPStatus {
    guard let designs = try await Designs.find(req.parameters.get("designsID"), on: req.db) else {
    throw Abort(.notFound)
    }
    try await designs.delete(on: req.db)
    return .noContent
    }
    
    // update using specific id
    func update(req: Request) async throws -> HTTPStatus {
    let designes = try req.content.decode(Designs.self)
    guard let des = try await Designs.find(designes.id,on: req.db) else {
    throw Abort(.notFound)
    }
    des.name = designes.name
    des.info = designes.info
    des.t_collection = designes.t_collection
    des.photo = designes.photo
    try await des.save(on:req.db)
    return .ok

    }
    func getid(req: Request) async throws -> Designs {
    guard let designs = try await Designs.find(req.parameters.get("designsID"), on: req.db) else {
    throw Abort(.notFound)
    }
    return designs
    }
}
