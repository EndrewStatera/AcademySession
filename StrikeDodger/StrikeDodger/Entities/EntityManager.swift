//
//  EntityManager.swift
//  StrikeDodger
//
//  Created by João Pedro Teixeira de Carvalho on 21/10/25.
//

import Foundation
import SpriteKit
import GameplayKit

class EntityManager {
    
    var entities = Set<GKEntity>()
    var scene: SKScene
    
    init(scene: SKScene) {
        self.scene = scene
    }
    
    func add(entity: GKEntity) {
        entities.insert(entity)
        
        if let node = entity.component(ofType: GKSKNodeComponent.self)?.node {
            scene.addChild(node)
        }
    }
}
