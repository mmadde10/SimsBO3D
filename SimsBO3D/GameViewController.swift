//
//  GameViewController.swift
//  SimsBO3D
//
//  Created by Mark Madden on 3/3/19.
//  Copyright © 2019 Mark Madden. All rights reserved.
//

import UIKit
import QuartzCore
import SceneKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {
    
    var gameView: GameView {
        return view as! GameView
    }
    var scene: SCNScene!
    let playerNode = PlayerNode()
    var touch: UITouch?
    var direction = float2(0, 0)
    let cameraNode = CameraNode()
    

    override func viewDidLoad() {
        super.viewDidLoad()        
        scene = SCNScene()
        gameView.scene = scene
        
        let lightNode = LightNode()
        gameView.delegate = self
        gameView.isPlaying = true
        let floorNode = FloorNode()
    
        scene.rootNode.addChildNode(lightNode)
        scene.rootNode.addChildNode(cameraNode)
        scene.rootNode.addChildNode(floorNode)
        scene.rootNode.addChildNode(playerNode)
        
        gameView.showsStatistics = true
        gameView.allowsCameraControl = false
    }
    
    override var shouldAutorotate: Bool {
        return true
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        }
        else {
            return .all
        }
    }
}

extension GameViewController {
    // store touch in global scope
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        touch = touches.first
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touch {
            
            let touchLocation = touch.location(in: self.view)
            if gameView.virtualDPad().contains(touchLocation) {
                let middleOfCircleX = gameView.virtualDPad().origin.x + 75
                let middleOfCircleY = gameView.virtualDPad().origin.y + 75
                let lengthOfX = Float(touchLocation.x - middleOfCircleX)
                let lengthOfY = Float(touchLocation.y - middleOfCircleY)
                direction = float2(x: lengthOfX, y: lengthOfY)
                direction = normalize(direction)
                let degree = atan2(direction.x, direction.y)
                playerNode.directionAngle = degree
            }
        }
    }
    
    //TODO Add A and B Buton Touches Moved Equivalent
    
}

extension GameViewController: SCNSceneRendererDelegate {
    func renderer(_ renderer: SCNSceneRenderer, updateAtTime time: TimeInterval) {
        let directionInV3 = float3(x: direction.x, y: 0, z: direction.y)
        playerNode.walkInDirection(directionInV3)
        cameraNode.position.x = playerNode.presentation.position.x
        cameraNode.position.z = playerNode.presentation.position.z + CameraNode.offset
    }
}

// Add Player Action for A and B Button
