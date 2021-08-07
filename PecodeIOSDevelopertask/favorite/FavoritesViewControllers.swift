//
//  FavoritesViewControllers.swift
//  FavoritesViewControllers
//
//  Created by kosmodev on 06.08.2021.
//

import Foundation
import UIKit
import RealmSwift

class FavoritesViewController: UIViewController{
    let table = UITableView()
    var articleObjects: [ArticleObject] = []
    
    override func viewDidLoad() {
        
        setupTableView()
        
        let realm = try! Realm()
        
        articleObjects = Array(realm.objects(ArticleObject.self))
        
        table.dataSource = self
        table.delegate = self
    }
    
    func setupTableView() {
        view.addSubview(table)
        table.translatesAutoresizingMaskIntoConstraints = false
        table.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        table.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        table.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        table.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
    }
}
