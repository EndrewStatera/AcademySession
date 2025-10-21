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
        
        let node = SKSpriteNode(imageNamed: "BallSpritesheet1.png")
        node.name = "Ball"
        node.setScale(5)
        node.texture?.filteringMode = .nearest
        
        //node.anchorPoint.y = -30
        //node.anchorPoint.x = randomX()
        node.position = CGPoint(x: randomX(), y: 800)
        self.addComponent(GKSKNodeComponent(node: node))

        let animationComp = AnimationComponent(idleAction: .repeatForever(.animate(with: Array.init(withFormat: "BallSpritesheet%@.png", range: 1...9), timePerFrame: 0.1)), spinAction: .repeatForever(.animate(with: .init(withFormat: "Ball%@.png", range: 1...9), timePerFrame: 0.1)))
        self.addComponent(animationComp)

        let movement = MovementComponent(speed: 5)
        self.addComponent(movement)

        movement.node = node

        node.physicsBody = SKPhysicsBody(rectangleOf: node.size)
        node.physicsBody?.affectedByGravity = true
        node.physicsBody?.isDynamic = true
        node.physicsBody?.categoryBitMask = PhysicsCategory.ball
        node.physicsBody?.contactTestBitMask = PhysicsCategory.player

    }
    func randomX() -> CGFloat {
        CGFloat.random(in: -250...250)
    }
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
