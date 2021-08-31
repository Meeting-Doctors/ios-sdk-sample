//
//  MenuOptionSelectorTableViewController.swift
//  Mediquo Swift Example App
//
//  Created by Xavi Roig Aznar on 19/8/21.
//  Copyright © 2021 Edgar Paz Moreno. All rights reserved.
//

import UIKit
import MediQuo

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
        
        self.navigationItem.setLeftBarButton(UIBarButtonItem(image: R.image.back(), style: .plain, target: self, action: #selector(dismissOptionSelector)), animated: false)
        
        MediQuo.style?.rootLeftBarButtonItem = UIBarButtonItem(image: R.image.back(), style: .plain, target: self, action: #selector(dismissPage))
        
        tableView.bounces = false
        
        doLogin { [weak self] (isSuccess) in
            
            guard let strongSelf = self else { return }
            
            if isSuccess {
                strongSelf.viewModel.registerCellViewModels(onVC: self)
                
                strongSelf.tableView.delegate = self
                strongSelf.tableView.dataSource = self
                strongSelf.tableView.reloadData()
            }
        }
        
    }
    
    private func doLogin(completion: ((Bool) -> Void)? = nil) {
        let userToken: String = MediQuo.getUserToken()
        MediQuo.authenticate(token: userToken) {
            let success = $0.isSuccess
            self.isAuthenticated = success
            if let completion = completion { completion(success) }
        }
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
