//
//  PlayerEntity.swift
//  StrikeDodger
//
//  Created by João Pedro Teixeira de Carvalho on 21/10/25.
//

import Foundation
import SpriteKit
import GameplayKit

class PlayerEntity: GKEntity {
    
    var movementComponent: MovementComponent? {
        self.component(ofType: MovementComponent.self)
    }
    var size: CGSize = CGSize(width: 20, height: 20)
    
    override init() {
        super.init()
        
        let node = SKSpriteNode(imageNamed: "player")
        node.texture?.filteringMode = .nearest
        node.position.y = -300
        self.addComponent(GKSKNodeComponent(node: node))
        
        let movementComponent = MovementComponent(speed: 5)
        self.addComponent(movementComponent)
        
        node.name = "player"
        
        node.physicsBody = SKPhysicsBody(rectangleOf: self.size)
        node.physicsBody?.affectedByGravity = false
        node.physicsBody?.isDynamic = true
        node.physicsBody?.categoryBitMask = PhysicsCategory.player
        node.physicsBody?.collisionBitMask = PhysicsCategory.ball
        
        node.setScale(5)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
