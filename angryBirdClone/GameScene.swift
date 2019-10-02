//
//  GameScene.swift
//  angryBirdClone
//
//  Created by Tutku Bide on 11.07.2019.
//  Copyright © 2019 Tutku Bide. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene,SKPhysicsContactDelegate {
    // var bird2 = SKSpriteNode() ////  kusu olusturmak -1-
    var bird = SKSpriteNode()
    var box = SKSpriteNode()
    var box2 = SKSpriteNode()
    var box3 = SKSpriteNode()
    var box4 = SKSpriteNode()
    var box5 = SKSpriteNode()
    var gameStarted = false
    var originalPosition : CGPoint!
    var scoreLabel = SKLabelNode()
    var score = 0
    enum ColliderType:UInt32 {
        case Bird = 1
        case Box = 2
        
        
    }
    
    override func didMove(to view: SKView) {
       
        physicsBody = SKPhysicsBody.init(edgeLoopFrom: frame) /// ekrana düşüyor bird
        physicsWorld.contactDelegate = self
        ////BİRD SETTİNGS//
        
        let birdTexture = SKTexture(imageNamed: "bird.png") /// texture resim demek burada texture ulasıyoz
        bird = childNode(withName: "bird") as! SKSpriteNode //// name yerinde yazan yere ulaşıyoruz
        bird.physicsBody = SKPhysicsBody(circleOfRadius: birdTexture.size().height / 7) //fiziği
        bird.physicsBody?.isDynamic = true ///fizik etrafındaki çember görünür
        bird.physicsBody?.mass = 0.1 //// kütlesi
        bird.physicsBody?.affectedByGravity = false /// yerçekimi etkisi
        originalPosition = bird.position
        bird.physicsBody!.contactTestBitMask = ColliderType.Bird.rawValue
        bird.physicsBody!.categoryBitMask = ColliderType.Bird.rawValue
        bird.physicsBody!.collisionBitMask = ColliderType.Box.rawValue
        
        ///BOX SETTİNGS///
        
        let boxTexture = SKTexture(imageNamed: "box.png")
        let size = CGSize(width: boxTexture.size().width / 5, height: boxTexture.size().height / 5)
        
        box = childNode(withName: "box") as! SKSpriteNode
        box.physicsBody = SKPhysicsBody(rectangleOf: size)
        box.physicsBody?.isDynamic = true
        box.physicsBody?.affectedByGravity = true
        box.physicsBody?.allowsRotation = true
        
        box.physicsBody!.collisionBitMask = ColliderType.Bird.rawValue
        
        box2 = childNode(withName: "box2") as! SKSpriteNode
        box2.physicsBody = SKPhysicsBody(rectangleOf: size)
        box2.physicsBody?.isDynamic = true
        box2.physicsBody?.affectedByGravity = true
         box2.physicsBody?.allowsRotation = true
        
        box2.physicsBody!.collisionBitMask = ColliderType.Bird.rawValue
        
        box3 = childNode(withName: "box3") as! SKSpriteNode
        box3.physicsBody = SKPhysicsBody(rectangleOf: size)
        box3.physicsBody?.isDynamic = true
        box3.physicsBody?.affectedByGravity = true
        box3.physicsBody?.allowsRotation = true
        
        box3.physicsBody!.collisionBitMask = ColliderType.Bird.rawValue
        
        box4 = childNode(withName: "box4") as! SKSpriteNode
        box4.physicsBody = SKPhysicsBody(rectangleOf: size)
        box4.physicsBody?.isDynamic = true
        box4.physicsBody?.affectedByGravity = true
        box4.physicsBody?.allowsRotation = true
        
        box4.physicsBody!.collisionBitMask = ColliderType.Bird.rawValue
        
        box5 = childNode(withName: "box5") as! SKSpriteNode
        box5.physicsBody = SKPhysicsBody(rectangleOf: size)
        box5.physicsBody?.isDynamic = true
        box5.physicsBody?.affectedByGravity = true
        box5.physicsBody?.allowsRotation = true
        box5.physicsBody!.collisionBitMask = ColliderType.Bird.rawValue
        
        
        scoreLabel.fontName = "Plain"
        scoreLabel.fontColor = UIColor.blue
        scoreLabel.fontSize = 55
        scoreLabel.text = "Score: 0"
        scoreLabel.position = CGPoint(x: 10, y: self.frame.height / 4)
        self.addChild(scoreLabel)
        
        /*
        let texture2 = SKTexture(imageNamed: "bird.png") //// kusun resmi
        bird2 = SKSpriteNode(texture: texture2) ////resimle eşledik
        bird2.position = CGPoint(x: 0, y: 0) /// kusun anchora göre pozisyonu
        bird2.size = CGSize(width: self.frame.width / 13 , height: self.frame.height / 10)
        bird2.zPosition = 2 ///simulasyon ön plana çıkarma
        self.addChild(bird2) /// son dokunus
        */
        
       
        }
    
    func didBegin(_ contact: SKPhysicsContact) {
        if contact.bodyB.collisionBitMask == ColliderType.Bird.rawValue ||
            contact.bodyA.collisionBitMask == ColliderType.Bird.rawValue {
            score = score + 1
            scoreLabel.text = "Score: \(score)"
            
            
            
            
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
       
        
        // first olarak ilk dokunulanı if let ile yap.dokunulan konumu al nodesi locations eşitle
        if gameStarted == false {
            if let touch = touches.first {
                let touchLocation = touch.location(in: self)
                let touchNodes = nodes(at: touchLocation)
                if touchNodes.isEmpty == false {
                    for node in touchNodes {
                        if let sprite = node as? SKSpriteNode {
                            if sprite  == bird {
                                bird.position  = touchLocation
                                
                                
                            }
                        }
                    }
                }
            }
        }
        
        
        
        ///bird.physicsBody?.applyImpulse(CGVector(dx: 50, dy: 120))
        ///bird.physicsBody?.affectedByGravity = true
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if gameStarted == false {
            if let touch = touches.first {
                let touchLocation = touch.location(in: self)
                let touchNodes = nodes(at: touchLocation)
                if touchNodes.isEmpty == false {
                    for node in touchNodes {
                        if let sprite = node as? SKSpriteNode {
                            if sprite  == bird {
                                bird.position  = touchLocation
                                
                                
                            }
                        }
                    }
                }
            }
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if gameStarted == false {
            if let touch = touches.first {
                let touchLocation = touch.location(in: self)
                let touchNodes = nodes(at: touchLocation)
                if touchNodes.isEmpty == false {
                    for node in touchNodes {
                        if let sprite = node as? SKSpriteNode {
                            if sprite  == bird {
                                let dx = -(touchLocation.x - originalPosition.x)
                                let dy = -(touchLocation.y - originalPosition.y)
                                let impulse = CGVector(dx: dx, dy: dy)
                                bird.physicsBody?.applyImpulse(impulse)
                                bird.physicsBody?.affectedByGravity = true
                                gameStarted = true
                                
                            }
                        }
                    }
                }
            }
        }
    }
    override func update(_ currentTime: TimeInterval) {
        if let birdPhysicsBody = bird.physicsBody {
            if birdPhysicsBody.velocity.dx <= 0.1 && birdPhysicsBody.velocity.dy <= 0.1 && birdPhysicsBody.angularVelocity <= 0.1 && gameStarted == true {
                
                bird.physicsBody?.affectedByGravity = false
                bird.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
                bird.physicsBody?.angularVelocity = 0
                bird.zPosition = 0
                bird.position = originalPosition
                score = 0
                scoreLabel.text = "Score: \(score)"
                
                
                
                
                gameStarted = false
                
            }
            
        }
    }
    
    }
    
    
       



