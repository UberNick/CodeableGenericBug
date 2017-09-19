import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let fooData = getDataFromFile("wrapped_foo"),
            let barData = getDataFromFile("wrapped_bar") else {
            return
        }
        
        let wrappedFoo = try? JSONDecoder().decode(GenericWrapper<Foo>.self, from: fooData)
        if let foo = wrappedFoo?.data {
            print(foo)
        }
    
        let wrappedBar = try? JSONDecoder().decode(GenericWrapper<Bar>.self, from: barData)
        if let bar = wrappedBar?.data {
            print(bar)
        }
    }

    func getDataFromFile(_ fileName: String) -> Data? {
        if let path = Bundle.main.url(forResource: fileName, withExtension: "json") {
            return try? Data(contentsOf: path)
        }
        return nil
    }
}

