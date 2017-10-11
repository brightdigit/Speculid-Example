//
//  Service.swift
//  xpc-service
//
//  Created by Leo Dion on 10/9/17.
//  Copyright © 2017 Leo Dion. All rights reserved.
//

import Cocoa
import CairoSVG

public final class Service: NSObject, ServiceProtocol {
  public func multiply(_ value: Double, by factor: Double, withReply reply: (Double) -> Void) {
    if let url = Bundle(for: Service.self).url(forResource: "layers", withExtension: "svg") {
      
    let geometry = GeometryDimension(value: 50, dimension: .width)
    if let imageHandle = try? ImageHandleBuilder.shared().imageHandle(from: url) {
    
    try? CairoInterface.exportImage(imageHandle, to: Bundle.main.bundleURL.deletingLastPathComponent().appendingPathComponent("layers.png"), withDimensions: geometry, shouldRemoveAlphaChannel: true, setBackgroundColor: CGColor.init(red: 1, green: 0, blue: 1, alpha: 1))
    
    }
    }
    reply(value * factor)
  }
  
  
}
