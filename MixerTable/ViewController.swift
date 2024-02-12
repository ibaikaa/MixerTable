//
//  ViewController.swift
//  MixerTable
//
//  Created by Ian Baikuchukov on 12/2/24.
//

import UIKit

final class ViewController: UIViewController {
    
    // MARK: - typealias
    
    private typealias DataSource = UITableViewDiffableDataSource<Int, Int>
    private typealias Snapshot = NSDiffableDataSourceSnapshot<Int, Int>
    
    // MARK: - UI-Components
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: view.bounds, style: .insetGrouped)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: CELL_IDENTIFIER)
        tableView.delegate = self
        return tableView
    }()
    
    // MARK: - Private properties
    
    private let CELL_IDENTIFIER = "Cell"
    
    private var dataSource: DataSource?
    private var tableViewNumbers = Array(1...50)
    private var checkedNumbers: Set<Int> = []
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        setupNavigationBar()
        setupDataSource()
        applySnapshot()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        view.addSubview(tableView)
    }
    
    // MARK: - Private methods
    
    private func setupNavigationBar() {
        navigationItem.title = "Table View"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Shuffle", style: .plain, target: self, action: #selector(shuffleCells))
    }
    
    private func setupDataSource() {
        dataSource = DataSource(tableView: tableView) { [unowned self] tableView, indexPath, itemIdentifier in
            let cell = tableView.dequeueReusableCell(withIdentifier: CELL_IDENTIFIER, for: indexPath)
            let isChecked = self.checkedNumbers.contains(itemIdentifier)
            
            var configuration = cell.defaultContentConfiguration()
            configuration.text = String(indexPath.row)
            cell.contentConfiguration = configuration
            
            return cell
        }
        
        dataSource?.defaultRowAnimation = .fade
        tableView.dataSource = dataSource
    }
    
    private func applySnapshot() {
        var snapshot = Snapshot()
        snapshot.appendSections([.zero])
        snapshot.appendItems(tableViewNumbers, toSection: .zero)
        dataSource?.apply(snapshot, animatingDifferences: true)
    }
    
    @objc
    private func shuffleCells() {
        tableViewNumbers.shuffle()
        applySnapshot()
    }
    
}

// MARK: - UITableViewDelegate

extension ViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        guard let cell = tableView.cellForRow(at: indexPath) else { return }
        
        let number = tableViewNumbers[indexPath.row]
        let isNumberIselected = checkedNumbers.contains(number)
        
        if isNumberIselected {
            checkedNumbers.remove(tableViewNumbers[indexPath.row])
            cell.accessoryType = .none
        } else {
            tableViewNumbers.remove(at: indexPath.row)
            tableViewNumbers.insert(number, at: 0)
            checkedNumbers.insert(number)
            cell.accessoryType = .checkmark
            applySnapshot()
        }
    }
    
}
