//
//  ViewController.swift
//  MessageCell
//
//  Created by Ray on 2021/7/4.
//

import UIKit

class ViewController: UIViewController {

    private lazy var tableView: UITableView = {
        let table: UITableView = .init(frame: .zero, style: .grouped)
        table.register(FriendTextMessageCell.self, forCellReuseIdentifier: FriendTextMessageCell.className)
        table.register(MyTextMessageCell.self, forCellReuseIdentifier: MyTextMessageCell.className)
        table.dataSource = self
        table.delegate = self
        table.separatorColor = .clear
        table.tableFooterView = UIView()
        
        table.translatesAutoresizingMaskIntoConstraints = false
        table
            .add(to: view)
            .anchor(.leading, toItem: view, itemAttribute: .leading)
            .anchor(.trailing, toItem: view, itemAttribute: .trailing)
            .anchor(.top, toItem: view, itemAttribute: .top)
            .anchor(.bottom, toItem: view, itemAttribute: .bottom)
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.reloadData()
    }
}
extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if (indexPath.row % 2 == 0) {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: FriendTextMessageCell.className, for: indexPath) as? FriendTextMessageCell else {
                return .init()
            }
            cell.textContentLabel.text = "2222"
            cell.dateLabel.text = "2020"
            return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: MyTextMessageCell.className, for: indexPath) as? MyTextMessageCell else {
                return .init()
            }
            cell.textContentLabel.text = "2222"
            cell.dateLabel.text = "2020"
            return cell
        }
    }
}
extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
