// 
//  UINDispatcher.swift
//  UINConvenientFrameWork
//
//  Created by yu tanaka on 2018/08/07.
//  Copyright (c) 2018年 RC-Code, Inc. All rights reserved.
//

import Foundation

// cellの選択状態が他cellの選択状態に影響を与える場合にDispatch可能にするプロトコル
public protocol SelectableDispatcherProtocol {
    var uuid: String { get }
    func update(_ selected: Bool)
}

// 登録されたcellの選択状態を他cellに通知するプロトコル
public class SelectableDispatcher {
    
    var targets: [SelectableDispatcherProtocol]
    
    public init(targets: [SelectableDispatcherProtocol] = []) {
        self.targets = targets
    }
    
    public func add(target: SelectableDispatcherProtocol) {
        if let indexNum = targets.index(where: { $0.uuid == target.uuid }) {
            targets.remove(at: indexNum)
        }
        targets.append(target)
    }
    
    public func remove(target: SelectableDispatcherProtocol) {
        guard let indexNum = targets.index(where: { $0.uuid == target.uuid }) else {
            return
        }
        targets.remove(at: indexNum)
    }
    
    public func selected(selected: SelectableDispatcherProtocol) {
        targets.forEach { $0.update($0.uuid == selected.uuid) }
    }
}
