// 
//  UINSelectableDispatcher.swift
//  UINConvenientFrameWork
//
//  Created by yu tanaka on 2018/08/07.
//  Copyright (c) 2018年 RC-Code, Inc. All rights reserved.
//

import Foundation

/// Protocol to enable dispatch when cell selection state affects other cell selection state
public protocol SelectableDispatcherProtocol {
    var uuid: String { get }
    func update(_ selected: Bool)
}

/// A protocol that notifies other cell of the selected state of the registered cell
public class SelectableDispatcher {
    
    var targets: [SelectableDispatcherProtocol]
    
    public init(targets: [SelectableDispatcherProtocol] = []) {
        self.targets = targets
    }
    
    /// add receiver
    ///
    /// - Parameter target: receiver
    public func add(target: SelectableDispatcherProtocol) {
        if let indexNum = targets.index(where: { $0.uuid == target.uuid }) {
            targets.remove(at: indexNum)
        }
        targets.append(target)
    }
    
    /// remove receiver
    ///
    /// - Parameter target: receiver
    public func remove(target: SelectableDispatcherProtocol) {
        guard let indexNum = targets.index(where: { $0.uuid == target.uuid }) else {
            return
        }
        targets.remove(at: indexNum)
    }
    
    /// receive selection
    ///
    /// - Parameter selected: selected instance
    public func selected(selected: SelectableDispatcherProtocol) {
        targets.forEach { $0.update($0.uuid == selected.uuid) }
    }
}
