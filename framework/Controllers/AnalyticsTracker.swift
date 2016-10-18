//
//  AnalyticsTracker.swift
//  speculid
//
//  Created by Leo Dion on 10/17/16.
//
//

import Foundation

public enum AnalyticsHitType : String, CustomStringConvertible {
  case timing = "timing", event = "event"
  
  public var description: String {
    return self.rawValue
  }
}

public struct AnalyticsEvent : AnalyticsEventProtocol {
  public let category: String
  public let action: String
  public let label: String?
  public let value: String?
  
  public init (category: String, action: String, label: String? = nil, value: String? = nil) {
    self.category = category
    self.action = action
    self.label = label
    self.value = value
  }
}

public struct AnalyticsTracker : AnalyticsTrackerProtocol {
  public func track(event: AnalyticsEventProtocol) {
    var parameters = configuration.parameters
    
    parameters[.hitType] = AnalyticsHitType.event
    parameters[.eventCategory] = event.category
    parameters[.eventAction] = event.action
    
    if let label = event.label {
      parameters[.eventLabel] = label
    }
    
    if let value = event.value {
      parameters[.eventValue] = value
    }
    
    sessionManager.send(parameters)
  }

  let configuration : AnalyticsConfigurationProtocol
  let sessionManager : AnalyticsSessionManagerProtocol
  
  public func track(time: TimeInterval, withCategory category: String?, withLabel label: String?) {
    var parameters = configuration.parameters
    
    parameters[.hitType] = AnalyticsHitType.timing
    if let category = category {
      parameters[.userTimingCategory] = category
    }
    if let label = label {
      parameters[.userTimingLabel] = label
    }
    parameters[.timing] = time
    
    print(parameters)
    
    sessionManager.send(parameters)
  }
}
