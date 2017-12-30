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
  
  open var color: UIColor
  open var offset: UIOffset
  open private(set) var factor: CGFloat
  open var containerFrame: CGRect = CGRect.zero
  
  open var aligment: (horizontal: MBFIconHorizontalAligment, vertical: MBFIconVerticalAligment)
  
  public init(width: Float, factor: Float, color: UIColor, offset: UIOffset) {
    self.color = color
    self.offset = offset
    self.factor = CGFloat(factor)
    self.aligment = (MBFIconHorizontalAligment(),MBFIconVerticalAligment())
    
    super.init()
    let cgWidth = CGFloat(width)
    self.frame = CGRect(x: 0,
                        y: 0,
                        width: cgWidth,
                        height: cgWidth * self.factor)
    self.contentsScale = UIScreen.main.scale
  }
  
  public convenience init(width: Float) {
    self.init(width: width, factor: 1, color: UIColor.black, offset: UIOffset.zero)
  }
  
  public convenience init(width: Float, color: UIColor) {
    self.init(width: width, factor: 1, color: color, offset: UIOffset.zero)
  }
  
  required public init?(coder aDecoder: NSCoder) {
    self.color = UIColor.black
    self.offset = UIOffset.zero
    self.factor = 1
    self.aligment = (MBFIconHorizontalAligment(),MBFIconVerticalAligment())
    
    super.init(coder: aDecoder)
  }
  
  override public init(layer: Any) {
    self.color = UIColor.black
    self.offset = UIOffset.zero
    self.factor = 1
    self.aligment = (MBFIconHorizontalAligment(),MBFIconVerticalAligment())
    
    super.init(layer: layer)
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
