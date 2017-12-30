//
//  MBFIconLayer.swift
//  MelonAnimationKit
//
//  Created by Tomasz Popis on 29/02/16.
//  Copyright © 2016 Melon. All rights reserved.
//

import UIKit

public enum MBFIconHorizontalAligment: Int {
  case left
  case center
  case right
  
  public init() {
    self = .center
  }
}

public enum MBFIconVerticalAligment: Int {
  case top
  case center
  case bottom
  
  public init() {
    self = .center
  }
}

open class MBFIconLayer: CALayer {
  
  open var color = UIColor.white
  open var offset = UIOffset()
  
  open var factor: CGFloat {
    get {
      return CGFloat(1)
    }
  }
  
  open var containerFrame = CGRect.zero
  
  override public init(layer: Any) {
    super.init(layer: layer)
  }
  
  open var aligment: (horizontal: MBFIconHorizontalAligment, vertical: MBFIconVerticalAligment) =
    (MBFIconHorizontalAligment(),MBFIconVerticalAligment())
  

  
  required public init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }
  
  public override init() {
    super.init()
    self.contentsScale = UIScreen.main.scale
  }
  
  public init(width: CGFloat) {
    super.init()
    
    self.contentsScale = UIScreen.main.scale
    self.frame = CGRect(x: 0,
                        y: 0,
                        width: width,
                        height: width * self.factor)
  }
  
  public convenience init(width: CGFloat, color: UIColor) {
    self.init(width: width)
    
    self.color = color
  }
  
  open func align() {
    
    var frame = self.frame
    
    switch self.aligment.horizontal {
      
    case MBFIconHorizontalAligment.left:
      frame.origin.x = 0
      break
      
    case MBFIconHorizontalAligment.center:
      frame.origin.x = self.containerFrame.width/2 - frame.width/2
      break
      
    case MBFIconHorizontalAligment.right:
      frame.origin.x = self.containerFrame.width - frame.width
      break
    }
    
    switch self.aligment.vertical {
    case MBFIconVerticalAligment.top:
      break
      
    case MBFIconVerticalAligment.center:
      frame.origin.y = self.containerFrame.height/2 - frame.height/2
      break
      
    case MBFIconVerticalAligment.bottom:
      frame.origin.y = self.containerFrame.height - frame.height
      break
    }
    
    frame.origin.x += self.offset.horizontal
    frame.origin.y += self.offset.vertical
    
    self.frame = frame
  }
}
