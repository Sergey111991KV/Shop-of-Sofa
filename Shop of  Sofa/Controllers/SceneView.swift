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


class SceneView: UIViewController, ARSCNViewDelegate {
    
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
}
