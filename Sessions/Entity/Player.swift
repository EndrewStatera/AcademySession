//
//  Player.swift
//  Sessions
//
//  Created by Endrew Soares on 20/10/25.
//
import GameplayKit
import SpriteKit

class Player: GKEntity {
    
    var node: SKNode
    var size: CGSize = CGSize(width: 20, height: 20)
    
    var movement: MovementComponent? {
        return self.component(ofType: MovementComponent.self)
    }
    
    override init() {
        
        let node = SKSpriteNode(imageNamed: "player.png")
        node.name = "Player"
        node.setScale(5)
        node.texture?.filteringMode = .nearest
        node.position.y = -400
        self.node = node
        
        super.init()
        self.addComponent(GKSKNodeComponent(node: node))

        let movement = MovementComponent(speed: 5)
        self.addComponent(movement)

        movement.node = node
        
        node.physicsBody = SKPhysicsBody(rectangleOf: self.size)
        node.physicsBody?.affectedByGravity = false
        node.physicsBody?.isDynamic = true
        node.physicsBody?.categoryBitMask = PhysicsCategory.player
        node.physicsBody?.contactTestBitMask = PhysicsCategory.ball
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
