//
//  ViewControllerTableExtentions.swift
//  ViewControllerTableExtentions
//
//  Created by kosmodev on 06.08.2021.
//

import Foundation
import UIKit

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currentCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ViewController.cellID, for: indexPath) as! NewsTableViewCell
        
        cell.bind(_article: newsModel?.articles![indexPath.row])
        
        if indexPath.row + 1 == currentCount {
            getNews()
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var vc = NewsDetailsViewController()
        vc.url = newsModel?.articles![indexPath.row].url ?? ""
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
