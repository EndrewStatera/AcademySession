//
//  GameScene.swift
//  StrikeDodger
//
//  Created by João Pedro Teixeira de Carvalho on 21/10/25.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    private var lastUpdateTime : TimeInterval = 0
    private var dropBallTime: TimeInterval = 0
    
    var entityManager: EntityManager?
    var playerEntity: PlayerEntity?
    
    override func sceneDidLoad() {
        self.entityManager = EntityManager(scene: self)
        
        let playerEntity = PlayerEntity()
        self.playerEntity = playerEntity
        entityManager?.add(entity: playerEntity)
        
        let ball = BallEntity()
        entityManager?.add(entity: ball)
        
        
    }
    
    override func didMove(to view: SKView) {
           physicsWorld.gravity = CGVector(dx: 0, dy: -0.8)
           physicsWorld.contactDelegate = self
       }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        captureInput(touches)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        captureInput(touches)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        playerEntity?.movementComponent?.change(direction: .idle)
    }

    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        
        // Initialize _lastUpdateTime if it has not already been
        if (self.lastUpdateTime == 0) {
            self.lastUpdateTime = currentTime
        }
        
        if (currentTime - self.dropBallTime > 1) {
            let ball = BallEntity()
            self.entityManager?.add(entity: ball)
            dropBallTime = currentTime
        }
        
        // Calculate time since last update
        let dt = currentTime - self.lastUpdateTime
        
        // Update entities
        if let entities = entityManager?.entities {
            for entity in entities {
                entity.update(deltaTime: dt)
            }
        }
        
        
        self.lastUpdateTime = currentTime
    }
    
    func captureInput(_ touches: Set<UITouch>) {
        if let touch = touches.first {
            let location = touch.location(in: self)
            
            if location.x > 0 {
                playerEntity?.movementComponent?.change(direction: .right)
            } else {
                playerEntity?.movementComponent?.change(direction: .left)
            }
        }
    }
}
