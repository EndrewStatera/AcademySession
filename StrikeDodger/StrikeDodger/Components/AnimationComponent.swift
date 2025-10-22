//
//  AnimationComponent.swift
//  StrikeDodger
//
//  Created by Endrew Soares on 22/10/25.
//
import GameplayKit
import SpriteKit

class AnimationComponent: GKComponent {
    var spinAction: SKAction
    
    var node: SKNode?
    
    init(spinAction: SKAction) {
        self.spinAction = spinAction
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func didAddToEntity() {
        node = entity?.component(ofType: GKSKNodeComponent.self)?.node
        playSpin()
    }
    
    public func playSpin() {
        node?.run(spinAction)
    }
    
    
}
