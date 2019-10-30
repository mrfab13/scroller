//
//  GameScene.swift
//  scroolgaem
//
//  Created by Vaughan Webb on 21/10/19.
//  Copyright © 2019 Vaughan Webb. All rights reserved.
//

import SpriteKit

extension Double
{
    var toString: String
    {
        return NSNumber(value: self).stringValue
    }
    
}

class GameScene1: SKScene, SKPhysicsContactDelegate
{
    //objects
    var label = SKLabelNode()
    let Node1 = SKShapeNode(circleOfRadius: 32)
    let Boundry = SKSpriteNode()

    let rectangle1 = SKSpriteNode()
    let rectangle2 = SKSpriteNode()
    let rectangle3 = SKSpriteNode()
    let rectangle4 = SKSpriteNode()
    var timerR1 = 0.0;
    var timerR2 = 0.0;
    var timerR3 = 0.0;
    var timerR4 = 0.0;
    var R1rand = 0.0;
    var R2rand = 0.0;
    var R3rand = 0.0;
    var R4rand = 0.0;

    


    //logic
    var pushup = false
    var kill = false
    var gamestate = 0 //0 playing, 1 win, 2 loss
    
    //cam
    var cameraNode: SKCameraNode!
    var timer = 0.0;



    
    enum CategoryBitMask
    {
        static let Node1: UInt32 = 0b0001
        static let obsticle: UInt32 = 0b0100
        static let boundry: UInt32 = 0b1000
    }
    
    override func didMove(to view: SKView)
    {
        Boundry.name = "ground"
        Boundry.color = UIColor.green
        Boundry.size = CGSize(width: self.frame.width - 10, height: 10)
        Boundry.position = CGPoint(x: self.frame.midX, y: self.frame.minY)
        Boundry.physicsBody = SKPhysicsBody(rectangleOf: Boundry.size)
        Boundry.physicsBody?.isDynamic = false
        Boundry.physicsBody?.categoryBitMask = CategoryBitMask.boundry
        addChild(Boundry)

        self.physicsWorld.contactDelegate = self
        
        createNode1()
        createobsticle(1)
        createobsticle(2)
        createobsticle(3)
        createobsticle(4)

        Createcam()
        createlabel()
 
    }
    
    override func update(_ seconds: TimeInterval)
    {
        if (gamestate == 0)
        {
            cameraNode.run(SKAction.move(to: CGPoint(x: self.frame.midX , y: Node1.position.y), duration: 0.5))
            timer = timer + (seconds / 2000000)
            let formatter = NumberFormatter()
            formatter.maximumFractionDigits = 3
            formatter.minimumFractionDigits = 3
            
            timerR1 = timerR1 + (seconds / 2000000);
            timerR2 = timerR2 + (seconds / 2000000);
            timerR3 = timerR3 + (seconds / 2000000);
            timerR4 = timerR4 + (seconds / 2000000);
            //rand from 1-4
            moveObsticles()
            
            let text = formatter.string(from: NSNumber(value: timer)) //"\(timer)"
            label.text = text
            if (pushup == true)
            {
                Node1.physicsBody?.velocity = CGVector(dx: 0, dy: 1200)
            }
            else
            {
                if((Node1.physicsBody?.velocity.dy)! > CGFloat(0.0))
                {
                    Node1.physicsBody?.velocity.dy = (Node1.physicsBody?.velocity.dy)! - CGFloat(500)
                }
            }
            
        }
        else if (gamestate == 2)
        {
            Node1.physicsBody?.velocity = CGVector(dx: -12000, dy: 0)
            print("left")
        }

    }
    
    func moveObsticles()
    {
        if (timerR1 > R1rand)
        {
            R1rand = Double.random(in: 2 ... 5)
            
        }
        

        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        pushup = true
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        pushup = false
    }
    
    func Createcam()
    {
        cameraNode = SKCameraNode()
        cameraNode.setScale(1)
        cameraNode.position = CGPoint(x: self.frame.midX, y: self.frame.midY)
        self.camera = cameraNode
        self.addChild(cameraNode)
        
    }
    
    func didBegin(_ contact: SKPhysicsContact)
    {
        print("hit")
        if (contact.bodyA.categoryBitMask | contact.bodyB.categoryBitMask == CategoryBitMask.Node1 | CategoryBitMask.obsticle)
        {
            print("node 1")
            kill = true
            gamestate = 2 //0 playing, 1 win, 2 loss
        }
    }
    
    
    func createNode1()
    {
        Node1.name = "one"
        Node1.fillColor = UIColor.blue
        Node1.position = CGPoint(x: self.frame.midX, y: self.frame.minY + 11)
        Node1.physicsBody = SKPhysicsBody(circleOfRadius: Node1.frame.width/2)
        Node1.physicsBody?.categoryBitMask = CategoryBitMask.Node1
        Node1.physicsBody?.contactTestBitMask = CategoryBitMask.boundry | CategoryBitMask.obsticle
        Node1.physicsBody?.collisionBitMask = CategoryBitMask.boundry | CategoryBitMask.obsticle
        
        addChild(Node1)
    }
    
    
    func createobsticle(_ number: Int)
    {
        if (number == 1)
        {
            rectangle1.name = "obsicle"
            rectangle1.color = UIColor.red
            rectangle1.size = CGSize(width: self.frame.width - 10, height: 10)
            rectangle1.position = CGPoint(x: self.frame.midX, y: (5 * self.frame.maxY/6))
            rectangle1.physicsBody = SKPhysicsBody(rectangleOf: rectangle1.size)
            rectangle1.physicsBody?.isDynamic = false
            rectangle1.physicsBody?.categoryBitMask = CategoryBitMask.obsticle
            addChild(rectangle1)
        }
        
        if (number == 2)
        {
            rectangle2.name = "obsicle"
            rectangle2.color = UIColor.red
            rectangle2.size = CGSize(width: self.frame.width - 10, height: 10)
            rectangle2.position = CGPoint(x: self.frame.midX, y: (4 * self.frame.maxY/6))
            rectangle2.physicsBody = SKPhysicsBody(rectangleOf: rectangle2.size)
            rectangle2.physicsBody?.isDynamic = false
            rectangle2.physicsBody?.categoryBitMask = CategoryBitMask.obsticle
            addChild(rectangle2)
        }
        
        if (number == 3)
        {
            rectangle3.name = "obsicle"
            rectangle3.color = UIColor.red
            rectangle3.size = CGSize(width: self.frame.width - 10, height: 10)
            rectangle3.position = CGPoint(x: self.frame.midX, y: (3 * self.frame.maxY/6))
            rectangle3.physicsBody = SKPhysicsBody(rectangleOf: rectangle3.size)
            rectangle3.physicsBody?.isDynamic = false
            rectangle3.physicsBody?.categoryBitMask = CategoryBitMask.obsticle
            addChild(rectangle3)
        }
        
        if (number == 4)
        {
            rectangle4.name = "obsicle"
            rectangle4.color = UIColor.red
            rectangle4.size = CGSize(width: self.frame.width - 10, height: 10)
            rectangle4.position = CGPoint(x: self.frame.midX, y: (2 * self.frame.maxY/6))
            rectangle4.physicsBody = SKPhysicsBody(rectangleOf: rectangle4.size)
            rectangle4.physicsBody?.isDynamic = false
            rectangle4.physicsBody?.categoryBitMask = CategoryBitMask.obsticle
            addChild(rectangle4)
        }

    }
    
    func createlabel()
    {
        label = SKLabelNode()
        label.text = "this gets replaced with time"
        label.fontSize = 32.0
        label.fontColor = UIColor.white
        label.position = CGPoint(x:  0, y:  350)
        cameraNode.addChild(label)
    }

}

class GameScene2: SKScene
{
    var shapemenu = SKShapeNode()
    var label = SKLabelNode()
    
    
    override func didMove(to view: SKView)
    {
        createlabel()
        createshapemenu()
    }
    
    func createshapemenu()
    {
        shapemenu = SKShapeNode(rectOf: CGSize(width: 1000, height: 1000))
        shapemenu.fillColor = SKColor.white
        shapemenu.fillTexture = SKTexture(imageNamed: "doge")
        shapemenu.position = CGPoint(x: self.frame.width - 100, y: self.frame.height - 100)
        self.addChild(shapemenu)
        
    }
    
    func createlabel()
    {
        label = SKLabelNode()
        label.text = "this gets replace with time"
        label.fontSize = 32.0
        label.fontColor = UIColor.white
        label.position = CGPoint(x: self.frame.midX, y: self.frame.midY)
        self.addChild(label)
    }
    
}

class MainMenu: SKScene
{
    
    var shapemenu = SKShapeNode()
    var label = SKLabelNode()

    
    override func didMove(to view: SKView)
    {
        createlabel("tha gaem", vector2(Float(self.frame.midX), Float(self.frame.midY + 0)))
        createshapemenu()
    }
    
    func createshapemenu()
    {
        shapemenu = SKShapeNode(rectOf: CGSize(width: 100, height: 100))
        shapemenu.fillColor = SKColor.white
        shapemenu.fillTexture = SKTexture(imageNamed: "doge")
        shapemenu.position = CGPoint(x: self.frame.width - 100, y: self.frame.height - 100)
        self.addChild(shapemenu)
        
    }
    
    func createlabel(_ text:String, _ vec2: vector_float2)
    {
        label = SKLabelNode()
        label.text = text
        label.fontSize = 32.0
        label.fontColor = UIColor.white
        label.position = CGPoint(x: CGFloat(vec2.x) , y: CGFloat(vec2.y))
        self.addChild(label)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        
        let newScene = level(size: (self.view?.bounds.size)!)
        let transition = SKTransition.reveal(with: .down, duration: 2)
        self.view?.presentScene(newScene, transition: transition)
        
        transition.pausesOutgoingScene = false
        transition.pausesIncomingScene = false
        
    }
}

class level: SKScene
{
    var shapemenu = SKShapeNode()
    var label = SKLabelNode()
    var label2 = SKLabelNode()

    
    
    override func didMove(to view: SKView)
    {
        createlabel("level 1", vector2(Float(self.frame.midX), Float(self.frame.midY + 100)))
        createlabel2("level 2", vector2(Float(self.frame.midX), Float(self.frame.midY - 100)))

    }
    

    func createlabel(_ text:String, _ vec2: vector_float2)
    {
        label = SKLabelNode()
        label.text = text
        label.fontSize = 32.0
        label.fontColor = UIColor.white
        label.position = CGPoint(x: CGFloat(vec2.x) , y: CGFloat(vec2.y))
        self.addChild(label)
    }
    
    func createlabel2(_ text:String, _ vec2: vector_float2)
    {
        label2 = SKLabelNode()
        label2.text = text
        label2.fontSize = 32.0
        label2.fontColor = UIColor.white
        label2.position = CGPoint(x: CGFloat(vec2.x) , y: CGFloat(vec2.y))
        self.addChild(label2)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        let location = touches.first?.location(in: self)
        if label.contains(location!)
        {
            let newScene = GameScene1(size: (self.view?.bounds.size)!)
            let transistion = SKTransition.reveal(with: .up, duration: 2)
            self.view?.presentScene(newScene, transition:  transistion)
            transistion.pausesIncomingScene = false
            transistion.pausesOutgoingScene = true
        }
        
        if label2.contains(location!)
        {
            let newScene = GameScene2(size: (self.view?.bounds.size)!)
            let transistion = SKTransition.reveal(with: .up, duration: 2)
            self.view?.presentScene(newScene, transition:  transistion)
            transistion.pausesIncomingScene = false
            transistion.pausesOutgoingScene = true
        }
    }
    
}
