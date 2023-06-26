import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var cityNameTextField: UITextField!
    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var wheatherDescription: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var maxTempLabel: UILabel!
    @IBOutlet weak var minTempLabel: UILabel!
    @IBOutlet weak var weatherStackView: UIStackView!
    
    
    let api_key = Manager().apiKey
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    @IBAction func tapFetchWheatherButton(_ sender: UIButton) {
        if let cityName = self.cityNameTextField.text {
            self.getCurrentWeather(cityName: cityName)
            self.view.endEditing(true)
        }
    }
    
    func getCurrentWeather(cityName: String) {
        
        guard let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?q=\(cityName)&appid=\(api_key)") else { return }

        let session = URLSession(configuration: .default)

        session.dataTask(with: url) { [weak self] data, response, error in
            let successRange = (200..<300)
            
            guard let data = data, error == nil else { return }
            let decoder = JSONDecoder()
            if let response = response as? HTTPURLResponse, successRange.contains(response.statusCode) {
                guard let weatherInformation = try? decoder.decode(WheatherInformation.self, from: data) else { return }
                DispatchQueue.main.async {
                    self?.weatherStackView.isHidden = false
                    self?.configureView(weatherInformation: weatherInformation)
                }
            } else {
                guard let errorMsg = try? decoder.decode(ErrorMSG.self, from: data) else { return }
                DispatchQueue.main.async {
                    self?.showAlert(message: errorMsg.message)
                }
            }
        }.resume()
    }

    func configureView(weatherInformation : WheatherInformation) {
        self.cityNameLabel.text = weatherInformation.name
        if let weather = weatherInformation.weather.first {
            self.wheatherDescription.text = weather.description
        }
        self.tempLabel.text = "\(Int(weatherInformation.temp.temp - 273.15))°C"
        self.minTempLabel.text = "최저: \(Int(weatherInformation.temp.minTemp - 273.15))°C"
        self.maxTempLabel.text = "최고: \(Int(weatherInformation.temp.maxTemp - 273.15))°C"
    }
    
    func showAlert(message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "확인", style: .default))
        self.present(alert, animated: true)
    }
    
}

