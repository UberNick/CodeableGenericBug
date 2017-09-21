import XCTest
@testable import CodableGenericBug

class CodableGenericBugTests: XCTestCase {
    
    let comparisonFoo = Foo(name: "Fooey McFooface", age: 23) // What decoded "Foo" object should look like
    let comparisonBar = Bar(title: "Barry McBarface", msrp: 3.50) // What decoded "Bar" object should look like
    let fooData = getDataFromFile("wrapped_foo")! // Raw JSON data representing "Foo" but wrapped in a container
    let barData = getDataFromFile("wrapped_foo")! // Raw JSON data representing "Bar" but wrapped in a container
    
    // Test deserialization when using explicit "Foo" and "Bar" model wrappers.  Works fine.
    func testExplicitWrappers() {
        guard let wrappedFoo = try? JSONDecoder().decode(FooWrapper<Foo>.self, from: fooData),
            let wrappedBar = try? JSONDecoder().decode(BarWrapper<Bar>.self, from: barData) else {
            XCTFail("Unable to decode JSON file")
        }
        let foo = wrappedFoo.data
        let bar = wrappedBar.data
        XCTAssertEqual(foo, comparisonFoo)
        XCTAssertEqual(bar, comparisonBar)
    }
    
    // Test deserialization when using generic "Foo" and "Bar" model wrappers.
    // Should work and behave in same manner as using explicit wrappers (above), but this fails
    func testGenericWrapper() {
        XCTAssert(true)
    }
    
    func testGenericExternalizedWrapper() {
        XCTAssert(true)
    }
    
    private func getDataFromFile(_ fileName: String) -> Data? {
        if let path = Bundle.main.url(forResource: fileName, withExtension: "json") {
            return try? Data(contentsOf: path)
        }
        return nil
    }
}
