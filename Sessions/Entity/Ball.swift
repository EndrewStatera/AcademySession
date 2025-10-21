//
//  FallingObjects.swift
//  Sessions
//
//  Created by Endrew Soares on 20/10/25.
//

import GameplayKit
import SpriteKit

class Ball: GKEntity {
    
    let size: CGSize = .init(width: 20, height: 20)
    
    var movement: BallMovementComponent? {
        return self.component(ofType: BallMovementComponent.self)
    }
    
    override init() {
        super.init()
        
        let node = SKSpriteNode(color: .red, size: size)
        node.name = "Ball"
        
        node.anchorPoint.y = -30
        node.anchorPoint.x = randomX()
        self.addComponent(GKSKNodeComponent(node: node))

        let movement = MovementComponent(speed: 5)
        self.addComponent(movement)

        movement.node = node

        node.physicsBody = SKPhysicsBody(rectangleOf: node.size)
        //node.physicsBody?.isDynamic = true
        
    }
    func randomX() -> CGFloat {
        CGFloat.random(in: -12...12)
    }
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
