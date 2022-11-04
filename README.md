# Meta
A swift codable wrapper which supports codable for dictionary associated with a model

# Usage

Case 1: use as model + dictionary.
```Swift
struct Student: Decodable {
  struct Book: Decodable {
    var page: Int
  }
  
  @Metable
  var model: Book
}

// usage for model and dictionary
let book = student.book
let bookDictionary = student.$book

```

Case 2: declare a dictionary property, try:
```Swift
struct Foo: Decodable {
  @Metable
  var iamdict: EmptyModel
}

// usage for dictionary only
let dict = foo.$iamdict

```
