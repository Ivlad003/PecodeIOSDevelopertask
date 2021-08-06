//
//  FavoritesViewControllerTableExtentions.swift
//  FavoritesViewControllerTableExtentions
//
//  Created by kosmodev on 06.08.2021.
//

import Foundation
import UIKit
import RealmSwift

extension FavoritesViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
        
        let article = articles[indexPath.row]
        
        cell.textLabel?.text = article.title
        let url = URL(string: article.urlToImage ?? "")
        let data = try? Data(contentsOf: url!)
        cell.imageView?.image = UIImage(data: data!)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var vc = NewsDetailsViewController()
        vc.url = articles[indexPath.row].url ?? ""
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {

            let realm = try! Realm()
            try! realm.write {
                realm.delete( articleObjects[indexPath.row])
            }
            
            articles.remove(at: indexPath.row)
            articleObjects.remove(at: indexPath.row)
            
            NotificationCenter.default.post(name:Notification.Name("onUpdateCounter"), object: nil)
            
            tableView.deleteRows(at: [indexPath], with: .fade)

        }
    }
}
