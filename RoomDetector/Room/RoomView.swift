//
//  RoomDetail.swift
//
//  Created by suyash gupta on 27/02/18.
//  Copyright © 2018 Talentica. All rights reserved.
//

import Foundation
import ARKit

class RoomView {
    
    private let defaultRoom = "Donald Knuth"
    
    func setup(sceneView: ARSCNView) {
        let origin = SCNNode()
        origin.position = SCNVector3(0,0,0)
        origin.runAction(rotation(time: 7))
        sceneView.scene.rootNode.addChildNode(origin)
        
        self.addPaperPlaneNode(sceneView: sceneView, origin:origin, color: Color.COL_PLANE_GREEN, pos: SCNVector3(0,1,-4))
        self.addPaperPlaneNode(sceneView: sceneView, origin:origin, color: Color.COL_PLANE_BLUE, pos: SCNVector3(1,-1.6, -4))
        self.addPaperPlaneNode(sceneView: sceneView, origin:origin, color: Color.COL_PLANE_RED, pos: SCNVector3(-1 ,-2.8, -4))
        
        let titleNode = self.addTitleAndDesc(text: defaultRoom, sceneView: sceneView)
        self.addImageNode(sceneView: sceneView, titleNode: titleNode)//place image relative to title
    }
    
    private func rotation(time: TimeInterval) -> SCNAction {
        let Rotation = SCNAction.rotateBy(x: 0, y: CGFloat(360.degreesToRadians), z: 0, duration: time)
        let foreverRotation = SCNAction.repeatForever(Rotation)
        return foreverRotation
    }
    
    private func addPaperPlaneNode(sceneView: ARSCNView,origin:SCNNode, color:UIColor, pos: SCNVector3) {
        let paperPlaneScene = SCNScene(named: "art.scnassets/paperplane.scn")
        let paperPlaneNode = paperPlaneScene?.rootNode.childNode(withName: "plane", recursively: false)
        paperPlaneNode?.geometry?.firstMaterial?.diffuse.contents = color
        paperPlaneNode?.position = pos
        origin.addChildNode(paperPlaneNode!)
    }
    
    //returns the title node so that we can position the image node according to it
    private func addTitleAndDesc(text:String, sceneView: ARSCNView) -> TextNode {
        let details = RoomDetail(name: defaultRoom).roomDetail
        let details2 = RoomDetail(name: defaultRoom).roomDetail2
        
        let textScn = ARText(text: text, font: UIFont .systemFont(ofSize: CGFloat(17)), color: UIColor.black, depth: CGFloat(2.7))
        let textNode = TextNode(distance: Float(2.7), scntext: textScn, sceneView: sceneView, scale: 1/100.0, type: TextType.Title)
        
        let textDescScn = ARText(text: details, font: UIFont .systemFont(ofSize: CGFloat(8)), color: UIColor.black, depth: CGFloat(2.7))
        let textDescNode = TextNode(distance: Float(2.7), scntext: textDescScn, sceneView: sceneView, scale: 1/100.0, type: TextType.Desc)
        
        let textDesc2Scn = ARText(text: details2, font: UIFont .systemFont(ofSize: CGFloat(8)), color: UIColor.black, depth: CGFloat(2.7))
        let textDesc2Node = TextNode(distance: Float(2.7), scntext: textDesc2Scn, sceneView: sceneView, scale: 1/100.0, type: TextType.Desc2)
        
        sceneView.scene.rootNode.addChildNode(textNode)
        sceneView.scene.rootNode.addChildNode(textDescNode)
        sceneView.scene.rootNode.addChildNode(textDesc2Node)
        return textNode
    }
    
    private func addImageNode(sceneView: ARSCNView, titleNode: TextNode) {
        let imagePlaneScene = SCNScene(named: "art.scnassets/image.scn")
        let imagePlaneNode = imagePlaneScene?.rootNode.childNode(withName: "holder", recursively: false)
        imagePlaneNode?.geometry?.firstMaterial?.diffuse.contents = UIImage(named:"art.scnassets/donaldknuth.jpg")
        imagePlaneNode?.position = titleNode.position + SCNVector3(0, 0.4, 0)
        sceneView.scene.rootNode.addChildNode(imagePlaneNode!)
    }
}

extension Int {
    var degreesToRadians: Double { return Double(self) * .pi/180}
}
