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

class TakeCollectionTableViewController: UITableViewController {
    
    private let takeCellReuseId = "takeCellReuseId"
    var takes = [Take]()
    var type: TableType = .own
    
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
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    func getLikedTakes() {
        NetworkManager.getUserVoted(user_id: CurrentUserData.userId){takeCollection in
            self.takes = takeCollection
            
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
        return 100
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: takeCellReuseId, for: indexPath) as! TakeTableViewCell
        cell.configure(for: takes[indexPath.row])
        return cell
    }
}
