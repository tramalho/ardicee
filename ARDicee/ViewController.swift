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

        let material = SCNMaterial()
        //material.diffuse.contents = UIColor.red
        material.diffuse.contents = UIImage(named: "art.scnassets/moon.jpeg")

        
        //let shape = SCNBox(width: 0.1, height: 0.1, length: 0.1, chamferRadius: 0.01)
        let shape = SCNSphere(radius: 0.2)
        shape.materials = [material]
        
        let node = SCNNode(geometry: shape)
        node.position = SCNVector3(0, 0.1, -0.5)
        
        sceneView.scene.rootNode.addChildNode(node)
        sceneView.autoenablesDefaultLighting = true
        
//        // Create a new scene
//        let scene = SCNScene(named: "art.scnassets/ship.scn")!
//
//        // Set the scene to the view
//        sceneView.scene = scene
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
                
        if ARWorldTrackingConfiguration.isSupported {
            sceneView.session.run(ARWorldTrackingConfiguration())
            print("ARWorldTrackingConfiguration")
        } else if AROrientationTrackingConfiguration.isSupported {
            sceneView.session.run(AROrientationTrackingConfiguration())
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
}
