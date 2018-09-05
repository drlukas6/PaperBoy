import UIKit


struct User {
    var name = "test" {
        didSet {
            print("nesta")
        }
    }
}

var u = User() {
    didSet {
        print("setttt")
    }
}
print(1)
u.name = "tornjaj"

