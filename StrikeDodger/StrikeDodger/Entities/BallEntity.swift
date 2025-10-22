//
//  BallEntoty.swift
//  StrikeDodger
//
//  Created by Endrew Soares on 22/10/25.
//
import GameplayKit
import SpriteKit


class BallEntity: GKEntity {
    
    override init() {
        super.init()
        
        let node = SKSpriteNode(color: .red, size: CGSize(width: 50, height: 50 ))
        node.position = CGPoint(x: randomX(), y: 800)
        
        node.name = "ball"
        
        node.physicsBody = SKPhysicsBody(rectangleOf: node.size)
        node.physicsBody?.isDynamic = true
        node.physicsBody?.affectedByGravity = true
        node.physicsBody?.categoryBitMask = PhysicsCategory.ball
        node.physicsBody?.contactTestBitMask = PhysicsCategory.player
        
        self.addComponent(GKSKNodeComponent(node: node))

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func randomX() -> CGFloat {
        CGFloat.random(in: -250...250)
    }
}
