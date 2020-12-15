//
//  TakeCollectionTableViewController.swift
//  hotTakes
//
//  Created by Michael Crum on 12/14/20.
//

import UIKit

enum TableType{
    case own, liked
}

protocol voteCountDelegate: class{
    func takeVoteCount(coldCount: Int, hotCount: Int)
}

protocol postCountDelegate: class {
    func takePostCount(postCount: Int)
}

class TakeCollectionTableViewController: UITableViewController {
    
    private let takeCellReuseId = "takeCellReuseId"
    var takes = [Take]()
    var type: TableType = .own
    
    var voteDelegate: voteCountDelegate?
    var postDelegate: postCountDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .blue
        
        view.translatesAutoresizingMaskIntoConstraints = false
        
        tableView = UITableView(frame: .zero, style: .grouped)
        tableView.backgroundColor = .white
        tableView.separatorStyle = .none
        tableView.contentInset = UIEdgeInsets(top: 18, left: 0, bottom: 0, right: 0)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.register(TakeTableViewCell.self, forCellReuseIdentifier: takeCellReuseId)
        tableView.contentInset = UIEdgeInsets(top: -20, left: 0, bottom: -20, right: 0);
    }

    override func viewDidAppear(_ animated: Bool) {
        if type == .own{
            getOwnTakes()
        }else{
            getLikedTakes()
        }
    }
    
    func getOwnTakes() {
        NetworkManager.getUserTakes(user_id: CurrentUserData.userId){takeCollection in
            self.takes = takeCollection
            
            self.postDelegate?.takePostCount(postCount: self.takes.count)
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    func getLikedTakes() {
        NetworkManager.getUserVoted(user_id: CurrentUserData.userId){takeCollection in
            self.takes = takeCollection
            
            var coldTotal = 0
            var hotTotal = 0
            
            for t in self.takes {
                coldTotal += t.cold_count
                hotTotal += t.hot_count
            }
            
            self.voteDelegate?.takeVoteCount(coldCount: coldTotal, hotCount: hotTotal)
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return takes.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: takeCellReuseId, for: indexPath) as! TakeTableViewCell
        cell.configure(for: takes[indexPath.row])
        return cell
    }
}
