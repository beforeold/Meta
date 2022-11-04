import XCTest
@testable import Meta

final class MetaTests: XCTestCase {
    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        // XCTAssertEqual(Meta().text, "Hello, World!")
        
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
}
