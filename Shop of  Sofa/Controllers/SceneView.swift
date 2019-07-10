//
//  SceneView.swift
//  Shop of  Sofa
//
//  Created by Сергей Косилов on 09/07/2019.
//  Copyright © 2019 Сергей Косилов. All rights reserved.
//

import UIKit
import SceneKit
import ARKit


class SceneView: UIViewController {
    
    @IBOutlet weak var sceneView: ARSCNView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

       sceneView.delegate = self
    
       sceneView.showsStatistics = true
        
       sceneView.debugOptions = [ ARSCNDebugOptions.showWorldOrigin, ARSCNDebugOptions.showFeaturePoints]
        
    }
    

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let configuration = ARWorldTrackingConfiguration()
        configuration.planeDetection = [.horizontal]
        sceneView.session.run(configuration)
    }

    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        sceneView.session.pause()
    }
    
    
    func createFloor(planeAnchor: ARPlaneAnchor) -> SCNNode {
        
        let node = SCNNode()
        
        let extent = planeAnchor.extent
        let width = CGFloat(extent.x)
        let height = CGFloat(extent.z)
        
        let geometry = SCNPlane(width: width, height: height)
        geometry.firstMaterial?.diffuse.contents = UIColor.blue
        node.geometry = geometry
        node.eulerAngles.x = -.pi/2
        node.opacity = 0.25
        
        return node
    }
    
    
    func createSofa(planeAnchor: ARPlaneAnchor) -> SCNNode{
        let node = SCNScene(named: "sofa")!.rootNode.clone()
        let center = planeAnchor.center
        node.position = SCNVector3(center.x, 0, center.y)
        return node
    }
    
}



extension SceneView: ARSCNViewDelegate{
    
    func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
        guard let planeAnchor = anchor as? ARPlaneAnchor else { return}
        
        let floor = createFloor(planeAnchor: planeAnchor)
        node.addChildNode(floor)
        print(#line,#function,planeAnchor)
        
        let sofa = createSofa(planeAnchor: planeAnchor)
        node.addChildNode(sofa)
    }
    
    func renderer(_ renderer: SCNSceneRenderer, didUpdate node: SCNNode, for anchor: ARAnchor) {
        guard let planeAnchor = anchor as? ARPlaneAnchor else { return}
        
        for childNode in node.childNodes{
            let center = planeAnchor.center
            childNode.position = SCNVector3(center.x, 0, center.y)
        }
        
        guard let floor = node.childNodes.first else { return}
        guard let plane =  floor.geometry as? SCNPlane else { return}
        
        let extent = planeAnchor.extent
        plane.width = CGFloat(extent.x)
        plane.height = CGFloat(extent.z)
        
        
        
        }
        
    }
    

