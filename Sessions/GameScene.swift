//
//  GameScene.swift
//  Sessions
//
//  Created by Endrew Soares on 20/10/25.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    private var lastUpdateTime : TimeInterval = 0
    private var entityManager: EntityManager?
    private var player: Player?
    private var balls: [Ball] = []
    private var dropNewBallTime: TimeInterval = 0
    var scoreLabel: SKLabelNode!
    var isGameOver = false {
        didSet {
            gameOver()
        }
     }
    
    var score: Int = 0
    {
        didSet {
            scoreLabel.text = "Score: \(score)"
        }
    }
    
    
    
    override func sceneDidLoad() {
        
        let background = SKSpriteNode(imageNamed: "Lane.png")
        background.name = "background"
        background.zPosition = -1
        background.size = self.size
        addChild(background)
        
            
        self.entityManager = EntityManager(scene: self)
        let player = Player()
        self.player = player
        
        entityManager!.add(player)
        self.lastUpdateTime = 0
        
        
        self.scoreLabel = SKLabelNode(fontNamed: "AmericanTypeWriter-CondensedBold")
        scoreLabel.fontColor = .white
        scoreLabel.fontSize = 60
        scoreLabel.position.y = 500
        scoreLabel.name = "scoreLabel"
        scoreLabel.fontColor = .black

        addChild(scoreLabel)
        
        
        score = 0
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        captureInput(touches)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.player?.movement?.changeDirection(.idle)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        captureInput(touches)
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        
        // Initialize _lastUpdateTime if it has not already been
        if (self.lastUpdateTime == 0) {
            self.lastUpdateTime = currentTime
        }
        
        // Calculate time since last update
        let dt = currentTime - self.lastUpdateTime
        if let entities = entityManager?.entities {
            for entity in entities {
                entity.update(deltaTime: dt)
            }
        }
        
        if currentTime - dropNewBallTime > 1 && !self.isGameOver {
            let ball = Ball()
            entityManager!.add(ball)
            balls.append(ball)
            dropNewBallTime = currentTime
        }
        
        for node in children {
            if node.position.y < -850 {
                node.removeFromParent()
                self.score += 1
            }
        }
        
        // Update entities
        
        self.lastUpdateTime = currentTime
    }
    
    override func didMove(to view: SKView) {
        physicsWorld.gravity = CGVector(dx: 0, dy: -0.8)
        physicsWorld.contactDelegate = self
    }
    
    func captureInput(_ touches: Set<UITouch>) {
        if let touch = touches.first {
            let position = touch.location(in: self)
            if position.x > 0 {
                self.player?.movement?.changeDirection(.right)
            } else {
                self.player?.movement?.changeDirection(.left)
            }
        }
    }
    
    func randomX() -> CGFloat {
        CGFloat.random(in: -self.size.width/2...self.size.width/2)
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        
        let spriteA = contact.bodyA.node
        let spriteB = contact.bodyB.node
        if spriteA?.name == "Player" {
            if spriteB?.name == "Ball" {
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
        
//        scoreLabel.removeFromParent()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
            if let scene = GameScene(fileNamed: "GameScene") {
                scene.scaleMode = .aspectFill
                
                self.view?.presentScene(scene, transition: .fade(withDuration: 1.0))
            }
        }
    }
}
