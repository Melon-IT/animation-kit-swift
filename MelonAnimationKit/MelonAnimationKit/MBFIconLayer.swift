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

public protocol MBFIconDrawingDelegate {
  func drawIn(context: CGContext, frame: CGRect)
}

open class MBFIconLayer: CALayer {
  
  open var color: UIColor = UIColor.black
  open var factor: CGFloat {
    return 1
  }
  open var offset: UIOffset = UIOffset.zero
  
  open var drawingDelegate: MBFIconDrawingDelegate?
  
  open var aligment: (horizontal: MBFIconHorizontalAligment, vertical: MBFIconVerticalAligment) = (MBFIconHorizontalAligment(),MBFIconVerticalAligment())
  
  public init(width: CGFloat) {
    self.aligment = (MBFIconHorizontalAligment(),MBFIconVerticalAligment())
    
    super.init()
    self.frame = CGRect(x: 0,
                        y: 0,
                        width: width,
                        height: width * self.factor)
    self.contentsScale = UIScreen.main.scale
  }
  
  public override init(layer: Any) {
    if let iconLayer = layer as? MBFIconLayer {
      self.color = iconLayer.color
      self.offset = iconLayer.offset
      self.aligment = iconLayer.aligment
    }
    super.init(layer: layer)
  }
  
  public required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }
  
  open override func draw(in ctx: CGContext) {
    self.drawingDelegate?.drawIn(context: ctx, frame: self.frame)
  }
  
  open func align() {
    
    if let superFrame = self.superlayer?.frame {
      
      switch self.aligment.horizontal {
      case MBFIconHorizontalAligment.left:
        self.frame.origin.x = 0
        break
        
      case MBFIconHorizontalAligment.center:
        self.frame.origin.x = superFrame.width/2 - frame.width/2
        break
        
      case MBFIconHorizontalAligment.right:
        self.frame.origin.x = superFrame.width - frame.width
        break
      }
      
      switch self.aligment.vertical {
      case MBFIconVerticalAligment.top:
        break
        
      case MBFIconVerticalAligment.center:
        self.frame.origin.y = superFrame.height/2 - frame.height/2
        break
        
      case MBFIconVerticalAligment.bottom:
        self.frame.origin.y = superFrame.height - frame.height
        break
      }
      
      self.frame.origin.x += self.offset.horizontal
      self.frame.origin.y += self.offset.vertical
    }
  }
}
