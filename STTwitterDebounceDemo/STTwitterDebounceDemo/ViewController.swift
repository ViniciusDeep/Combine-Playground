//
//  ViewController.swift
//  STTwitterDebounceDemo
//
//  Created by Vinicius Mangueira  on 6/19/19.
//  Copyright © 2019 Vinicius Mangueira . All rights reserved.
//

import UIKit
import STTwitter
import SDWebImage
import LBTATools

class ViewController: UITableViewController {
    
    let key = "XCc5HYgaIBFu93NjiQlUMYLEB"
    let secret = "OZZurb7cZGo3kzocCj2CjIAGMQq1MSTwoQlM80x94i1RowURSh"
    lazy var api = STTwitterAPI(appOnlyWithConsumerKey: key, consumerSecret: secret)
    
    let searchController = UISearchController(searchResultsController: nil)
    
    var sink: Any?

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.allowsSelection = false
        setupSearchBarListeners()
        
//        listenForSearchTextChanges()
        navigationItem.searchController = searchController
        
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "Search Tweets"
        
        searchController.obscuresBackgroundDuringPresentation = false
        
        api?.verifyCredentials(userSuccessBlock: { (username, userId) in
            self.searchTweets(query: "Swift Combine")
        }, errorBlock: { (err) in
            guard let err = err else { return }
            print("Failed to verify credentials:", err)
        })
        
    }
    
    fileprivate func setupSearchBarListeners() {
        let publisher = NotificationCenter.default.publisher(for: UISearchTextField.textDidChangeNotification, object: searchController.searchBar.searchTextField)
        publisher
            .map {
            ($0.object as! UISearchTextField).text
        }
            .debounce(for: .milliseconds(500), scheduler: RunLoop.main)
            .sink { (str) in
                self.searchTweets(query: str ?? "")
        }

    }
 
    fileprivate func searchTweets(query: String) {
        api?.getSearchTweets(withQuery: query, successBlock: { (data, res) in
            
            guard let res = res else { return }
            
            guard let jsonData = try? JSONSerialization.data(withJSONObject: res, options: .prettyPrinted) else { return }
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                self.tweets = try decoder.decode([Tweet].self, from: jsonData)
                self.tableView.reloadData()
            } catch {
                print("Failed to decode:", error)
            }
            
        }, errorBlock: { (err) in
            if let err = err {
                print("Failed to search tweets:", err)
            }
        })
    }
    
    var tweets = [Tweet]()
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tweets.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = TweetCell(style: .subtitle, reuseIdentifier: nil)
        let tweet = tweets[indexPath.row]
        cell.tweetTextLabel.text = tweet.text
        cell.nameLabel.text = tweet.user.name
        cell.profileImageView.sd_setImage(with: URL(string: tweet.user.profileImageUrl.replacingOccurrences(of: "http", with: "https")))
        return cell
    }
}

