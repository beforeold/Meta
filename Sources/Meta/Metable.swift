

import Foundation

// MARK: - Meta Codable
/// an empty model WITHOUT any property
public struct EmptyModel: Codable {
    private init() { }
    
    /// use shared instance, just like NSNull.null
    public static let shared = EmptyModel()
}

/// a wrapper which decode json with both model and dict as results
public struct Metable<Model: Decodable> {
    public var model: Model
    public var dict: [String: Any]
    
    public init(model: Model, dict: [String: Any]) {
        self.model = model
        self.dict = dict
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
        // encode with the dictionary instead of model
        var container = encoder.container(keyedBy: JSONCodingKeys.self)
        try container.encode(dict)
    }
}

/// typealias for Meta without amy model
public typealias MetaDict = Metable<EmptyModel>
