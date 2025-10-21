//
//  EntityManager.swift
//  Sessions
//
//  Created by Endrew Soares on 20/10/25.

import GameplayKit
class EntityManager {
    
    var entities = Set<GKEntity>()
    var scene: GameScene
    
    
    init(scene: GameScene) {
        self.entities = []
        self.scene = scene
    }
    
    func add(_ entity: GKEntity) {
        entities.insert(entity)
        if let node = entity.component(ofType: GKSKNodeComponent.self)?.node {
            scene.addChild(node)
        }
    }
    
    func remove(_ entity: GKEntity) {
        entities.remove(entity)
    }
    
    
}
