//
//  FaceExpressionProperty+BlendShapeLocation.swift
//  
//
//  Created by David Schmöcker on 11.09.21.
//

import Foundation
import ARKit

extension FaceExpressionProperty {
    var blendShapeLocation: ARFaceAnchor.BlendShapeLocation {
        switch self {
        case .browOuterRightUp:
            return ARFaceAnchor.BlendShapeLocation.browOuterUpRight
        case .browOuterLeftUp:
            return ARFaceAnchor.BlendShapeLocation.browOuterUpLeft
        case .browInnerUp:
            return ARFaceAnchor.BlendShapeLocation.browInnerUp
        case .browDownLeft:
            return ARFaceAnchor.BlendShapeLocation.browDownLeft
        case .browDownRight:
            return ARFaceAnchor.BlendShapeLocation.browDownRight
        case .eyeBlinkLeft:
            return ARFaceAnchor.BlendShapeLocation.eyeBlinkLeft
        case .eyeBlinkRight:
            return ARFaceAnchor.BlendShapeLocation.eyeBlinkRight
        case .cheekPuff:
            return ARFaceAnchor.BlendShapeLocation.cheekPuff
        case .cheekSquintLeft:
            return ARFaceAnchor.BlendShapeLocation.cheekSquintLeft
        case .cheekSquintRight:
            return ARFaceAnchor.BlendShapeLocation.cheekSquintRight
        case .eyeLookDownLeft:
            return ARFaceAnchor.BlendShapeLocation.eyeLookDownLeft
        case .eyeLookDownRight:
            return ARFaceAnchor.BlendShapeLocation.eyeLookDownRight
        case .eyeLookInLeft:
            return ARFaceAnchor.BlendShapeLocation.eyeLookInLeft
        case .eyeLookInRight:
            return ARFaceAnchor.BlendShapeLocation.eyeLookInRight
        case .eyeLookOutLeft:
            return ARFaceAnchor.BlendShapeLocation.eyeLookOutLeft
        case .eyeLookOutRight:
            return ARFaceAnchor.BlendShapeLocation.eyeLookOutRight
        case .eyeSquintLeft:
            return ARFaceAnchor.BlendShapeLocation.eyeSquintLeft
        case .eyeSquintRight:
            return ARFaceAnchor.BlendShapeLocation.eyeSquintRight
        case .eyeWideLeft:
            return ARFaceAnchor.BlendShapeLocation.eyeWideLeft
        case .eyeWideRight:
            return ARFaceAnchor.BlendShapeLocation.eyeWideRight
        case .jawForward:
            return ARFaceAnchor.BlendShapeLocation.jawForward
        case .jawLeft:
            return ARFaceAnchor.BlendShapeLocation.jawLeft
        case .jawOpen:
            return ARFaceAnchor.BlendShapeLocation.jawOpen
        case .jawRight:
            return ARFaceAnchor.BlendShapeLocation.jawRight
        case .mouthClose:
            return ARFaceAnchor.BlendShapeLocation.mouthClose
        case .mouthDimpleLeft:
            return ARFaceAnchor.BlendShapeLocation.mouthDimpleLeft
        case .mouthDimpleRight:
            return ARFaceAnchor.BlendShapeLocation.mouthDimpleRight
        case .mouthFrownLeft:
            return ARFaceAnchor.BlendShapeLocation.mouthFrownLeft
        case .mouthFrownRight:
            return ARFaceAnchor.BlendShapeLocation.mouthFrownRight
        case .mouthFunnel:
            return ARFaceAnchor.BlendShapeLocation.mouthFunnel
        case .mouthLeft:
            return ARFaceAnchor.BlendShapeLocation.mouthLeft
        case .mouthRight:
            return ARFaceAnchor.BlendShapeLocation.mouthRight
        case .mouthLowerDownLeft:
            return ARFaceAnchor.BlendShapeLocation.mouthLowerDownLeft
        case .mouthLowerDownRight:
            return ARFaceAnchor.BlendShapeLocation.mouthLowerDownRight
        case .moutPressLeft:
            return ARFaceAnchor.BlendShapeLocation.mouthPressLeft
        case .mouthPressRight:
            return ARFaceAnchor.BlendShapeLocation.mouthPressRight
        case .mouthPucker:
            return ARFaceAnchor.BlendShapeLocation.mouthPucker
        case .mouthRollLower:
            return ARFaceAnchor.BlendShapeLocation.mouthRollLower
        case .mouthRollUpper:
            return ARFaceAnchor.BlendShapeLocation.mouthRollUpper
        case .mouthShrugLower:
            return ARFaceAnchor.BlendShapeLocation.mouthShrugLower
        case .mouthShrugUpper:
            return ARFaceAnchor.BlendShapeLocation.mouthShrugUpper
        case .mouthSimleLeft:
            return ARFaceAnchor.BlendShapeLocation.mouthSmileLeft
        case .mouthSmileRight:
            return ARFaceAnchor.BlendShapeLocation.mouthSmileRight
        case .mouthStretchLeft:
            return ARFaceAnchor.BlendShapeLocation.mouthStretchLeft
        case .mouthStretchRight:
            return ARFaceAnchor.BlendShapeLocation.mouthStretchRight
        case .mouthUpperUpLeft:
            return ARFaceAnchor.BlendShapeLocation.mouthUpperUpLeft
        case .mouthUpperUpRight:
            return ARFaceAnchor.BlendShapeLocation.mouthUpperUpRight
        case .noseSneerLeft:
            return ARFaceAnchor.BlendShapeLocation.noseSneerLeft
        case .noseSneerRight:
            return ARFaceAnchor.BlendShapeLocation.noseSneerRight
        case .tongueOut:
            return ARFaceAnchor.BlendShapeLocation.tongueOut
        }
    }
}
