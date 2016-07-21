//
//  Helper.swift
//  Redead
//
//  Created by Matthew Genova on 7/21/16.
//  Copyright © 2016 Matthew Genova. All rights reserved.
//

import SpriteKit

class Helper{
    static let sceneCoordinatesWidth:CGFloat = 1024.0
    static let sceneCoordinatesHeight:CGFloat = 768.0
    static var visibleScreen = CGRect()
    
    //Returns a CGRect that has the dimensions and position for any device with respect to any specified scene. This will result in a boundary that can be utilised for positioning nodes on a scene so that they are always visible
    static func getVisibleScreen(viewWidth: Float, viewHeight: Float) -> CGRect {
        var x: Float = 0
        var y: Float = 0
        var sceneWidth = Float(sceneCoordinatesWidth)
        var sceneHeight = Float(sceneCoordinatesHeight)
        
        let deviceAspectRatio = viewWidth/viewHeight
        let sceneAspectRatio = sceneWidth/sceneHeight
        
        //If the the device's aspect ratio is smaller than the aspect ratio of the preset scene dimensions, then that would mean that the visible width will need to be calculated
        //as the scene's height has been scaled to match the height of the device's screen. To keep the aspect ratio of the scene this will mean that the width of the scene will extend
        //out from what is visible.
        //The opposite will happen in the device's aspect ratio is larger.
        if deviceAspectRatio < sceneAspectRatio {
            let newSceneWidth: Float = (sceneWidth * viewHeight) / sceneHeight
            let sceneWidthDifference: Float = (newSceneWidth - viewWidth)/2
            let diffPercentageWidth: Float = sceneWidthDifference / (newSceneWidth)
            
            //Increase the x-offset by what isn't visible from the lrft of the scene
            x = diffPercentageWidth * sceneWidth
            //Multipled by 2 because the diffPercentageHeight is only accounts for one side(e.g right or left) not both
            sceneWidth = sceneWidth - (diffPercentageWidth * 2 * sceneWidth)
        } else {
            let newSceneHeight: Float = (sceneHeight * viewWidth) / sceneWidth
            let sceneHeightDifference: Float = (newSceneHeight - viewHeight)/2
            let diffPercentageHeight: Float = fabs(sceneHeightDifference / (newSceneHeight))
            
            //Increase the y-offset by what isn't visible from the bottom of the scene
            y = diffPercentageHeight * sceneHeight
            //Multipled by 2 because the diffPercentageHeight is only accounts for one side(e.g top or bottom) not both
            sceneHeight = sceneHeight - (diffPercentageHeight * 2 * sceneHeight)
        }
        
        let visibleScreenOffset = CGRect(x: CGFloat(x), y: CGFloat(y), width: CGFloat(sceneWidth), height: CGFloat(sceneHeight))
        visibleScreen = visibleScreenOffset
        return visibleScreenOffset
    }

}