//
//  BallMovement.swift
//  StrikeDodger
//
//  Created by Endrew Soares on 22/10/25.
//
import GameplayKit
import SpriteKit

class BallMovement: GKComponent {
    
    var speed: CGFloat
    var node: SKNode?
    
    init(speed: CGFloat) {
        self.speed = speed
        super.init()
        
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func didAddToEntity() {
        self.node = entity?.component(ofType: GKSKNodeComponent.self)?.node
    }
    
    override func update(deltaTime seconds: TimeInterval) {
        node?.position.x += speed * CGFloat(seconds)
    }
    
    
}
