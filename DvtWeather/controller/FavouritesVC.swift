//
//  FavouritesVC.swift
//  DvtWeather
//
//  Created by Morris Murega on 6/27/21.
//

import UIKit

class FavouritesVC: UIViewController {
    @IBOutlet weak var favouritesTableView: UITableView!
    var favourites = [Location]()
    private var dataSource : GenericTableViewDatasource<FavouriteCell,Location>!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        guard let favouritesDeatils = CoreDataManager.shared.fetchPersistedFavouritesData() else {
            print("\(Constants.KEY_COREDATA_FETCH_ERROR) \(Constants.KEY_FAVOURITES_ENTITY)")
            return
        }
        
        for location in favouritesDeatils{
            let favourite = Location(name: location["name"] as! String)
            favourites.append(favourite)
        }
        let filterDuplicates = favourites.uniques(by: \.name)
        self.dataSource = GenericTableViewDatasource(cellIdentifier: Constants.KEY_FAVOURITESCELL_IDENTIFIER, items: filterDuplicates, configureCell: { (cell, location) in
            cell.configureCellWithItem(location: location)
        })
        
        DispatchQueue.main.async {
            self.favouritesTableView.dataSource = self.dataSource
            self.favouritesTableView.reloadData()
        }
    }

}
