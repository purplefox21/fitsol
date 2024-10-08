//
//  ProgVC.swift
//  FitSol
//
//  Created by Berat Ölekli on 8.10.2024.
//

import UIKit
import CoreMotion


class ProgVC: UIViewController {
    
    @IBOutlet weak var timerLabel: UILabel!
    
    @IBOutlet weak var scoreLabel: UILabel!
    
    
    var shapeLayer = CAShapeLayer()
    var trackLayer = CAShapeLayer()
    
    var timer: Timer?
    var totalTime = 100  // 2 dakika (120 saniye)
    var remainingTime = 100  // Geri sayım için anlık zaman
    
    
    var motionManager = CMMotionManager()
       var score = 0
       var lastUpdateTime: TimeInterval = 0
    
    
   
    @IBAction func btnFnsh(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        createCircularProgressBar()
        startTimer()
        startMotionUpdates()
        
    }
    
    
    
    
    
    
    
    func createCircularProgressBar() {
            // TimerLabel'in merkezini kullanarak çemberi yerleştirme
        let circularPath = UIBezierPath(arcCenter: CGPoint(x: timerLabel.frame.midX, y: timerLabel.frame.midY + 50), radius: 140, startAngle: -CGFloat.pi / 2, endAngle: 2 * CGFloat.pi, clockwise: true)
            
            // Track çemberi (arka plan)
            trackLayer.path = circularPath.cgPath
            trackLayer.strokeColor = UIColor.lightGray.cgColor
            trackLayer.lineWidth = 20
            trackLayer.fillColor = UIColor.clear.cgColor
            trackLayer.lineCap = .round
            view.layer.addSublayer(trackLayer)
            
            // İlerleyen çember
            shapeLayer.path = circularPath.cgPath
            shapeLayer.strokeColor = UIColor(hex: "#14F195").cgColor
            shapeLayer.lineWidth = 20
            shapeLayer.fillColor = UIColor.clear.cgColor
            shapeLayer.lineCap = .round
            shapeLayer.strokeEnd = 0
            view.layer.addSublayer(shapeLayer)
        }
    
    func startTimer() {
            timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
        }
        
        @objc func updateTimer() {
            if remainingTime > 0 {
                remainingTime -= 1
                
                let minutes = remainingTime / 60
                let seconds = remainingTime % 60
                timerLabel.text = String(format: "%02d:%02d", minutes, seconds)
                
                // Progresi doğru oranla güncelle
                let progress = Float(totalTime - remainingTime) / Float(totalTime)
                shapeLayer.strokeEnd = CGFloat(progress)
            } else {
                timer?.invalidate()
                timerLabel.text = "Time's Up!"
                shapeLayer.strokeEnd = 1
            }
        }
    
    
    func startMotionUpdates() {
            // İvmeölçer aktif mi kontrol edin
            if motionManager.isAccelerometerAvailable {
                motionManager.accelerometerUpdateInterval = 0.1 // Her 0.1 saniyede bir güncelleme
                
                motionManager.startAccelerometerUpdates(to: OperationQueue.main) { (data, error) in
                    if let accelerometerData = data {
                        self.handleMotionData(accelerometerData)
                    }
                }
            }
        }
        
        func handleMotionData(_ accelerometerData: CMAccelerometerData) {
            let acceleration = accelerometerData.acceleration
            let magnitude = sqrt(pow(acceleration.x, 2) + pow(acceleration.y, 2) + pow(acceleration.z, 2))
            
            // Belirli bir eşik değeri üzerinde bir hareket algılandığında puan verelim
            if magnitude > 1.5 { // Titreme algılama için eşik değer, artırılabilir ya da azaltılabilir
                    score += 10
                    scoreLabel.text = "\(score) FP"
                    
                
            }
        }
    
    
    
}


extension UIColor {
    convenience init(hex: String) {
        var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        hexSanitized = hexSanitized.replacingOccurrences(of: "#", with: "")

        var rgb: UInt64 = 0
        Scanner(string: hexSanitized).scanHexInt64(&rgb)

        let red = CGFloat((rgb & 0xFF0000) >> 16) / 255.0
        let green = CGFloat((rgb & 0x00FF00) >> 8) / 255.0
        let blue = CGFloat(rgb & 0x0000FF) / 255.0

        self.init(red: red, green: green, blue: blue, alpha: 1.0)
    }
}
