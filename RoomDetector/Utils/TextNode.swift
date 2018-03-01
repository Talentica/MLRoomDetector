//
//  TextNode.swift
//
//
//  Created by suyash gupta on 27/02/18.
//  Copyright © 2018 Talentica. All rights reserved.
//  
//

import UIKit
import SceneKit
import ARKit

class TextNode: SCNNode {
    
    override init() {
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    init(distance:Float, scntext:SCNText, sceneView:ARSCNView, scale:CGFloat, type: TextType){
        super.init()
        guard let pointOfView = sceneView.pointOfView else { return }
        let mat = pointOfView.transform
        
        var dir:SCNVector3?
        if type == TextType.Title {
            dir = SCNVector3(-1 * mat.m31, -1 * mat.m32, -1 * mat.m33)
        } else if type == TextType.Desc {
            dir = SCNVector3(-1 * mat.m31, -1 * mat.m32 - 0.1, -1 * mat.m33)
        } else if type == TextType.Desc2 {
            dir = SCNVector3(-1 * mat.m31, -1 * mat.m32 - 0.3, -1 * mat.m33)
        } else {
            dir = SCNVector3(-1 * mat.m31, -1 * mat.m32, -1 * mat.m33)
        }
        print("dir:\(dir!)")
        
        let currentPosition = pointOfView.position + (dir! * distance)
        self.position = currentPosition
        
        self.geometry = scntext
        
        self.simdRotation = pointOfView.simdRotation
        self.setPivot()
        self.scale = SCNVector3(scale, scale, scale)
    }
}
