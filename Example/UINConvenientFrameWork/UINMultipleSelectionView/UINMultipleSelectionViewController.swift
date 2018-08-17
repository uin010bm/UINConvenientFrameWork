// 
//  UINMultipleSelectionViewController.swift
//  UINConvenientFrameWork
//
//  Created by yu tanaka on 2018/08/07.
//  Copyright (c) 2018年 RC-Code, Inc. All rights reserved.
//


import UIKit
import UINConvenientFrameWork

class UINMultipleSelectionViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var decideButton: UINButton!

    private let manager = UINMultipleSelectionManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let identifier = "UINSelectionTableViewCell"
        let nib = UINib(nibName: identifier, bundle: Bundle(for: UINSelectionTableViewCell.self))
        tableView.register(nib, forCellReuseIdentifier: identifier)
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        decideButton
            .size()
            .fillColor(color: .black)
            .lineColor(color: .white)
            .lineWidth(value: 2)
            .radius(value: 4)
            .text(value: "Decide")
            .font(font: UIFont.boldSystemFont(ofSize: 16))
            .textColor(color: .white)
            .dropShadow(value: (alpha: Float(0.4), offsetSize: CGSize(width: 2, height: 2), radius: 3))
            .tappedAnimType(type: .scale(scale: 0.97, spring: false))
            .highlightColor(color: .white)
            .touchUpHandler({ [weak self] button in
                let vc = UIAlertController(title: "Done!", message: "Thank you so much.", preferredStyle: .alert)
                vc.addAction(UIAlertAction(title: "close", style: .cancel, handler: nil))
                self?.present(vc, animated: true, completion: nil)
            })
            .isEnabled(false)
            .draw()
            .show()
    }
    
    fileprivate func updateSendButton() {
        
        DispatchQueue.main.async { [weak self] in
            guard let me = self else { return }
            if !me.manager.checkDecideEnabled {
                me.decideButton.isEnabled(false, animated: true)
            } else {
                me.decideButton.isEnabled(true, animated: true)
            }
        }
    }

    // MARK: UITableViewDelegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let cell = tableView.cellForRow(at: indexPath) as? UINSelectionTableViewCell {
            cell.tapped()
            manager.update(selectedIndex: indexPath, cell: cell)
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
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let label = UILabel(frame: CGRect(x: 10, y: 5, width: tableView.frame.width - 20, height: 60))
        label.text = manager.list[section].title
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.textColor = .white
        label.numberOfLines = 0
        let view = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 70))
        view.backgroundColor = .gray
        view.addSubview(label)
        return view
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 70
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
        Section(title: "From the choices below, choose the celebrity you like best.", values: [
            Asset(title: NSAttributedString(string: "Warren Edward Buffett"), type: .default, selected: false),
            Asset(title: NSAttributedString(string: "Steven Spielberg"), type: .default, selected: false),
            Asset(title: NSAttributedString(string: "Taylor Swift"), type: .default, selected: false),
            Asset(title: NSAttributedString(string: "Anne Jacqueline Hathaway"), type: .default, selected: false),
            Asset(title: NSAttributedString(string: "Walter Bruce Willis"), type: .default, selected: false)
            ]),
        Section(title: "From the options below, choose the subject you are most interested in.", values: [
            Asset(title: NSAttributedString(string: "Mathematics"), type: .image, selected: false),
            Asset(title: NSAttributedString(string: "Sociology"), type: .image, selected: false),
            Asset(title: NSAttributedString(string: "Chemical"), type: .image, selected: false),
            Asset(title: NSAttributedString(string: "literature"), type: .image, selected: false),
            Asset(title: NSAttributedString(string: "Folklore"), type: .image, selected: false)
            ]),
        Section(title: "Choose the action that you feel most lovely from the choices below.", values: [
            Asset(title: NSAttributedString(string: "To hug"), type: .label, selected: false),
            Asset(title: NSAttributedString(string: "To shake hands"), type: .label, selected: false),
            Asset(title: NSAttributedString(string: "Show a smile"), type: .label, selected: false),
            Asset(title: NSAttributedString(string: "Give money"), type: .label, selected: false)
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
    
    func update(selectedIndex: IndexPath, cell: SelectableDispatcherProtocol) {
        list[selectedIndex.section].dispatcher.selected(selected: cell)
        list[selectedIndex.section].values.enumerated().forEach { (arg) in
            let (index, value) = arg
            value.selected = index == selectedIndex.row
        }
        list[selectedIndex.section].values[selectedIndex.row].selected = true
    }
}
