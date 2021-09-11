//
//  FaceGestureAnalyzer.swift
//  
//
//  Created by David Schmöcker on 11.09.21.
//

import Foundation
import Combine
import CoreGraphics

public class FaceGestureAnalyzer {
    public static var `default`: FaceGestureAnalyzer {
        get {
            if let sharedInstance = sharedInstance {
                return sharedInstance
            } else {
                let faceGestureAnalyzer = FaceGestureAnalyzer(faceReader: FaceReader.default)
                sharedInstance = faceGestureAnalyzer
                return faceGestureAnalyzer
            }
        }
    }

    private static var sharedInstance: FaceGestureAnalyzer?
    private static let minDiff: Float = 0.05

    public var faceReader: FaceReader
    @Published
    public private(set) var browsUp: Float = 0.0
    @Published
    public private(set) var browsDown: Float = 0.0
    @Published
    public private(set) var eyeMidPoint: CGPoint = CGPoint.zero
    @Published
    public private(set) var mouthLeft: Float = 0.0
    @Published
    public private(set) var mouthRight: Float = 0.0
    @Published
    public private(set) var eyeBlinkLeft: Float = 0.0
    @Published
    public private(set) var eyeBlinkRight: Float = 0.0

    private var lastBrowsUpValue: Float? = nil
    private var lastBrowsDownValue: Float? = nil
    private var lastMouthRightValue: Float? = nil
    private var lastMouthLeftValue: Float? = nil
    private var lastEyeBlinkLeft: Float? = nil
    private var lastEyeBlinkRight: Float? = nil

    private var subscriptions: [AnyCancellable] = []

    init(faceReader: FaceReader) {
        self.faceReader = faceReader
        subscribe()
    }

    private func subscribe() {
        subscriptions.removeAll()

        faceReader.$faceExpressions.sink { [weak self] expressions in
            self?.onUpdated(expressions: expressions)
        }.store(in: &subscriptions)

        faceReader.$facePositions.sink { [weak self] positions in
            self?.onUpdated(positions: positions)
        }.store(in: &subscriptions)
    }


    private func onUpdated(expressions: [FaceExpressionProperty: Float]) {
        update(expressions: expressions)
    }

    private func onUpdated(positions: [FacePositionProperty: CGPoint]) {
        if let leftEye = positions[FacePositionProperty.eyePositionLeft],
           let rightEye = positions[FacePositionProperty.eyePositionRight] {
            eyeMidPoint = calculateEyeMidPoint(leftEyePosition: leftEye, rightEyePosition: rightEye)
        }
    }

    private func calculateBrowsUpValue(innerBrows: Float, rightOuterBrow: Float, leftOuterBrow: Float) -> Float {
        let outerBrows = (rightOuterBrow + leftOuterBrow)/2.0
        return (innerBrows * 0.5) + (outerBrows * 0.5)
    }

    private func calculateBrowsDownValue(rightBrowDown: Float, leftBrowDown: Float) -> Float {
        return leftBrowDown * 0.5 + rightBrowDown * 0.5
    }

    private func calculateEyeMidPoint(leftEyePosition left: CGPoint, rightEyePosition right: CGPoint) -> CGPoint {
        return CGPoint(x: (left.x + right.x) * 0.5, y: (left.y + right.y) * 0.5)
    }

    private func update(expressions: [FaceExpressionProperty: Float]) {
        updateBrows(from: expressions)

        if let mouthLeft = expressions[FaceExpressionProperty.mouthLeft],
           let mouthRight = expressions[FaceExpressionProperty.mouthRight] {
            update(mouthLeft: mouthLeft, mouthRight: mouthRight)
        }

        if let eyeBlinkLeft = expressions[FaceExpressionProperty.eyeBlinkLeft],
           let eyeBlinkRight = expressions[FaceExpressionProperty.eyeBlinkRight] {
            update(eyeBlinkLeft: eyeBlinkLeft, eyeBlinkRight: eyeBlinkRight)
        }
    }

    private func update(mouthLeft: Float, mouthRight: Float) {
        if let lastMouthLeft = lastMouthLeftValue {
            let diff = abs(lastMouthLeft - mouthLeft)
            //don't update if value did not change enough
            if (diff > FaceGestureAnalyzer.minDiff) {
                self.mouthLeft = mouthLeft
                self.lastMouthLeftValue = mouthLeft
            }
        } else {
            self.mouthLeft = mouthLeft
            self.lastMouthLeftValue = mouthLeft
        }

        if let lastMouthRight = lastMouthRightValue {
            let diff = abs(lastMouthRight - mouthRight)
            //don't update if value did not change enough
            if (diff > FaceGestureAnalyzer.minDiff) {
                self.mouthRight = mouthRight
                self.lastMouthRightValue = mouthRight
            }
        } else {
            self.mouthRight = mouthRight
            self.lastMouthRightValue = mouthRight
        }
    }

    private func update(eyeBlinkLeft: Float, eyeBlinkRight: Float) {
        if let lastEyeBlinkLeft = lastEyeBlinkLeft {
            let diff = abs(lastEyeBlinkLeft - eyeBlinkLeft)
            //don't update if value did not change enough
            if (diff > FaceGestureAnalyzer.minDiff) {
                self.eyeBlinkLeft = eyeBlinkLeft
                self.lastEyeBlinkLeft = eyeBlinkLeft
            }
        } else {
            self.eyeBlinkLeft = eyeBlinkLeft
            self.lastEyeBlinkLeft = eyeBlinkLeft
        }

        if let lastEyeBlinkRight = lastEyeBlinkRight {
            let diff = abs(lastEyeBlinkRight - eyeBlinkRight)
            //don't update if value did not change enough
            if (diff > FaceGestureAnalyzer.minDiff) {
                self.eyeBlinkRight = eyeBlinkRight
                self.lastEyeBlinkRight = eyeBlinkRight
            }
        } else {
            self.eyeBlinkRight = eyeBlinkRight
            self.lastEyeBlinkRight = eyeBlinkRight
        }
    }

    private func updateBrows(from expressions: [FaceExpressionProperty: Float]) {
        if let rightOuterBrowUp = expressions[FaceExpressionProperty.browOuterRightUp],
           let leftOuterBrowUp = expressions[FaceExpressionProperty.browOuterLeftUp],
           let innerBrowUp = expressions[FaceExpressionProperty.browInnerUp] {
            let browsUpValue = calculateBrowsUpValue(innerBrows: innerBrowUp,
                                                     rightOuterBrow: rightOuterBrowUp,
                                                     leftOuterBrow: leftOuterBrowUp)
            update(browsUpValue: browsUpValue)
        }

        if let rightBrowDown = expressions[FaceExpressionProperty.browDownRight],
           let leftBrowDown = expressions[FaceExpressionProperty.browDownLeft] {
            let browsDownValue = calculateBrowsDownValue(rightBrowDown: rightBrowDown, leftBrowDown: leftBrowDown)
            update(browsDownValue: browsDownValue)
        }
    }

    private func update(browsUpValue: Float) {
        if let lastBrowsUpValue = lastBrowsUpValue {
            let diff = abs(lastBrowsUpValue - browsUpValue)
            //don't update if value did not change enough
            if (diff > FaceGestureAnalyzer.minDiff) {
                browsUp = browsUpValue
                self.lastBrowsUpValue = browsUpValue
            }
        } else {
            browsUp = browsUpValue
            lastBrowsUpValue = browsUpValue
        }
    }

    private func update(browsDownValue: Float) {
        if let lastBrowsDownValue = lastBrowsDownValue {
            let diff = abs(lastBrowsDownValue - browsDownValue)
            //don't update if value did not change enough
            if (diff > FaceGestureAnalyzer.minDiff) {
                browsDown = browsDownValue
                self.lastBrowsDownValue = browsDownValue
            }
        } else {
            browsDown = browsDownValue
            lastBrowsDownValue = browsDownValue
        }
    }
}
