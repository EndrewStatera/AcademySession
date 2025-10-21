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
    var livesLabel: SKLabelNode!
    
    var lives: Int = 5
    {
        didSet {
            livesLabel.text = "Lives: \(lives)"
        }
    }
    
    
    
    override func sceneDidLoad() {
        
        //physicsWorld.contactDelegate = self
        
        self.entityManager = EntityManager(scene: self)
        let player = Player()
        self.player = player
        
        entityManager!.add(player)
        self.lastUpdateTime = 0
        
        let ball = Ball()
        entityManager!.add(ball)
        
        self.livesLabel = SKLabelNode(fontNamed: "AmericanTypeWriter-CondensedLight")
        livesLabel.fontColor = .white
        livesLabel.fontSize = 50
        livesLabel.position.y = 300
        livesLabel.name = "livesLabel"
        addChild(livesLabel)
        
        lives = 5
        balls.append(ball)
        
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
        
        if currentTime - dropNewBallTime > 1 {
            let ball = Ball()
            entityManager!.add(ball)
            balls.append(ball)
            dropNewBallTime = currentTime
        }
        
        for node in children {
            if node.position.y < -1400 {
                node.removeFromParent()
            }
            
            if node.name == "Ball" && self.player!.node.position.y == node.position.y && self.player!.node.position.y == node.position.x {
                //lives = lives
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
        //        let spriteA = contact.bodyA.node as! SKSpriteNode
        //        let spriteB = contact.bodyB.node as! SKSpriteNode
        
        let spriteA = contact.bodyA.node
        let spriteB = contact.bodyB.node
        print("Collision \(spriteA?.name) and \(spriteB?.name)")
        if spriteA?.name == "Player" {
            if spriteB?.name == "Ball" {
                self.lives -= 1
                spriteB?.removeFromParent()
            }
            if spriteB?.name == "playerBullet" {
                spriteB?.removeFromParent()
            }
            if spriteB?.name == "enemyBullet" {
                spriteB?.removeFromParent()
            }
        }
        
        //        let categories = contact.bodyA.categoryBitMask | contact.bodyB.categoryBitMask
        //
        //            if categories == PhysicsCategory.player | PhysicsCategory.ball {
        //                print("💥 Player hit ball!")
        //                lives -= 1
        //            }
    }
}
