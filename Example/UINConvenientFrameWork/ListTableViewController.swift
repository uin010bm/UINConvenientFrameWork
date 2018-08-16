// 
//  ListTableViewController.swift
//  ConvenientSamples
//
//  Created by yu tanaka on 2018/07/31.
//  Copyright (c) 2018年 RC-Code, Inc. All rights reserved.
//


import UIKit

class ListTableViewController: UITableViewController {
    
    struct Asset {
        let title: String
        let `class`: String
    }
    
    private let list: [Asset] = [
        Asset(title: "UINGradation", class: "UINGradationViewController"),
        Asset(title: "UINShadow", class: "UINShadowViewController"),
        Asset(title: "UINButton", class: "UINButtonViewController"),
        Asset(title: "UINProgressView", class: "UINProgressViewController"),
        Asset(title: "UINFloatView", class: "UINFloatViewController"),
        Asset(title: "UINMultipleSelectionView", class: "UINMultipleSelectionViewController")
    ]

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = list[indexPath.row].title
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let vc = UIStoryboard.init(name: list[indexPath.row].class, bundle: nil).instantiateInitialViewController() else { return }
        navigationController?.pushViewController(vc, animated: true)
    }
}
