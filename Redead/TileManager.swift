//
//  TileManager.swift
//  Redead
//
//  Created by Matthew Genova on 7/26/16.
//  Copyright © 2016 Matthew Genova. All rights reserved.
//

import Foundation

class TileManager{
    static let instance = TileManager()
    var tileMap: JSTileMap? = nil
    
    func setTileMap(map: JSTileMap){
        self.tileMap = map
    }
    
}