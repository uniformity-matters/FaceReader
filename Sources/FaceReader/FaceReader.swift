
import Foundation
import ARKit
import Combine

public class FaceReader: NSObject, ARSessionDelegate {
    public static var `default`: FaceReader {
        get {
            if let sharedInstance = sharedInstance {
                return sharedInstance
            } else {
                let faceReader = FaceReader()
                sharedInstance = faceReader
                return faceReader
            }
        }
    }

    fileprivate static var sharedInstance: FaceReader?

    public private(set) var session: ARSession

    @Published
    public private(set) var faceExpressions: [FaceExpressionProperty: Float] = [:]
    @Published
    public private(set) var facePositions: [FacePositionProperty: CGPoint] = [:]
    @Published
    public private(set) var faceDetected: Bool = false

    private var sessionConfiguration: ARFaceTrackingConfiguration
    private var sessionShouldBeRunning: Bool = false

    private var expressions: [FaceExpressionProperty: Float] = [:]
    private var positions: [FacePositionProperty: CGPoint] = [:]
    private var currentFaceAnchor: ARFaceAnchor? = nil

    public override init() {
        sessionConfiguration = ARFaceTrackingConfiguration()
        session = ARSession()
        super.init()
        session.delegate = self
    }

    public var isRunning: Bool {
        return sessionShouldBeRunning
    }

    public func start() {
        session.run(sessionConfiguration, options: ARSession.RunOptions.resetTracking)
        sessionShouldBeRunning = true
    }

    public func pause() {
        session.pause()
        sessionShouldBeRunning = false
    }

    //MARK: ARSessionDelegate
    public func session(_ session: ARSession, didFailWithError error: Error) {
        print("error: \(error)")
    }

    public func session(_ session: ARSession, didUpdate frame: ARFrame) {
        for anchor in frame.anchors {
            if let currentFaceAnchor = currentFaceAnchor, currentFaceAnchor == anchor, !currentFaceAnchor.isTracked {
                self.faceDetected = false
                self.currentFaceAnchor = nil
            }
        }
    }

    public func session(_ session: ARSession, didUpdate anchors: [ARAnchor]) {
        var foundFaceAnchor: ARFaceAnchor? = nil

        for anchor in anchors {
            guard let faceAnchor = anchor as? ARFaceAnchor else {
                continue
            }
            foundFaceAnchor = faceAnchor

            FaceExpressionProperty.allCases.forEach { expression in
                expressions[expression] = clamp(faceAnchor.blendShapes[expression.blendShapeLocation]?.floatValue)
            }

            updateFacePositionProperties(faceAnchor: faceAnchor)

            faceExpressions = expressions
            facePositions = positions
        }

        if let faceAnchor = foundFaceAnchor {
            if faceDetected == false {
                self.faceDetected = true
            }
            self.currentFaceAnchor = faceAnchor
        } else if let currentFaceAnchor = currentFaceAnchor, !currentFaceAnchor.isTracked {
            if faceDetected == true {
                self.faceDetected = false
            }
            self.currentFaceAnchor = nil
        }
    }

    private func updateFacePositionProperties(faceAnchor: ARFaceAnchor) {
        FacePositionProperty.allCases.forEach { (positionProperty) in
            switch positionProperty {
            case .eyePositionLeft:
                if let camera = session.currentFrame?.camera {
                    positions[positionProperty] = calculateLeftEyePosition(from: faceAnchor, using: camera)
                }
            case .eyePositionRight:
                if let camera = session.currentFrame?.camera {
                    positions[positionProperty] = calculateRightEyePosition(from: faceAnchor, using: camera)
                }
            }
        }
    }

    private static func convertWorldToScreenCoordinates(_ worldCoordinates: simd_float4x4,
                                                        using camera: ARCamera,
                                                        orientation: UIInterfaceOrientation = .portrait,
                                                        viewportSize: CGSize = UIScreen.main.bounds.size) -> CGPoint {

        let worldPosition = vector3(worldCoordinates.columns.3.x,
                                    worldCoordinates.columns.3.y,
                                    worldCoordinates.columns.3.z)

        let screenCoordinates = camera.projectPoint(worldPosition, orientation: orientation, viewportSize: viewportSize)

        return screenCoordinates
    }

    private func calculateLeftEyePosition(from faceAnchor: ARFaceAnchor, using camera: ARCamera) -> CGPoint {
        let leftEyeWorldTransform = simd_mul(faceAnchor.transform, faceAnchor.leftEyeTransform)
        return FaceReader.convertWorldToScreenCoordinates(leftEyeWorldTransform, using: camera)
    }

    private func calculateRightEyePosition(from faceAnchor: ARFaceAnchor, using camera: ARCamera) -> CGPoint {
        let rightEyeWorldTransform = simd_mul(faceAnchor.transform, faceAnchor.rightEyeTransform)
        return FaceReader.convertWorldToScreenCoordinates(rightEyeWorldTransform, using: camera)
    }
}
