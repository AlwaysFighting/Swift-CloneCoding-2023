import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var cityNameTextField: UITextField!
    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var wheatherDescription: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var maxTempLabel: UILabel!
    @IBOutlet weak var minTempLabel: UILabel!
    
    let manager = Manager()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(manager.apiKey)
    }
    
    
    @IBAction func tapFetchWheatherButton(_ sender: UIButton) {
        
    }
    
    func getCurrentWeather(cityName: String) {
        let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?q=\(cityName)&appid=")
    }
    


}

