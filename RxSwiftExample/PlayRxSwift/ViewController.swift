//
//  ViewController.swift
//  PlayRxSwift
//
//  Created by allenlinli on 10/17/16.
//  Copyright © 2016 Raccoonism. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa



class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var shownCities = [String]() // Data source for UITableView
    let allCities = ["New York", "London", "Oslo", "Warsaw", "Berlin", "Praga"]
    let disposeBag = DisposeBag()
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        
        searchBar
            .rx.text // Observable property thanks to RxCocoa
            .throttle(0.5, scheduler: MainScheduler.instance) // Wait 0.5 for changes.
            .distinctUntilChanged() // If they didn't occur, check if the new value
            .filter { $0.characters.count > 0 } // Filter for non-empty query.
            .subscribe { [unowned self] (query) in // Here we will be notified of every new value
                self.shownCities = self.allCities.filter { $0.hasPrefix(query.element!) } // We now do our "API Request" to find cities.
                self.tableView.reloadData() // And reload table view data.
            }
            .addDisposableTo(disposeBag) // Don't forget to add this to disposeBag to avoid retain cycle.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shownCities.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cityPrototypeCell", for: indexPath as IndexPath)
        cell.textLabel?.text = shownCities[indexPath.row]
        
        return cell
    }
}

