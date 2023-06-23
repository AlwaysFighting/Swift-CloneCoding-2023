import UIKit

enum Operation {
    case Add
    case Subtract
    case Divide
    case Multiply
    case unknown
}

class ViewController: UIViewController {

    @IBOutlet weak var numberOutletLabel: UILabel!
    
    var displayNumber = ""
    var firstOperand = ""
    var secondOperand = ""
    var result = ""
    var currentOperation: Operation = .unknown
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    
    @IBAction func tapNumberBtn(_ sender: UIButton) {
        guard let numberValue = sender.titleLabel?.text else { return }
        if self.displayNumber.count < 9 {
            self.displayNumber += numberValue
            self.numberOutletLabel.text = self.displayNumber
        }
    }
    
    @IBAction func tapClearBtn(_ sender: UIButton) {
        self.displayNumber = ""
        self.firstOperand = ""
        self.secondOperand = ""
        self.result = ""
        self.currentOperation = .unknown
        self.numberOutletLabel.text = "0"
    }
    
    
    @IBAction func tapDotBtn(_ sender: UIButton) {
        if self.displayNumber.count < 8, !self.displayNumber.contains(".") {
            self.displayNumber += self.displayNumber.isEmpty ? "0." : "."
            self.numberOutletLabel.text = self.displayNumber
        }
    }
    
    @IBAction func tapDivideBtn(_ sender: UIButton) {
        self.operation(.Divide)
    }
    
    
    @IBAction func tapMultipluBtn(_ sender: UIButton) {
        self.operation(.Multiply)
    }
    
    
    @IBAction func tapSubtractBtn(_ sender: UIButton) {
        self.operation(.Subtract)
    }
    
    @IBAction func tapAddBtn(_ sender: UIButton) {
        self.operation(.Add)
    }
    
    @IBAction func tapEqualBtn(_ sender: UIButton) {
        self.operation(self.currentOperation)
    }
    
    func operation(_ operation: Operation) {
      if self.currentOperation != .unknown {
        if !self.displayNumber.isEmpty {
          self.secondOperand = self.displayNumber
          self.displayNumber = ""

          guard let firstOperand = Double(self.firstOperand) else { return }
          guard let secondOperand = Double(self.secondOperand) else { return }

          switch self.currentOperation {
          case .Add:
            self.result = "\(firstOperand + secondOperand)"

          case .Subtract:
            self.result = "\(firstOperand - secondOperand)"

          case .Divide:
            self.result = "\(firstOperand / secondOperand)"

          case .Multiply:
            self.result = "\(firstOperand * secondOperand)"

          default:
            break
          }

          if let result = Double(self.result), result.truncatingRemainder(dividingBy: 1) == 0 {
            self.result = "\(Int(result))"
          }
          self.firstOperand = self.result
          self.numberOutletLabel.text = self.result
        }
        self.currentOperation = operation
      } else {
        self.firstOperand = self.displayNumber
        self.currentOperation = operation
        self.displayNumber = ""
      }
    }
    
}

