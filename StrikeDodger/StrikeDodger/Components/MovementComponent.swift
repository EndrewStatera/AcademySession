//
//  MovementComponent.swift
//  StrikeDodger
//
//  Created by João Pedro Teixeira de Carvalho on 21/10/25.
//

import Foundation
import SpriteKit
import GameplayKit

class MovementComponent: GKComponent {
    
    enum Direction: CGFloat {
        case right = 1
        case left = -1
        case idle = 0
    }
    
    var speed: CGFloat
    var direction: Direction = .idle
    var node: SKNode?
    
    init(speed: CGFloat) {
        self.speed = speed
        super.init()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func didAddToEntity() {
        node = entity?.component(ofType: GKSKNodeComponent.self)?.node
    }
    
    override func update(deltaTime seconds: TimeInterval) {
        node?.position.x += speed * direction.rawValue
    }
    
    func change(direction: Direction) {
        self.direction = direction
    }
    
}
