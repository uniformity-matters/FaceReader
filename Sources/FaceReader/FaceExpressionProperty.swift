//
//  FaceExpressionProperty.swift
//  
//
//  Created by David Schmöcker on 11.09.21.
//

import Foundation

public enum FaceExpressionProperty: CaseIterable {
    case browDownLeft
    case browDownRight
    case browInnerUp
    case browOuterLeftUp
    case browOuterRightUp

    case cheekPuff
    case cheekSquintLeft
    case cheekSquintRight

    case eyeBlinkLeft
    case eyeBlinkRight
    case eyeLookDownLeft
    case eyeLookDownRight
    case eyeLookInLeft
    case eyeLookInRight
    case eyeLookOutLeft
    case eyeLookOutRight
    case eyeSquintLeft
    case eyeSquintRight
    case eyeWideLeft
    case eyeWideRight

    case jawForward
    case jawLeft
    case jawOpen
    case jawRight

    case mouthClose
    case mouthDimpleLeft
    case mouthDimpleRight
    case mouthFrownLeft
    case mouthFrownRight
    case mouthFunnel
    case mouthLeft
    case mouthRight
    case mouthLowerDownLeft
    case mouthLowerDownRight
    case moutPressLeft
    case mouthPressRight
    case mouthPucker
    case mouthRollLower
    case mouthRollUpper
    case mouthShrugLower
    case mouthShrugUpper
    case mouthSimleLeft
    case mouthSmileRight
    case mouthStretchLeft
    case mouthStretchRight
    case mouthUpperUpLeft
    case mouthUpperUpRight

    case noseSneerLeft
    case noseSneerRight
    case tongueOut

    enum FacePropertyCategory {
        case nose
        case brows
        case cheeks
        case eyes
        case mouth
        case jaw
        case tongue
    }

    var category: FacePropertyCategory {
        switch self {
        case .browDownLeft,
             .browDownRight,
             .browInnerUp,
             .browOuterLeftUp,
             .browOuterRightUp:
            return .brows
        case .noseSneerRight, .noseSneerLeft:
            return .nose
        case .eyeBlinkLeft,
             .eyeBlinkRight,
             .eyeLookDownLeft,
             .eyeLookDownRight,
             .eyeLookInLeft,
             .eyeLookInRight,
             .eyeLookOutLeft,
             .eyeLookOutRight,
             .eyeSquintLeft,
             .eyeSquintRight,
             .eyeWideLeft,
             .eyeWideRight:
            return .eyes
        case .jawForward,
             .jawLeft,
             .jawOpen,
             .jawRight:
            return .jaw
        case .mouthClose,
             .mouthDimpleLeft,
             .mouthDimpleRight,
             .mouthFrownLeft,
             .mouthFrownRight,
             .mouthFunnel,
             .mouthLeft,
             .mouthRight,
             .mouthLowerDownLeft,
             .mouthLowerDownRight,
             .moutPressLeft,
             .mouthPressRight,
             .mouthPucker,
             .mouthRollLower,
             .mouthRollUpper,
             .mouthShrugLower,
             .mouthShrugUpper,
             .mouthSimleLeft,
             .mouthSmileRight,
             .mouthStretchLeft,
             .mouthStretchRight,
             .mouthUpperUpLeft,
             .mouthUpperUpRight:
            return .mouth
        case .tongueOut:
            return .tongue
        case .cheekPuff, .cheekSquintLeft, .cheekSquintRight:
            return .cheeks
        }
    }
}
