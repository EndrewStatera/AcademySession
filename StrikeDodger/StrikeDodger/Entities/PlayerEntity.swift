//
//  PlayerEntity.swift
//  StrikeDodger
//
//  Created by João Pedro Teixeira de Carvalho on 21/10/25.
//

import Foundation
import SpriteKit
import GameplayKit

class PlayerEntity: GKEntity {
    
    var movementComponent: MovementComponent? {
        self.component(ofType: MovementComponent.self)
    }
    
    override init() {
        super.init()
        
        let node = SKSpriteNode(color: .blue, size: .init(width: 100, height: 100))
        node.position.y = -300
        self.addComponent(GKSKNodeComponent(node: node))
        
        let movementComponent = MovementComponent(speed: 5)
        self.addComponent(movementComponent)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
