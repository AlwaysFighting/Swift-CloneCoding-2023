import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var cityNameTextField: UITextField!
    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var wheatherDescription: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var maxTempLabel: UILabel!
    @IBOutlet weak var minTempLabel: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    
    @IBAction func tapFetchWheatherButton(_ sender: UIButton) {
        
    }
    
    func getCurrentWeather(cityName: String) {
        let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?q=\(cityName)&appid=")
    }
    


}

