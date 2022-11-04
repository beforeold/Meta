

import Foundation

// MARK: - Metable Codable
/// an empty model WITHOUT any property
public struct EmptyModel: Codable {
  private init() { }
  
  /// use shared instance, just like NSNull.null
  public static let shared = EmptyModel()
}

/// a wrapper which decode json with both model and dict as results
@propertyWrapper
public struct Metable<Model: Decodable> {
  public var model: Model
  public var dict: [String: Any]
  
  /// create a new instance with model and dictionary, the dictionay is expecting more info then the model
  public init(model: Model, dict: [String: Any]) {
    self.model = model
    self.dict = dict
  }
  
  /// support direct acccess the model, such as student.book, instead of student.brook.model
  public var wrappedValue: Model {
    get {
      self.model
    }
    
    set {
      self.model = newValue
    }
  }
  
  /// support $ sign. like student.$book, instead of student.book.dict
  public var projectedValue: [String: Any] {
    return self.dict
  }
}

extension Metable: Decodable {
  public init(from decoder: Decoder) throws {
    // decode model ...
    if Model.self == EmptyModel.self {
      self.model = EmptyModel.shared as! Model
    } else {
      self.model = try decoder.singleValueContainer().decode(Model.self)
    }
    
    // decode dict ...
    let container = try decoder.container(keyedBy: JSONCodingKeys.self)
    self.dict = try container.decode([String: Any].self)
  }
}

extension Metable: Encodable {
  public func encode(to encoder: Encoder) throws {
    if dict.isEmpty {
      // if dict is empty, try to cast and encode the model
      if let encodableModel = model as? Encodable {
        var container = encoder.singleValueContainer()
        try container.encode(encodableModel)
        return
      }
    }
    
    // encode with the dictionary instead of model
    var container = encoder.container(keyedBy: JSONCodingKeys.self)
    try container.encode(dict)
  }
}

/// typealias for Metable without any model
public typealias MetaDict = Metable<EmptyModel>
