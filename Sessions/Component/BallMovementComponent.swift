//
//  BallMovementComponent.swift
//  Sessions
//
//  Created by Endrew Soares on 20/10/25.
//

import GameplayKit

class BallMovementComponent: GKComponent {
    
    var speed: CGFloat
    var node: SKNode?
    
    init(speed: CGFloat) {
        self.speed = speed
        super.init()
    }
    
    override func didAddToEntity() {
        self.node = entity?.component(ofType: GKSKNodeComponent.self)?.node
    }
    
    override func update(deltaTime seconds: TimeInterval) {
        node?.position.y -= speed
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
