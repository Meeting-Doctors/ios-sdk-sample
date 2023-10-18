// Copyright © 2022 MeetingDoctors S.L. All rights reserved.

import UIKit
import MeetingDoctorsSDK
import Firebase

class MenuOptionSelectorTableViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var viewModel = MenuOptionSelectorTableViewModel()
    
    private var isAuthenticated: Bool = false
    
    static func storyboardInstance()-> MenuOptionSelectorTableViewController? {
        
        if let viewController = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "MenuOptionSelectorTableViewController") as? MenuOptionSelectorTableViewController {
            return viewController
        }
        
        return nil
    }
    
    @objc func dismissOptionSelector() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func dismissPage() {
        viewModel.presentedViewController?.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.setLeftBarButton(UIBarButtonItem(image: UIImage(named: "Back"), style: .plain, target: self, action: #selector(dismissOptionSelector)), animated: false)
        
        MeetingDoctors.style?.rootLeftBarButtonItem = UIBarButtonItem(image: UIImage(named: "Back"), style: .plain, target: self, action: #selector(dismissPage))
        
        tableView.bounces = false
        
        
        self.viewModel.registerCellViewModels(onVC: self)
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.reloadData()
        
    }
    
}

extension MenuOptionSelectorTableViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.cellViewModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard indexPath.row >= 0, indexPath.row < viewModel.cellViewModels.count else { return UITableViewCell() }
        
        let cellViewModel = viewModel.cellViewModels[indexPath.row]

        let cell = UITableViewCell()
        
        cell.textLabel?.text = cellViewModel.titleLabel
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        guard indexPath.row >= 0, indexPath.row < viewModel.cellViewModels.count else { return }
        
        viewModel.cellViewModels[indexPath.row].action()
        
    }
    
}
