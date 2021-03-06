//
//  ArticleObject.swift
//  ArticleObject
//
//  Created by kosmodev on 07.08.2021.
//

import Foundation
import RealmSwift
import CryptoKit

class ArticleObject: Object {
    @objc dynamic var id = ""
    @objc dynamic var author = ""
    @objc dynamic var title = ""
    @objc dynamic var articleDescription = ""
    @objc dynamic var url = ""
    @objc dynamic var urlToImage = ""
    @objc dynamic var publishedAt = ""
    @objc dynamic var source = ""
    @objc dynamic var content = ""
    
    convenience init(article: Article?) {
        self.init()
        self.author = article?.author ?? ""
        self.title = article?.title ?? ""
        self.articleDescription = article?.articleDescription ?? ""
        self.url = article?.url ?? ""
        self.urlToImage = article?.urlToImage ?? ""
        self.publishedAt = article?.publishedAt ?? ""
        self.source = article?.source?.name ?? ""
        self.content = article?.content ?? ""
        
        let digest = Insecure.MD5.hash(data: "\(author)\(title)\(author)\(source)\(url)".data(using: .utf8) ?? Data())
        
        self.id = digest.map {
               String(format: "%02hhx", $0)
           }.joined()
    }
    
    static func getArticle(articleObject: ArticleObject) -> Article {
        let _source = Source(id: "", name: articleObject.source)
                
        let article = Article(source: _source, author: articleObject.author, title: articleObject.title, articleDescription: articleObject.articleDescription, url: articleObject.url, urlToImage: articleObject.urlToImage, publishedAt: articleObject.publishedAt, content: articleObject.content)
        return article
    }
    
    static func isObjectExist(realm: Realm, article: ArticleObject) -> Bool{
        realm.object(ofType: ArticleObject.self, forPrimaryKey: article.id) != nil
    }
        
    
    override static func primaryKey() -> String? {
           return "id"
    }
}
