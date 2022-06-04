//
//  ViewController.swift
//  APIManagerDemo
//
//  Created by Avadh on 22/04/21.
//  Copyright © 2021 Avadh. All rights reserved.
//

import UIKit
import APIManager
import SDWebImageSVGKitPlugin

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var flagListTableView: UITableView!
    var countryListModel: [CountryModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        flagListTableView.register(UINib(nibName: "CountryFlagTableViewCell", bundle: nil), forCellReuseIdentifier: "CountryFlagTableViewCell")
        getCountryList()
    }
    
    func getCountryList() {
        let apiTarget = APITargetType.init(baseURL: URL.init(string: "https://restcountries.eu/rest/v2/")!, path: "all", method: .get, task: .requestPlain, headers: [:])
        APIManager.request(apiTarget, success: { (countryArrJSON) in
            // debugPrint("Response:")
             debugPrint(countryArrJSON)
            for countryJSON in countryArrJSON.arrayValue {
                 debugPrint(countryJSON)
                self.countryListModel.append(CountryModel.init(fromJSON: countryJSON))
            }
            DispatchQueue.main.async {
                self.flagListTableView.reloadData()
            }
        }, error: { (errorStr) in
            debugPrint(errorStr)
        }, failure: { (error) in
            debugPrint(error.localizedDescription)
        })
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.countryListModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CountryFlagTableViewCell", for: indexPath) as? CountryFlagTableViewCell else { return UITableViewCell() }
        let countryJSON = self.countryListModel[indexPath.row]
        let svgCoder = SDImageSVGKCoder.shared
        SDImageCodersManager.shared.addCoder(svgCoder)
        DispatchQueue.main.async {
            cell.flagImageView.sd_setImage(with: URL.init(string: countryJSON.flag ?? "")!)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }

}

