// 
//  UINMultipleSelectionViewController.swift
//  ConvenientSamples
//
//  Created by yu tanaka on 2018/08/07.
//  Copyright (c) 2018年 CyberAgent, Inc. All rights reserved.
//


import UIKit
import UINConvenientFrameWork

class UINMultipleSelectionViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var decideButton: UIButton! {
        didSet {
            decideButton.layer.borderWidth = 2
            decideButton.layer.borderColor = UIColor.lightGray.cgColor
        }
    }
    
    private let manager = UINMultipleSelectionManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let identifier = "UINSelectionTableViewCell"
        let nib = UINib(nibName: identifier, bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: identifier)
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    fileprivate func updateSendButton() {
        
        DispatchQueue.main.async { [weak self] in
            guard let me = self else { return }
            UIView.setAnimationsEnabled(false)
            if !me.manager.checkDecideEnabled {
                me.decideButton.isEnabled = false
                me.decideButton.layer.borderColor = UIColor.lightGray.cgColor
            } else {
                me.decideButton.isEnabled = true
                me.decideButton.layer.borderColor = UIColor.green.cgColor
            }
            me.decideButton.layoutIfNeeded()
            UIView.setAnimationsEnabled(true)
        }
    }

    // MARK: UITableViewDelegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let cell = tableView.cellForRow(at: indexPath) as? UINSelectionTableViewCell {
            cell.tapped()
//            manager.update(selectedIndex: indexPath, cell: cell)
        }
        updateSendButton()
        tableView.deselectRow(at: indexPath, animated: false)
    }
    
    // MARK: UITableViewDataSource
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "UINSelectionTableViewCell", for: indexPath) as? UINSelectionTableViewCell, manager.list[indexPath.section].values.count > indexPath.row else {
            return UITableViewCell()
        }
        let model = manager.list[indexPath.section].values[indexPath.row]
        cell.setup(title: model.title, customSelectionView: model.type.views, margin: 10, selectionViewsRectValue: 40, selected: model.selected, dispatcher: manager.list[indexPath.section].dispatcher)
        cell.layoutIfNeeded()
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return manager.list[section].values.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return manager.list[section].title
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return manager.list.count
    }
}


class UINMultipleSelectionManager {
    
    enum SelectionType {
        case `default`, image, label
        
        var views: (UIView, UIView)? {
            switch self {
            case .default:
                return nil
            case .image:
                return (UIImageView(image: UIImage(named: "light-on")), UIImageView(image: UIImage(named: "light-off")))
            case .label:
                let iconLabel_on = UILabel(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
                iconLabel_on.backgroundColor = UIColor.clear
                iconLabel_on.font = UIFont(name: "Genericons-Neue", size: 16)!
                iconLabel_on.textColor = .black
                iconLabel_on.text = ""
                let iconLabel_off = UILabel(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
                iconLabel_off.backgroundColor = UIColor.clear
                iconLabel_off.font = UIFont(name: "Genericons-Neue", size: 16)!
                iconLabel_off.textColor = .lightGray
                iconLabel_off.text = ""
                return (iconLabel_on, iconLabel_off)
            }
        }
    }
    
    class Asset {
        let title: NSAttributedString
        let type: SelectionType
        var selected: Bool
        
        init(title: NSAttributedString, type: SelectionType, selected: Bool) {
            
            self.title = title
            self.type = type
            self.selected = selected
        }
    }
    
    struct Section {
        let title: String
        let values: [Asset]
        let dispatcher = SelectableDispatcher()
    }
    
    let list: [Section] = [
        Section(title: "hogehoge", values: [
            Asset(title: NSAttributedString(string: "hogehoge"), type: .default, selected: false),
            Asset(title: NSAttributedString(string: "hogehoge"), type: .default, selected: false),
            Asset(title: NSAttributedString(string: "hogehoge"), type: .default, selected: false),
            Asset(title: NSAttributedString(string: "hogehoge"), type: .default, selected: false),
            Asset(title: NSAttributedString(string: "hogehoge"), type: .default, selected: false)
            ]),
        Section(title: "fuga", values: [
            Asset(title: NSAttributedString(string: "fugafugafugafugafugafugafugafugafugafuga"), type: .image, selected: false),
            Asset(title: NSAttributedString(string: "fugafugafugafugafugafugafugafugafugafuga"), type: .image, selected: false),
            Asset(title: NSAttributedString(string: "fugafugafugafugafugafugafugafugafugafuga"), type: .image, selected: false),
            Asset(title: NSAttributedString(string: "fugafugafugafugafugafugafugafugafugafuga"), type: .image, selected: false),
            Asset(title: NSAttributedString(string: "fugafugafugafugafugafugafugafugafugafuga"), type: .image, selected: false)
            ]),
        Section(title: "piyo", values: [
            Asset(title: NSAttributedString(string: "piyopiyopiyopiyopiyopiyopiyo"), type: .label, selected: false),
            Asset(title: NSAttributedString(string: "piyopiyopiyopiyopiyopiyopiyo"), type: .label, selected: false),
            Asset(title: NSAttributedString(string: "piyopiyopiyopiyopiyopiyopiyo"), type: .label, selected: false),
            Asset(title: NSAttributedString(string: "piyopiyopiyopiyopiyopiyopiyo"), type: .label, selected: false)
            ])
    ]

    var checkDecideEnabled: Bool {
        
        var enableSections: [Bool] = []
        list.forEach { section in
            var enabled: Bool = false
            section.values.forEach { asset in
                guard enabled == false else { return }
                enabled = asset.selected
            }
            if enabled {
                enableSections.append(enabled)
            }
        }
        
        return enableSections.count == list.count
    }
    
//    func update(selectedIndex: IndexPath, cell: ) {
//        list[indexPath.section].dispatcher.selected(selected: cell)
//        list[selectedIndex.section].values.enumerated().forEach { (arg) in
//            let (index, value) = arg
//            value.selected = index == selectedIndex.row
//        }
//        list[selectedIndex.section].values[selectedIndex.row].selected = true
//    }
}
