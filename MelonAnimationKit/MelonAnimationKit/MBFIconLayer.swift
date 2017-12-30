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
  
  open var color: UIColor = UIColor.black
  open var offset: UIOffset = UIOffset.zero
  open private(set) var factor: CGFloat = 1
  open var containerFrame: CGRect = CGRect.zero
  
  open var aligment: (horizontal: MBFIconHorizontalAligment, vertical: MBFIconVerticalAligment) = (MBFIconHorizontalAligment(),MBFIconVerticalAligment())
  
  public init(width: CGFloat, factor: CGFloat, color: UIColor, offset: UIOffset) {
    self.color = color
    self.offset = offset
    self.factor = factor
    self.aligment = (MBFIconHorizontalAligment(),MBFIconVerticalAligment())
    
    super.init()
    self.frame = CGRect(x: 0,
                        y: 0,
                        width: width,
                        height: width * self.factor)
    self.contentsScale = UIScreen.main.scale
  }
  
  public convenience override init() {
    self.init(width: 0, factor: 1, color: UIColor.black, offset: UIOffset.zero)
  }
  public convenience init(width: CGFloat) {
    self.init(width: width, factor: 1, color: UIColor.black, offset: UIOffset.zero)
  }
  
  public convenience init(width: CGFloat, color: UIColor) {
    self.init(width: width, factor: 1, color: color, offset: UIOffset.zero)
  }

  public override init(layer: Any) {
    if let iconLayer = layer as? MBFIconLayer {
      self.color = iconLayer.color
      self.offset = iconLayer.offset
      self.factor = iconLayer.factor
      self.aligment = iconLayer.aligment
    }
    super.init(layer: layer)
  }
  
  public required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
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
