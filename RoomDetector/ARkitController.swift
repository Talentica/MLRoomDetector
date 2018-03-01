//
//  ARkitController.swift
//  RoomDetector
//
//  Created by suyash gupta on 27/02/18.
//  Copyright © 2018 Talentica. All rights reserved.
//

import Foundation
import UIKit
import CoreML
import ARKit
import Vision
import ImageIO

class ARkitController: UIViewController, ARSCNViewDelegate {
    @IBOutlet weak var sceneView: ARSCNView!
    
    private lazy var classifier: Painting = Painting()
    private var requests = [VNRequest]()
    private var startTime: TimeInterval?
    private var interval:TimeInterval = 2.0
    let dispatchQueueML = DispatchQueue(label: "com.talentica.arkitapp") // A Serial Queue
    private let configuration = ARWorldTrackingConfiguration()
    private let roomView = RoomView()
    private var isDetected = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupAndAddVision()
//        self.checkAndMakeView()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        removeRequests()
    }
    
    private func initUI() {
        // Enable plane detection
//        configuration.planeDetection = .horizontal
        
        // Run the view's session
        sceneView.antialiasingMode = .multisampling4X
        sceneView.automaticallyUpdatesLighting = false
        sceneView.session.run(configuration)
        sceneView.preferredFramesPerSecond = 60
        sceneView.contentScaleFactor = 1.3
        sceneView.delegate = self// Set the view's delegate
        sceneView.showsStatistics = true// Show statistics such as fps and timing information
        sceneView.autoenablesDefaultLighting = true// Enable Default Lighting - makes the 3D text a bit poppier.
        if let camera = sceneView.pointOfView?.camera {
            camera.wantsHDR = true
            //camera.wantsExposureAdaptation = true
            //camera.exposureOffset = -1
            //camera.minimumExposure = -1
        }
    }
    
    func setupAndAddVision() {
        guard let visionModel = try? VNCoreMLModel(for: classifier.model) else {
            fatalError("Can’t load VisionML model")
        }
        let classificationRequest = VNCoreMLRequest(model: visionModel, completionHandler: handleDetections)
        classificationRequest.imageCropAndScaleOption = VNImageCropAndScaleOption.scaleFill
        requests = [classificationRequest]
    }
    
    func removeRequests() {
        requests.removeAll()
    }
    
    func handleDetections(request: VNRequest, error: Error?) {
        if let _ = error {
            return
        }
        let mlmodel = classifier
        let userDefined: [String: String] = mlmodel.model.modelDescription.metadata[MLModelMetadataKey.creatorDefinedKey]! as! [String : String]
        let nmsThreshold = Float(userDefined["non_maximum_suppression_threshold"]!) ?? 0.5
        
        guard let observations = request.results as? [VNCoreMLFeatureValueObservation] else {
            fatalError("unexpected result type from VNCoreMLRequest")
        }
        let predictions = Predictions.FromMultiDimensionalArrays(observations: observations, nmsThreshold: nmsThreshold)
        
        var strings: [String] = []
        if let predictions = predictions {
            for prediction in predictions {
                let pct = Float(Int(prediction.confidence * 10000)) / 100
                strings.append("\(pct)%")
            }
        }
        
        DispatchQueue.main.async {
            for subview in self.sceneView.subviews {
                subview.removeFromSuperview()
            }
            
            if let predictions = predictions {
                for prediction in predictions {
                    self.highlightArea(boundingRect: prediction.boundingBox)
                    DispatchQueue.main.async {
                        self.checkAndMakeView()
                    }
                }
            }
        }
    }
    
    private func checkAndMakeView() {
        if !isDetected {
            isDetected = true
            roomView.setup(sceneView: sceneView)
            removeRequests()
        }
    }
    
    func highlightArea(boundingRect: CGRect) {
        let source = self.sceneView.frame
        
        let rectWidth = source.size.width * boundingRect.size.width
        let rectHeight = source.size.height * boundingRect.size.height
        
        let outline = UIView()
        outline.frame = CGRect(x: boundingRect.origin.x * source.size.width, y:boundingRect.origin.y * source.size.height, width: rectWidth, height: rectHeight)
        
        outline.layer.frame = CGRect(x: boundingRect.origin.x * source.size.width, y:boundingRect.origin.y * source.size.height, width: rectWidth, height: rectHeight)
        outline.layer.borderWidth = 2.0
        outline.layer.borderColor = UIColor.red.cgColor
        self.sceneView.addSubview(outline)
    }
    
    func renderer(_ renderer: SCNSceneRenderer, updateAtTime time: TimeInterval) {
        if startTime == nil {
            startTime = time
        }
        if time - startTime! > interval {
            startTime = time
            dispatchQueueML.async {
                self.executeTheRequest()
            }
            //            print("updateAtTime:\(time) startTime:\(startTime)")
        } else {
            //            print("updateAtTime:\(time)")
        }
    }
    
    private func executeTheRequest() {
        let pixbuff : CVPixelBuffer? = (sceneView.session.currentFrame?.capturedImage)
        if pixbuff == nil { return }
//        let ciImage = CIImage(cvPixelBuffer: pixbuff!)
        //        let context = CIContext(options: nil)
        //        let cgImage = context.createCGImage(ciImage, from: ciImage.extent)
        // Note: Not entirely sure if the ciImage is being interpreted as RGB, but for now it works with the Inception model.
        // Note2: Also uncertain if the pixelBuffer should be rotated before handing off to Vision (VNImageRequestHandler) - regardless, for now, it still works well with the Inception model.
        
        ///////////////////////////
        // Prepare CoreML/Vision Request
        //        let imageRequestHandler = VNImageRequestHandler(ciImage: ciImage, options: [:])
        //        let orientation = CGImagePropertyOrientation.right
        //        let inputImage = ciImage.oriented(forExifOrientation: Int32(CGImagePropertyOrientation.right.rawValue))
        
        let imageRequestHandler = VNImageRequestHandler(cvPixelBuffer: pixbuff!, orientation: CGImagePropertyOrientation.right, options: [:]) // Alternatively; we can convert the above to an RGB CGImage and use that. Also UIInterfaceOrientation can inform orientation values.
        
        ///////////////////////////
        // Run Image Request
        do {
            if requests.count > 0 {
                try imageRequestHandler.perform(self.requests)
            }
        } catch {
            print(error)
        }
    }
}
