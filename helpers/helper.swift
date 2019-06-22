//
//  helper.swift
//  codetechniqDemo
//
//  Created by Wiem Ben Rim on 6/16/19.
//  Copyright © 2019 Wiem Ben Rim. All rights reserved.
//
import CoreGraphics
import Foundation
import SpriteKit

class Helper {
    //Please look at the described steps in the github demo to understand better what is happening here
    static func findLaserBallDestination(touchPoint: CGPoint, heroLocation: CGPoint) -> CGPoint?{
        let offset = touchPoint - heroLocation
        if offset.x < 0 { return nil}
        let direction = offset.normalized()
        let shootAmount = direction * 1000
        let realDest = shootAmount + heroLocation
        return realDest
    }
}

extension CGPoint {
    func length() -> CGFloat {
        return sqrt(x*x + y*y)
    }
    
    func normalized() -> CGPoint {
        return self / length()
    }
    static func +(left: CGPoint, right: CGPoint) -> CGPoint {
        return CGPoint(x: left.x + right.x, y: left.y + right.y)
    }
    
    static func -(left: CGPoint, right: CGPoint) -> CGPoint {
        return CGPoint(x: left.x - right.x, y: left.y - right.y)
    }
    
    static func *(point: CGPoint, scalar: CGFloat) -> CGPoint {
        return CGPoint(x: point.x * scalar, y: point.y * scalar)
    }
    
    static func /(point: CGPoint, scalar: CGFloat) -> CGPoint {
        return CGPoint(x: point.x / scalar, y: point.y / scalar)
    }
}
extension GameScene: SKPhysicsContactDelegate {
    /*func didBegin(_ contact: SKPhysicsContact) {
        // 1
        var firstBody: SKPhysicsBody
        var secondBody: SKPhysicsBody
        if contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask {
            firstBody = contact.bodyA
            secondBody = contact.bodyB
        } else {
            firstBody = contact.bodyB
            secondBody = contact.bodyA
        }
        
        // 2
        if ((firstBody.categoryBitMask & PhysicsCategory.bug != 0) &&
            (secondBody.categoryBitMask & PhysicsCategory.projectile != 0)) {
            if let bug = firstBody.node as? SKSpriteNode,
                let projectile = secondBody.node as? SKSpriteNode {
                LaserBallDidCollideWithBug(laserBall: laserBall, bug: bug)
            }
        }
    }
    */
}
