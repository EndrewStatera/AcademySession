//
//  SKTexture+Array.swift
//  game-tutorial
//
//  Created by Endrew Soares on 16/10/25.
//

import Foundation
import SpriteKit

extension Array where Element == SKTexture {
    
    init (withFormat format: String, range: ClosedRange<Int>) {
        self = range.map({ (index) in
            let imageNamed = String(format: format, "\(index)")
            return SKTexture(imageNamed: imageNamed)
        })
    }
}
