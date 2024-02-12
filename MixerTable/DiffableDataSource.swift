//
//  DiffableDataSource.swift
//  MixerTable
//
//  Created by Ian Baikuchukov on 12/2/24.
//

import UIKit

final class DiffableDataSource: UITableViewDiffableDataSource<Int, Int> {
    
    private var data: [Int]
    private var checkedNumbers: Set<Int> = []
    
    init(_ tableView: UITableView, data: [Int]) {
        self.data = data
        super.init(tableView: tableView) { tableView, indexPath, itemIdentifier in
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
//            let isChecked = self.checkedNumbers.contains(itemIdentifier)
            
//            var configuration = cell.defaultContentConfiguration()
//            configuration.text = "\(itemIdentifier)"
//            cell.contentConfiguration = configuration
//            cell.accessoryType = isChecked ? .checkmark : .none
            
            
            
            return cell
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        data.count
    }
    
    
}
