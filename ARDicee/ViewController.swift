//
//  ViewController.swift
//  ARDicee
//
//  Created by Thiago Antonio Ramalho on 02/01/22.
//

import UIKit
import SceneKit
import ARKit

class ViewController: UIViewController, ARSCNViewDelegate {

    @IBOutlet var sceneView: ARSCNView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the view's delegate
        sceneView.delegate = self
        
        // Show statistics such as fps and timing information
        sceneView.showsStatistics = true

//        let material = SCNMaterial()
//        //material.diffuse.contents = UIColor.red
//        material.diffuse.contents = UIImage(named: "art.scnassets/moon.jpeg")
//
//
//        //let shape = SCNBox(width: 0.1, height: 0.1, length: 0.1, chamferRadius: 0.01)
//        let shape = SCNSphere(radius: 0.2)
//        shape.materials = [material]
//
//        let node = SCNNode(geometry: shape)
//        node.position = SCNVector3(0, 0.1, -0.5)
//
//        sceneView.scene.rootNode.addChildNode(node)
//        sceneView.autoenablesDefaultLighting = true
//        // Create a new scene
//        let scene = SCNScene(named: "art.scnassets/ship.scn")!
//
//        // Set the scene to the view
//        sceneView.scene = scene
        
        
//        let diceScene = SCNScene(named: "art.scnassets/diceCollada.scn")
//
//        if let diceNode = diceScene?.rootNode.childNode(withName: "Dice", recursively: true) {
//            diceNode.position = SCNVector3(0, 0, -0.1)
//            sceneView.scene.rootNode.addChildNode(diceNode)
//        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
                
        if ARWorldTrackingConfiguration.isSupported {
            let config = ARWorldTrackingConfiguration()
            config.planeDetection = .horizontal
            sceneView.session.run(config)
            print("ARWorldTrackingConfiguration")
        } else if AROrientationTrackingConfiguration.isSupported {
            let config = AROrientationTrackingConfiguration()
            sceneView.session.run(config)
            print("AROrientationTrackingConfiguration")
        } else {
            print("AR not supported")
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }

    func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
        
        if let anchor = anchor as? ARPlaneAnchor {
            
            let plane = SCNPlane(width: CGFloat(anchor.extent.x), height: CGFloat(anchor.extent.z))
            
            let planeNode = SCNNode()
            
            planeNode.position = SCNVector3(anchor.center.x, 0, anchor.center.z)
            
            planeNode.transform = SCNMatrix4MakeRotation(-Float.pi / 2, 1, 0, 0)
            
            let gridMaterial = SCNMaterial()
            
            gridMaterial.diffuse.contents = UIImage(named: "art.scnassets/grid.png")
            
            plane.materials = [gridMaterial]
            
            planeNode.geometry = plane
            
            node.addChildNode(planeNode)
        }
    }
}
