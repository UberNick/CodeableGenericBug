import XCTest
@testable import CodableGenericBug

class CodableGenericBugTests: XCTestCase {
    
    let comparisonFoo = Foo(name: "Fooey McFooface", age: 23) // What decoded "Foo" object should look like
    let comparisonBar = Bar(title: "Barry McBarface", msrp: 3.50) // What decoded "Bar" object should look like
    var fooData: Data? = nil // Raw coded JSON data representing "Foo" but wrapped in a container
    var barData: Data? = nil // Raw coded JSON data representing "Bar" but wrapped in a container
    
    
    override func setUp() {
        super.setUp()
        fooData = getDataFromFile("wrapped_foo")
        barData = getDataFromFile("wrapped_bar")
    }
    
    // ---- WORKING COMPARISON -----
    // Test deserialization when using explicit "Foo" and "Bar" model wrappers.  Works fine.
    func testExplicitWrappers() {
        guard let wrappedFoo = try? JSONDecoder().decode(FooWrapper<Foo>.self, from: fooData!),
            let wrappedBar = try? JSONDecoder().decode(BarWrapper<Bar>.self, from: barData!) else {
            XCTFail("Unable to decode JSON file")
            return
        }
        
        let foo = wrappedFoo.data.attributes
        let bar = wrappedBar.data.attributes
        
        XCTAssertEqual(foo.name, comparisonFoo.name)
        XCTAssertEqual(foo.age, comparisonFoo.age)
        XCTAssertEqual(bar.title, comparisonBar.title)
        XCTAssertEqual(bar.msrp, comparisonBar.msrp)
    }
    
    // ---- BROKEN PIECE -----
    // Test deserialization when using generic "Foo" and "Bar" model wrappers.
    // Should work and behave in same manner as using explicit wrappers (above), but this fails
    func testGenericWrapper() {
        guard let wrappedFoo = try? JSONDecoder().decode(GenericWrapper<Foo>.self, from: fooData!),
            let wrappedBar = try? JSONDecoder().decode(GenericWrapper<Bar>.self, from: barData!) else {
                XCTFail("Unable to decode JSON file")
                return
        }
        
        let foo = wrappedFoo.data.attributes
        let bar = wrappedBar.data.attributes
        
        XCTAssertEqual(foo.name, comparisonFoo.name)
        XCTAssertEqual(foo.age, comparisonFoo.age)
        XCTAssertEqual(bar.title, comparisonBar.title)
        XCTAssertEqual(bar.msrp, comparisonBar.msrp)
    }
    
    // ---- WORKAROUND FIX -----
    func testExternalizedGenericWrapper() {
        guard let wrappedFoo = try? JSONDecoder().decode(ExternalizedGenericWrapper<Foo>.self, from: fooData!),
            let wrappedBar = try? JSONDecoder().decode(ExternalizedGenericWrapper<Bar>.self, from: barData!) else {
                XCTFail("Unable to decode JSON file")
                return
        }
        
        let foo = wrappedFoo.data.attributes
        let bar = wrappedBar.data.attributes
        
        XCTAssertEqual(foo.name, comparisonFoo.name)
        XCTAssertEqual(foo.age, comparisonFoo.age)
        XCTAssertEqual(bar.title, comparisonBar.title)
        XCTAssertEqual(bar.msrp, comparisonBar.msrp)
    }
    
    private func getDataFromFile(_ fileName: String) -> Data? {
        if let path = Bundle.main.url(forResource: fileName, withExtension: "json") {
            return try? Data(contentsOf: path)
        }
        return nil
    }
}
