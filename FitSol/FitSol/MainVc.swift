//
//  MainVc.swift
//  FitSol
//
//  Created by Berat Ölekli on 8.10.2024.
//

import UIKit

class MainVc: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    
    @IBOutlet weak var tblView: UITableView!
    
    // Leaderboard verileri (isim ve puanlar)
        var leaderboardData: [LeaderboardEntry] = [
            LeaderboardEntry(name: "John", score: 200),
            LeaderboardEntry(name: "Alice", score: 350),
            LeaderboardEntry(name: "Bob", score: 150),
            LeaderboardEntry(name: "Chris", score: 400),
            LeaderboardEntry(name: "Eva", score: 250)
        ]
        
        override func viewDidLoad() {
            super.viewDidLoad()
            
            overrideUserInterfaceStyle = .light
            // Delegate ve DataSource bağlantılarını yapalım
            tblView.delegate = self
            tblView.dataSource = self
        }
        
        // MARK: - UITableViewDataSource Metotları
        
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return leaderboardData.count
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            // Hücreyi deque işlemiyle alalım
            let cell = tableView.dequeueReusableCell(withIdentifier: "leadCell", for: indexPath) as! TableVCCell
            
            // Sıralama verisini alalım
            let entry = leaderboardData[indexPath.row]
            
            // Hücredeki label ve butonları güncelleyelim
            cell.lblCell.text = "\(entry.score) Puan"
            cell.btnCell.setTitle("\(indexPath.row + 1). \(entry.name)", for: .normal)
            
            return cell
        }
        
        // MARK: - UITableViewDelegate (Eğer hücreye tıklama eklemek istersen)
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            print("Selected row: \(indexPath.row), Name: \(leaderboardData[indexPath.row].name)")
        }
    
    
}
