//
//  ARViewController.swift
//  myFirstARapp
//
//  Created by Vincenzo di Somma on 07/07/2019.
//  Copyright © 2019 Vincenzo di Somma. All rights reserved.
//

import UIKit
import ARKit
import SceneKit

class ARViewController: UIViewController, ARSCNViewDelegate {

    @IBOutlet weak var scene: ARSCNView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        /*
        scene.delegate=self
        scene.showsStatistics=true
        scene.scene=SCNScene()
        let circleNode = createSphereNode(with: 0.15, color: .green)
        circleNode.position = SCNVector3(0, 0, -1) // 1 meter in front of camera
        let cubeNode = createCubeNode(with: 0.2, color: .blue)
        cubeNode.position=SCNVector3(1,0,-1)
        
        let img:ARReferenceImage
        
        let davide:ARImageAnchor
        
        
        
        
        scene.scene.rootNode.addChildNode(circleNode)
        scene.scene.rootNode.addChildNode(cubeNode)
 */
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let configuration = ARWorldTrackingConfiguration()
//        caricare la world map
        scene.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
//        prendere la world map,salvare la world map currentWorldMap
        scene.session.pause()
    }
    
    func createSphereNode(with radius: CGFloat, color: UIColor) -> SCNNode {
        let geometry = SCNSphere(radius: radius)
        geometry.firstMaterial?.diffuse.contents = color
        let sphereNode = SCNNode(geometry: geometry)
        return sphereNode
    }
    
    func createCubeNode(with length:CGFloat, color: UIColor) -> SCNNode{
        let geometry = SCNBox(width: length, height: length, length: length, chamferRadius: 0.01)
        geometry.firstMaterial?.diffuse.contents=color
        let cubeNode=SCNNode(geometry: geometry)
        return cubeNode
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
