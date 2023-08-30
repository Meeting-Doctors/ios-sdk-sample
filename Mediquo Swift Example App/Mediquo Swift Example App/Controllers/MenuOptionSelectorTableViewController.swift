//
//  MenuOptionSelectorTableViewController.swift
//  Mediquo Swift Example App
//
//  Created by Xavi Roig Aznar on 19/8/21.
//  Copyright © 2021 Edgar Paz Moreno. All rights reserved.
//

import UIKit
import MDChatSDK

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
        
        MDChat.style?.rootLeftBarButtonItem = UIBarButtonItem(image: UIImage(named: "Back"), style: .plain, target: self, action: #selector(dismissPage))
        
        tableView.bounces = false
        
        
        self.viewModel.registerCellViewModels(onVC: self)
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.reloadData()
        
        self.bindNotifications()
        
    }
    
    private func bindNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(self.termsDeclined(notification:)), name: Notification.Name.MeetingDoctors.TermsAndConditions.Declined, object: nil)
    }
    
    @objc func termsDeclined(notification: Notification) {
        guard let viewController = notification.userInfo?[Notification.Key.MeetingDoctors.TermsAndConditions.Declined] as? UIViewController else {
            NSLog("[MenuOptionSelectorTableViewController] Message sent could not be obtained from successful message notification event")
            return
        }

        NSLog("[MenuOptionSelectorTableViewController] Terms Declined: \(viewController)")

        viewController.dismiss(animated: false)
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
