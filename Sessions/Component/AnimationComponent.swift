//
//  AnimationComponent.swift
//  game-tutorial
//
//  Created by Endrew Soares on 16/10/25.
//
import Foundation
import GameplayKit
import SpriteKit

class AnimationComponent: GKComponent {
    var idleAction: SKAction
    var spinAction: SKAction
    
    var node: SKNode?
    var isRun = false

    init(idleAction: SKAction, spinAction: SKAction) {
        self.idleAction = idleAction
        self.spinAction = spinAction
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func didAddToEntity() {
        node = entity?.component(ofType: GKSKNodeComponent.self)?.node
        playIdle()
    }
    
    public func playIdle() {
        node?.run(idleAction)
        isRun = false
    }
    
    public func playRun() {
        
        if !isRun {
            node?.run(spinAction)
        }
        
        isRun = true
    }
    
    
}
