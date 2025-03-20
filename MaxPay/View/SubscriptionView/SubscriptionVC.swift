import UIKit
import SwiftLoader

class SubscriptionVC: BaseVC {

    @IBOutlet weak var tableViewsubscription: UITableView!
    @IBOutlet weak var buttoon: UILabel!
    
    var subscriptionResponse: SubscriptionResponse?
    
    private var subscriptionViewViewModel = SubscriptionViewViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
      
        tableViewsubscription.delegate = self
        tableViewsubscription.dataSource = self
        
        // Fetch subscription model data
        subscriptionViewViewModel.subscriptionmodel()
        
        // Observe events for data loading and update UI accordingly
        observeEvent()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Hide the tab bar when this view is shown
        self.tabBarController?.tabBar.isHidden = true
        
        // Reload the table view whenever the view appears to refresh data
        tableViewsubscription.reloadData()
    }

    @IBAction func btnBackClicked(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }

    // MARK: Observing the data
    func observeEvent() {
        subscriptionViewViewModel.eventHandler = { [weak self] event in
            guard let self = self else { return }

            switch event {
            case .loading:
                print("loading....")
                SwiftLoader.show(animated: true)
            case .stopLoading:
                print("Stop loading...")
                SwiftLoader.hide()
            case .dataLoaded:
                print("Data loaded...")
                
                if let subscription = self.subscriptionViewViewModel.subscription {
                    print("Subscription Data: \(subscription)")
                }
                
                if self.subscriptionViewViewModel.subscription?.status.lowercased() == "success" {
                    self.subscriptionResponse = self.subscriptionViewViewModel.subscription
                    DispatchQueue.main.async {
                        // Reload the table view on the main thread
                        self.tableViewsubscription.reloadData()
                    }
                } else {
                    self.showErrorAlert("Error: Invalid subscription status.")
                }
            case .error(let error):
                print(error ?? "Unknown error")
                SwiftLoader.hide()
                // self.showErrorAlert(error ?? "Unknown error occurred.")
            }
        }
    }

    // MARK: TableView DataSource Methods
}

extension SubscriptionVC: UITableViewDelegate, UITableViewDataSource {

    // Number of rows in the table view
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let rowCount = subscriptionResponse?.data?.count ?? 0
        print("Number of rows: \(rowCount)")
        return rowCount
    }

    // Cell for each row in the table view
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Dequeue the custom cell
        let cell = tableView.dequeueReusableCell(withIdentifier: "FetechingBillCellTable", for: indexPath) as! FetechingBillCellTable
        
        // Check if there's data to display
        if let feature = subscriptionResponse?.data?[indexPath.row] {
            print("Feature: \(feature.feature)") // Debugging feature data
            if let lblTitle = cell.lblTitle {
                // If the label exists, set the text
                lblTitle.text = feature.feature
                print("Setting text for row \(indexPath.row): \(feature.feature)")
            } else {
                // Fallback: If lblTitle is not found or not connected properly
                print("Error: lblTitle not found in the cell at row \(indexPath.row).")
            }
        } else {
            print("Feature not found for row \(indexPath.row)")  // Debugging: if feature is nil
        }

        return cell
    }
}
