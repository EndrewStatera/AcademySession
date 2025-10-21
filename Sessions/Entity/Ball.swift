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
        
        //node.anchorPoint.y = -30
        //node.anchorPoint.x = randomX()
        node.position = CGPoint(x: randomX(), y: 600)
        self.addComponent(GKSKNodeComponent(node: node))

        let movement = MovementComponent(speed: 5)
        self.addComponent(movement)

        movement.node = node

        node.physicsBody = SKPhysicsBody(rectangleOf: node.size)
        node.physicsBody?.affectedByGravity = true
        node.physicsBody?.isDynamic = true
        node.physicsBody?.categoryBitMask = PhysicsCategory.ball
        //node.physicsBody?.collisionBitMask = PhysicsCategory.player
        node.physicsBody?.contactTestBitMask = PhysicsCategory.player

    }
    func randomX() -> CGFloat {
        CGFloat.random(in: -300...300)
    }
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
