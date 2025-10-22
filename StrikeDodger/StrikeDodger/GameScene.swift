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
    
    private var entityManager: EntityManager?
    private var background: SKSpriteNode!
    private var playerEntity: PlayerEntity?
    private var scoreLabel: SKLabelNode!
    
    private var isGameOver: Bool = false {
        didSet {
            gameOver()
        }
    }
    
    private var score: Int = 0 {
        didSet {
            self.scoreLabel?.text = "Score: \(score)"
        }
    }

    override func sceneDidLoad() {
        self.entityManager = EntityManager(scene: self)
        
        self.background = SKSpriteNode(imageNamed: "Lane.png")
        background.name = "background"
        background.zPosition = -1
        background.size = self.size
        addChild(background)
        
        let playerEntity = PlayerEntity()
        self.playerEntity = playerEntity
        entityManager?.add(entity: playerEntity)
        
        self.scoreLabel = SKLabelNode(fontNamed: "AmericanTypeWriter-CondensedBold")
        scoreLabel.fontColor = .black
        scoreLabel.fontSize = 60
        scoreLabel.position.y = 500
        scoreLabel.name = "scoreLabel"
        addChild(scoreLabel)
        
        self.score = 0
        
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
        
        if currentTime - self.dropBallTime > 1 && !self.isGameOver {
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
        
        for node in children {
            if node.position.y < -850 {
                node.removeFromParent()
                self.score += 1
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
    
    func didBegin(_ contact: SKPhysicsContact) {
        let spriteA = contact.bodyA.node
        let spriteB = contact.bodyB.node
        
        print("spriteA = \(String(describing: spriteA?.name)) || spriteB = \(String(describing: spriteB?.name))")
        if spriteA?.name == "player" {
            if spriteB?.name == "ball" {
                print("Houve colisão!!!")
                self.isGameOver.toggle()
            }
        }
    }
    
    func gameOver() {
        isUserInteractionEnabled = false
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.7) {
            for node in self.children {
                if node.name == "scoreLabel" || node.name == "background" {continue}
                
                node.removeFromParent()
            }
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
            if let scene = GameScene(fileNamed: "GameScene") {
                scene.scaleMode = .aspectFill
                
                self.view?.presentScene(scene, transition: .fade(withDuration: 1.0))
            }
        }
        
    }
}
