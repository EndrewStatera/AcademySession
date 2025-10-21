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
    
    var movement: MovementComponent? {
        return self.component(ofType: MovementComponent.self)
    }
    
    override init() {
        
        let node = SKSpriteNode(color: .blue, size: CGSize(width: 20, height: 20))
        node.name = "Player"
        self.node = node
        
        super.init()
        self.addComponent(GKSKNodeComponent(node: node))

        let movement = MovementComponent(speed: 5)
        self.addComponent(movement)

        movement.node = node

        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
