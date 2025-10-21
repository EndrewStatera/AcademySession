//
//  MovementComponent.swift
//  Sessions
//
//  Created by Endrew Soares on 20/10/25.
//

import GameplayKit
import Foundation

class MovementComponent: GKComponent {
    
    var speed: CGFloat
    var node: SKNode?
    var direction: Direction = .idle
    
    var minX: CGFloat = 0
    var maxX: CGFloat = 0

    init(speed: CGFloat) {
        self.speed = speed
        super.init()
    }
    
    override func didAddToEntity() {
        self.node = entity?.component(ofType: GKSKNodeComponent.self)?.node
    }
    
    override func update(deltaTime seconds: TimeInterval) {
        
        node?.position.x += direction.rawValue * speed
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func changeDirection(_ newDirection: Direction) {
        self.direction = newDirection
    }
    
}

enum Direction: CGFloat {
    case idle = 0
    case left = -1
    case right = 1
}
