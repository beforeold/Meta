//
//  JSONCodingKeys.swift
//  
//
//  Created by beforeold on 2022/11/4.
//

import Foundation

/// https://stackoverflow.com/questions/44603248/how-to-decode-a-property-with-type-of-json-dictionary-in-swift-45-decodable-pr
public struct JSONCodingKeys: CodingKey {
  public var stringValue: String
  public var intValue: Int?
  
  public init?(stringValue: String) {
    self.stringValue = stringValue
  }
  
  public init?(intValue: Int) {
    self.init(stringValue: "\(intValue)")
    self.intValue = intValue
  }
  
  internal init(string: String) {
    self.stringValue = string
  }
}

