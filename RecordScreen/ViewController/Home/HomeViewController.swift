//
//  HomeViewController.swift
//  RecordScreen
//
//  Created by LTT on 12/17/18.
//  Copyright © 2018 LTT. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    let arrayTitle: [String] = ["Browser", "Clouds", "Files", "Settings"]
    let nameIcon: [String] = ["icons8-europe-filled", "icons8-onedrive", "icons8-file", "icons8-settings"]
    @IBOutlet weak var menuTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupMenuTableView()
    }
   
    func setupMenuTableView() {
        menuTableView.delegate = self
        menuTableView.dataSource = self
    }
    
    func pushBrowserViewController() {
        print("aaa")
        let browserViewController = BrowserViewController.instantiateFromStoryboard()
        self.navigationController?.pushViewController(browserViewController, animated: true)
    }
}


extension HomeViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = UIColor.clear
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        pushBrowserViewController()
    }
}

extension HomeViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = menuTableView.dequeueReusableCell(withIdentifier: "cell") as! HomeTableViewCell
        cell.configCell(nameIcon: nameIcon[indexPath.section], title: arrayTitle[indexPath.section])
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
}
