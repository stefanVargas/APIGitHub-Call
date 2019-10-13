//
//  SizeHandler.swift
//  APIGitHubCall
//
//  Created by Stefan V. de Moraes on 10/10/19.
//  Copyright © 2019 Stefan V. de Moraes. All rights reserved.
//

import Foundation
import UIKit

class SizeHandler {
    
    var height: CGFloat
    var width: CGFloat
    
    enum PositionDimension {
        
        case height
        case width
    }
    
    
    init(view: UIView) {
        
        self.height = view.frame.height
        self.width  = view.frame.width
        
    }
    
    init(size: CGSize) {
        
        self.height = size.height
        self.width  = size.width
        
    }
    
    init(){
        let screenBounds = UIScreen.main.bounds
        
        self.height = screenBounds.height
        self.width  = screenBounds.width
    }
    
    func percentOfFrame(percent: CGFloat, dimension: PositionDimension ) -> CGFloat {
        
        switch dimension {
        case .width:
            return width * percent/100
        case .height:
            return height * percent/100
        }
    }
    
    func frameDivided(In part: CGFloat, dimension: PositionDimension ) -> CGFloat {
        
        switch dimension {
        case .width:
            return width / part
        case .height:
            return height / part
        }
    }
    
    func quarterFrame(dimension: PositionDimension) -> CGFloat {
        
        switch dimension {
        case .width:
            return width / 4
        case .height:
            return height / 4
        }
    }
    
    func halfFrame(dimension: PositionDimension) -> CGFloat {
        
        switch dimension {
        case .width:
            return width / 2
        case .height:
            return height / 2
        }
    }
}
