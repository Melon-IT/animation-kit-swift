//
//  MBaseIconLayer.swift
//  MelonAnimationKit
//
//  Created by Tomasz Popis on 29/02/16.
//  Copyright © 2016 Melon. All rights reserved.
//

import UIKit

public enum MIconHorizontalAligment: Int {
  case left
  case center
  case right
  
  public init() {
    self = .center
  }
}

public enum MIconVerticalAligment: Int {
  case top
  case center
  case bottom
  
  public init() {
    self = .center
  }
}

public protocol MIconDrawingDelegate {
  func draw(in _context: CGContext, frame: CGRect)
}

open class MBaseIconLayer: CALayer {
  
  open var drawingDelegate: MIconDrawingDelegate?
  
  open var factor: CGFloat
  open var offset: UIOffset
  open var aligment:(horizontal: MIconHorizontalAligment,vertical: MIconVerticalAligment)
  open var color: UIColor
  
  public init(width: CGFloat,
              factor: CGFloat,
              offset: UIOffset,
              aligment:(MIconHorizontalAligment, MIconVerticalAligment),
              color: UIColor,
              drawingDelegate: MIconDrawingDelegate? = nil) {
    
    self.factor = factor
    self.offset = offset
    self.aligment = aligment
    self.color = color
    self.drawingDelegate = drawingDelegate
    
    super.init()
    
    self.frame = CGRect(x: 0,
                        y: 0,
                        width: width,
                        height: width * self.factor)
    
    self.contentsScale = UIScreen.main.scale
  }
  
  public override  init() {
    self.factor = 1
    self.offset = UIOffset.zero
    self.aligment = (MIconHorizontalAligment(),MIconVerticalAligment())
    self.color = UIColor.clear

    
    super.init()
    
    self.frame = CGRect(x: 0,
                        y: 0,
                        width: 0,
                        height: 0)
    
    self.contentsScale = UIScreen.main.scale
  }
  
  public convenience init(width: CGFloat,  color: UIColor = UIColor.clear, factor: CGFloat = 1) {
    
    self.init(width: width,
              factor: factor,
              offset: UIOffset.zero,
              aligment:(MIconHorizontalAligment(),MIconVerticalAligment()),
              color: UIColor.clear)
  }
  
  public override init(layer: Any) {
    
    if let iconLayer = layer as? MBaseIconLayer {
      self.factor = iconLayer.factor
      self.offset = iconLayer.offset
      self.aligment = iconLayer.aligment
      self.color = iconLayer.color
      
      super.init(layer: layer)
      
      self.frame = iconLayer.frame
    } else {
      self.factor = 1
      self.offset = UIOffset.zero
      self.aligment = (MIconHorizontalAligment(),MIconVerticalAligment())
      self.color = UIColor.clear
      
      super.init(layer: layer)
      
      self.frame = (layer as? CALayer)?.frame ?? CGRect.zero
    }
  }
  
  open override func encode(with coder: NSCoder) {
    coder.encode(self.offset, forKey: "offset")
    coder.encode(self.factor, forKey: "factor")
    coder.encode(self.aligment.horizontal, forKey: "horizontal-aligmnet")
    coder.encode(self.aligment.vertical, forKey: "verticla-aligment")
    coder.encode(self.color, forKey: "color")
    
    super.encode(with: coder)
  }
  
  public required init?(coder aDecoder: NSCoder) {
    
    self.offset = aDecoder.decodeUIOffset(forKey: "offset")
    self.factor = CGFloat(aDecoder.decodeFloat(forKey: "factor"))
    let horizontal = aDecoder.decodeObject(forKey: "horizontal-aligmnet") as! MIconHorizontalAligment
    let vertical = aDecoder.decodeObject(forKey: "verticla-aligment") as! MIconVerticalAligment
    self.aligment = (horizontal, vertical)
    self.color = aDecoder.decodeObject(forKey: "color") as! UIColor
    
    super.init(coder: aDecoder)
  }
  
  open override func draw(in ctx: CGContext) {
    self.drawingDelegate?.draw(in: ctx, frame: self.frame)
  }
  
  open func align() {
    if let superFrame = self.superlayer?.frame {
      switch self.aligment.horizontal {
        case MIconHorizontalAligment.left:
          self.frame.origin.x = 0
          break
          
        case MIconHorizontalAligment.center:
          self.frame.origin.x = superFrame.width/2 - frame.width/2
          break
          
        case MIconHorizontalAligment.right:
          self.frame.origin.x = superFrame.width - frame.width
          break
      }
      
      switch self.aligment.vertical {
        case MIconVerticalAligment.top:
          break
          
        case MIconVerticalAligment.center:
          self.frame.origin.y = superFrame.height/2 - frame.height/2
          break
          
        case MIconVerticalAligment.bottom:
          self.frame.origin.y = superFrame.height - frame.height
          break
      }
      
      self.frame.origin.x += self.offset.horizontal
      self.frame.origin.y += self.offset.vertical
    }
  }
}
