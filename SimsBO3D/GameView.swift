//
//  GameView.swift
//  SimsBO3D
//
//  Created by Mark Madden on 3/4/19.
//  Copyright © 2019 Mark Madden. All rights reserved.
//

import Foundation
import SceneKit
import SpriteKit
/// Is used in Main.storyboard
/// under Identity Inspector
final class GameView: SCNView {
    override func awakeFromNib() {
        super.awakeFromNib()
        setup2DOverlay()
    }
    func setup2DOverlay() {
        let viewHeight = bounds.size.height
        let viewWidth = bounds.size.width
        let sceneSize = CGSize(width: viewWidth, height: viewHeight)
        let skScene = SKScene(size: sceneSize)
        skScene.scaleMode = .resizeFill
        
        //Setup left dpad shape
        let dpadShape = SKShapeNode(circleOfRadius: 75)
        dpadShape.strokeColor = .white
        dpadShape.lineWidth = 2.0
        dpadShape.position.x = dpadShape.frame.size.width / 2 + 10
        dpadShape.position.y = dpadShape.frame.size.height / 2 + 10
        
        //Setup right A button
        let aButtonShape = SKShapeNode(circleOfRadius: 25)
        aButtonShape.strokeColor = .white
        aButtonShape.lineWidth = 2.0
        
        
        aButtonShape.position.x = 1
        aButtonShape.position.y = 1
        
        
        skScene.addChild(dpadShape)
        skScene.addChild(aButtonShape)
        skScene.isUserInteractionEnabled = false
        overlaySKScene = skScene
    }
    
    func virtualDPad() -> CGRect {
        var vDPad = CGRect(x: 0, y: 0, width: 150, height: 150)
        vDPad.origin.y = bounds.size.height - vDPad.size.height - 10
        vDPad.origin.x = 10
        return vDPad
    }
}
