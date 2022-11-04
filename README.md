# Meta


use as model + dictionary
```Swift
struct Student: Decodable {
  struct Book {
    var page: Int
}
  
  @Metable
  var model: Book
}

// usage
let book = student.book
let bookDictionary = student.$book

```



if you want to delare a dictionary property, try:
```Swift
struct Foo: Decodable {
  @Metable
  var iamdict: EmptyModel
}

// usage
let dict = foo.$iamdict

```
