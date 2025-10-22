//
//  BallEntoty.swift
//  StrikeDodger
//
//  Created by Endrew Soares on 22/10/25.
//
import GameplayKit
import SpriteKit


class BallEntity: GKEntity {
    
    let size: CGSize = .init(width: 20, height: 20)

    override init() {
        super.init()
        
        let node = SKSpriteNode(imageNamed: "Ball1")
        node.position = CGPoint(x: randomX(), y: 800)
        
        node.name = "ball"
        node.texture?.filteringMode = .nearest
        
        node.physicsBody = SKPhysicsBody(rectangleOf: size)
        node.physicsBody?.isDynamic = true
        node.physicsBody?.affectedByGravity = true
        node.physicsBody?.categoryBitMask = PhysicsCategory.ball
        node.physicsBody?.contactTestBitMask = PhysicsCategory.player
        
        node.setScale(5)

        
        self.addComponent(GKSKNodeComponent(node: node))
        
        let animationComponent = AnimationComponent(spinAction: .repeatForever(.animate(with: Array.init(withFormat: "Ball%@.png", range: 1...9), timePerFrame: 0.1)))
        self.addComponent(animationComponent)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func randomX() -> CGFloat {
        CGFloat.random(in: -250...250)
    }
}
