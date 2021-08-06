//
//  TableViewCell.swift
//  TableViewCell
//
//  Created by kosmodev on 06.08.2021.
//

import Foundation
import UIKit
import RealmSwift

class NewsTableViewCell: UITableViewCell {
    @IBOutlet weak var favButton: UIButton!
    @IBAction func addToFavorite(_ sender: Any) {
        let realm = try! Realm()
        
        let article = ArticleObject(article: article)
        
        let isObjectExist = realm.object(ofType: ArticleObject.self, forPrimaryKey: article.id) != nil
        
        if isObjectExist {return}
            
        try! realm.write {
            realm.add(article)
            NotificationCenter.default.post(name:Notification.Name("onUpdateCounter"), object: nil)
        }
    }
    
    @IBOutlet weak var source: UILabel!
    @IBOutlet weak var author: UILabel!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var img: UIImageView!
    var article: Article?
    
    func bind(_article: Article?) {
        if let article = _article {
            self.article = article
            self.source.text = article.source?.name
            self.author.text = article.author
            self.title.text = article.title
            if let url = URL(string: article.urlToImage ?? ""){
                let data = try? Data(contentsOf: url)
                self.img.image = UIImage(data: data!)
            }
            
        }
    }
}
