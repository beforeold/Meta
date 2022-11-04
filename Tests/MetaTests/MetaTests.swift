import XCTest
@testable import Meta

final class MetaTests: XCTestCase {
  /// test nest Metable in a generic type
  func testMetable() throws {
    struct Resp<T: Decodable>: Decodable {
      var v: String
      var data: T
    }
    
    struct Object: Codable {
      var name: String
      var age: Int
    }
    
    let jsonString = #"""
{
    "v": "1.0",
    "data": {
        "name": "brook",
        "age": 18
    }
}
"""#
    
    let data = jsonString.data(using: .utf8)!
    
    do {
      let resp = try JSONDecoder().decode(Resp<Metable<Object>>.self, from: data)
      XCTAssertEqual(resp.data.model.age, 18)
      XCTAssertEqual(resp.data.dict["age"] as? Int, 18)
      
      XCTAssertEqual(resp.data.model.name, "brook")
      XCTAssertEqual(resp.data.dict["name"] as? String, "brook")
    } catch {
      XCTFail("failed to decode \(error)")
    }
  }
  
  /// test Metable nested in a generic type as a prpertyWrapper
  func testMetableAsPropertyWrapper() throws {
    struct Resp<T: Decodable>: Decodable {
      var v: String
      
      @Metable
      var data: T
    }
    
    struct Object: Codable {
      var name: String
      var age: Int
    }
    
    let jsonString = #"""
{
    "v": "1.0",
    "data": {
        "name": "brook",
        "age": 18
    }
}
"""#
    
    let data = jsonString.data(using: .utf8)!
    
    do {
      let resp = try JSONDecoder().decode(Resp<Object>.self, from: data)
      XCTAssertEqual(resp.data.age, 18)
      XCTAssertEqual(resp.$data["age"] as? Int, 18)
      
      XCTAssertEqual(resp.data.name, "brook")
      XCTAssertEqual(resp.$data["name"] as? String, "brook")
    } catch {
      XCTFail("failed to decode \(error)")
    }
  }
}
