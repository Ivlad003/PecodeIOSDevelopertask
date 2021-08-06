//
//  ViewController.swift
//  PecodeIOSDevelopertask
//
//  Created by kosmodev on 05.08.2021.
//

import UIKit
import RealmSwift

class ViewController: UIViewController {
    @IBOutlet weak var navItem: UINavigationItem!
    @IBOutlet weak var table: UITableView!
    
    static var cellID = "NewsCell"
    var newsModel: NewsModel?
    var currentPage = 1
    var currentCount = 0
    var favorites: UIBarButtonItem?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        newsModel = nil
        table.dataSource = self
        table.delegate = self
        table.rowHeight = UITableView.automaticDimension
        table.estimatedRowHeight = 80
        
        Realm.Configuration.defaultConfiguration.deleteRealmIfMigrationNeeded = true
        
        let realm = try! Realm()
        
        let articleObjects = realm.objects(ArticleObject.self)
        
        favorites = UIBarButtonItem(title: "Favorites \(articleObjects.count)", style: .plain, target: self, action: #selector(openFavorites))
        
        var search = UIBarButtonItem(title: "Search", style: .plain, target: self, action: #selector(searchNews))
        
        navigationItem.rightBarButtonItems = [favorites!, search]
        
        NotificationCenter.default.addObserver(self, selector: #selector(onUpdateCounter(_:)), name: Notification.Name("onUpdateCounter"), object: nil)
        
        getNews()
    }

    
    @objc func onUpdateCounter(_ notification: Notification){
        let realm = try! Realm()
        
        let articleObjects = realm.objects(ArticleObject.self)
        
        favorites?.title = "Favorites \(articleObjects.count)"
    }
    
    @objc func openFavorites(){
        self.navigationController?.pushViewController(FavoritesViewController(), animated: true)
    }
    
    @objc func searchNews() {
        let ac = UIAlertController(title: "Enter answer", message: nil, preferredStyle: .alert)
        ac.addTextField()

        let submitAction = UIAlertAction(title: "Search", style: .default) { [unowned ac] _ in
            let answer = ac.textFields![0]
            self.newsModel = nil
            self.table.reloadData()
            if !(answer.text?.isEmpty ?? true) {
                self.getNews(q: answer.text!)
            }
            
        }

        ac.addAction(submitAction)

        present(ac, animated: true)
    }
}
