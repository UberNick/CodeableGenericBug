import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let fooData = getDataFromFile("wrapped_foo"),
            let barData = getDataFromFile("wrapped_bar") else {
            return
        }
        
        let wrappedFoo1 = try? JSONDecoder().decode(FooWrapper<Foo>.self, from: fooData)
        if let foo1 = wrappedFoo1?.data {
            print(foo1)
        }
        
        let wrappedBar1 = try? JSONDecoder().decode(BarWrapper<Bar>.self, from: barData)
        if let bar1 = wrappedBar1?.data {
            print(bar1)
        }

        let wrappedFoo2 = try? JSONDecoder().decode(GenericWrapper<Foo>.self, from: fooData)
        if let foo2 = wrappedFoo2?.data {
            print(foo2)
        }
        
        let wrappedBar2 = try? JSONDecoder().decode(GenericWrapper<Bar>.self, from: barData)
        if let bar2 = wrappedBar2?.data {
            print(bar2)
        }
    }

    func getDataFromFile(_ fileName: String) -> Data? {
        if let path = Bundle.main.url(forResource: fileName, withExtension: "json") {
            return try? Data(contentsOf: path)
        }
        return nil
    }
}

