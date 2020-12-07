//
//  FeedViewController.swift
//  hotTakes
//
//  Created by Michael Crum on 12/6/20.
//

/**
 Feed view
 Todo:
    1. Add new post button (should present a NewPostViewController as a detail view)
    2. Pull data from backend
    3. Customize the table cells (see TakeTableViewCell for todo)
    4. Make new post page funcitonal (see NewPostViewController for todo)
 */

import UIKit

class FeedViewController: UIViewController {
    var titleLabel: UILabel!
    
    var feedTableView: UITableView!
    
    let reuseIdentifier = "postReuse"
    let cellHeight: CGFloat = 75
    
    var takes: [Take]!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleLabel = UILabel()
        titleLabel.text = "Feed"
        titleLabel.font = UIFont.boldSystemFont(ofSize: 32)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(titleLabel)
        
        feedTableView = UITableView()
        feedTableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(feedTableView)
        
        feedTableView.register(TakeTableViewCell.self, forCellReuseIdentifier: reuseIdentifier)
        feedTableView.dataSource = self
        feedTableView.delegate = self
        
        let testTakeOne = Take(author: "Michael", text: "This is test take one", hotVotes: 10, coldVotes: 4)
        let testTakeTwo = Take(author: "Michael", text: "This is a test take two", hotVotes: 2, coldVotes: 7)
        
        takes = [testTakeOne, testTakeTwo]
        
        view.backgroundColor = .white
        
        setupConstraints()
    }
    
    func setupConstraints(){
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30)
        ])
        
        NSLayoutConstraint.activate([
            feedTableView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            feedTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            feedTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            feedTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
}

extension FeedViewController : UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return takes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! TakeTableViewCell
        
        let take = takes[indexPath.row]
        
        cell.configure(for: take)
        cell.selectionStyle = .none
        
        return cell
    }
}

extension FeedViewController : UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return cellHeight
    }
}
