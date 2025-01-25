//
//  WalletPrimaryViewController.swift
//  MaxPay
//
//  Created by Admin on 01/09/24.
//



import UIKit

class WalletPrimaryViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    //private let viewModel = WalletViewModel()
    private let viewModels = LatestWalletViewModel()
    private let viewModel = CardDetailsViewModel()
  //  private let viewModelTrans = TransactionsViewModel(service: <#any TransactionsServiceProtocol#>)
    
  
    
    let walletView = UIView()
    let walletTitleLabel = UILabel()
    let walletNumberLabel = UILabel()
    let balanceLabel = UILabel()
    let cardexpiryLabel = UILabel()
    let tableView = UITableView()
    var latestHeader: UIButton!
    var responseMessage: String?
    var onError: ((String) -> Void)?
    var onSuccess: (() -> Void)?
    
    var data = ""
    var startDate = ""
    var endDate = ""
    var createdAt: String?
    var updatedAt: String?
   // private var transactions: [Transaction] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchLatestWalletTransaction()
        
        fetchLatestWalletTransaction(skey: skey)
        
        tableView.separatorStyle = .none
 
        viewModels.fetchLatestWalletTransaction(skey: skey) // Replace with the actual skey
        viewModel.fetchCardDetails(skey: skey)
   
        print("data card no ==", data)

        setupWalletView()
        setupTableView()

        // LatestWalletViewModel Setup
        viewModels.onSuccess = { [weak self] in
            DispatchQueue.main.async {
                self?.updateUILayouts()
                self?.tableView.reloadData() // Reload table data on success
            }
        }

        viewModels.onError = { [weak self] error in
            DispatchQueue.main.async {
                self?.showError(error)
            }
        }

        
        viewModel.onSuccess = { [weak self] in
               DispatchQueue.main.async {
                   self?.updateUILayoutss()
                   self?.tableView.reloadData()
               }
           }

           viewModel.onError = { [weak self] error in
               DispatchQueue.main.async {
                   self?.showError(error)
               }
           }
  
        setupWalletView()
        setupTableView()
       // layoutSubviews()
      //  updateUILayoutss()
   
    }
    
    
    
    
    func fetchLatestWalletTransaction() {
            let urlString = "https://api.maxupi.in/api/v1/wallet/p-latest-wallet"
            guard let url = URL(string: urlString) else { return }
            
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.addValue("Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySUQiOiIyIiwicGhvbmUiOiI4MDc2Mzk2MjY3IiwidWlkIjoiYTFkYWZiZDYtZTA2ZC00ZmE0LWE5NzktOWRlMmFhMzI1ZGI5IiwiaWF0IjoxNzI1MjU3OTg5LCJleHAiOjE3MzMwMzM5ODl9.XGFhoKFB7Zy_uN_EUqwRDaRI0yXgGo4t5w9ZluUlwS4", forHTTPHeaderField: "Authorization")
            let body: [String: Any] = ["skey": "AVJQIdwn79iR0zlP0iKNKumME"]
            request.httpBody = try? JSONSerialization.data(withJSONObject: body)
            
            let task = URLSession.shared.dataTask(with: request) { [weak self] data, response, error in
                guard let self = self else { return }
                if let error = error {
                    print("Error: \(error)")
                    return
                }
                
                guard let data = data else { return }
                
                do {
                    if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
                       let dataArray = json["data"] as? [[String: Any]],
                       let latestTransaction = dataArray.first {
                        
                        self.createdAt = latestTransaction["createdAt"] as? String
                        self.updatedAt = latestTransaction["updatedAt"] as? String
                        
                        // Use the values as needed
                        print("Created At: \(self.createdAt ?? "N/A")")
                        print("Updated At: \(self.updatedAt ?? "N/A")")
                    }
                } catch let jsonError {
                    print("JSON Error: \(jsonError)")
                }
            }
            
            task.resume()
        }
    
 
    private func updateUILayoutss() {
        print("Updating UI with card details")
        guard let cardDetails = viewModel.cardDetails else {
            print("No card details available")
            return
        }
        walletNumberLabel.text = (cardDetails.message.cardNumber)
        balanceLabel.text = "₹\(cardDetails.message.primaryWalletBalance)"
        cardexpiryLabel.text = "\(cardDetails.message.cardExpiry)"
    }


    private func showError(_ error: String) {
        let alert = UIAlertController(title: "Error", message: error, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }

    private func updateUILayouts() {
        // Update the UI with the success message
        guard let message = viewModels.responseMessage else { return }
        print("Success: \(message)")
    }

    func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(TransactionPrimaryCell.self, forCellReuseIdentifier: "TransactionPrimaryCell")
        tableView.tableFooterView = UIView()  // Remove extra separators
        tableView.separatorStyle = .singleLine
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)

        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: walletView.bottomAnchor, constant: 10),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

    func setupWalletView() {
        // Setup wallet view
        walletView.backgroundColor = UIColor.systemGreen.withAlphaComponent(0.2)
        walletView.layer.cornerRadius = 10
        walletView.layer.masksToBounds = true

        // Setup wallet title label
        walletTitleLabel.text = "Primary Wallet"
        walletTitleLabel.font = UIFont.boldSystemFont(ofSize: 18)
        walletTitleLabel.textAlignment = .center

        // Setup wallet number label
        walletNumberLabel.text = data
        walletNumberLabel.font = UIFont.systemFont(ofSize: 16)
        walletNumberLabel.textAlignment = .center

        // Setup balance label
       // balanceLabel.text = "₹ 7.00" // Example balance, update dynamically as needed
        balanceLabel.font = UIFont.boldSystemFont(ofSize: 18)
        balanceLabel.textAlignment = .right

        // Setup card expiry label
     //   cardexpiryLabel.text = "6/2028" // Example expiry date, update dynamically as needed
        cardexpiryLabel.font = UIFont.systemFont(ofSize: 16)
        cardexpiryLabel.textAlignment = .left

        // Add subviews
        walletView.addSubview(walletTitleLabel)
        walletView.addSubview(walletNumberLabel)
        walletView.addSubview(balanceLabel)
        walletView.addSubview(cardexpiryLabel)

        view.addSubview(walletView)

        // Set translatesAutoresizingMaskIntoConstraints to false
        walletView.translatesAutoresizingMaskIntoConstraints = false
        walletTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        walletNumberLabel.translatesAutoresizingMaskIntoConstraints = false
        balanceLabel.translatesAutoresizingMaskIntoConstraints = false
        cardexpiryLabel.translatesAutoresizingMaskIntoConstraints = false

        // Activate constraints
        NSLayoutConstraint.activate([
            // Wallet view constraints
            walletView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            walletView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            walletView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            walletView.heightAnchor.constraint(equalToConstant: 120),

            // Wallet title label constraints
            walletTitleLabel.topAnchor.constraint(equalTo: walletView.topAnchor, constant: 10),
            walletTitleLabel.centerXAnchor.constraint(equalTo: walletView.centerXAnchor),

            // Wallet number label constraints
            walletNumberLabel.topAnchor.constraint(equalTo: walletTitleLabel.bottomAnchor, constant: 10),
            walletNumberLabel.centerXAnchor.constraint(equalTo: walletView.centerXAnchor),

            // Balance label constraints (aligned to the right)
            balanceLabel.bottomAnchor.constraint(equalTo: walletView.bottomAnchor, constant: -10),
            balanceLabel.trailingAnchor.constraint(equalTo: walletView.trailingAnchor, constant: -10),

            // Card expiry label constraints (aligned to the left)
            cardexpiryLabel.bottomAnchor.constraint(equalTo: walletView.bottomAnchor, constant: -10),
            cardexpiryLabel.leadingAnchor.constraint(equalTo: walletView.leadingAnchor, constant: 10),
        ])
    }

    
    
    // TableView DataSource Methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModels.transactions.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TransactionPrimaryCell", for: indexPath) as! TransactionPrimaryCell
        let transaction = viewModels.transactions[indexPath.row]
        cell.separatorInset = UIEdgeInsets(top: cell.bounds.width, left: cell.bounds.size.width, bottom: 0, right: cell.bounds.width)
       
        cell.selectionStyle = .none
        
        cell.sNoLabel.text = "\(indexPath.row + 1)"
        cell.particularLabel.text = transaction.facility
        cell.amountLabel.text = transaction.amount
        cell.dateLabel.text = transaction.createdAt
        return cell
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = UIColor.systemGreen.withAlphaComponent(0.2)
        
        // Create labels for the header
        let sNoHeader = UILabel()
        sNoHeader.text = "S.No"
        sNoHeader.font = UIFont.boldSystemFont(ofSize: 14)
        sNoHeader.textAlignment = .center

        let particularHeader = UILabel()
        particularHeader.text = "Particular"
        particularHeader.font = UIFont.boldSystemFont(ofSize: 14)
        particularHeader.textAlignment = .center

        let amountHeader = UILabel()
        amountHeader.text = "Amount"
        amountHeader.font = UIFont.boldSystemFont(ofSize: 14)
        amountHeader.textAlignment = .center
        amountHeader.textColor = .systemGreen

        // Create a button with a down arrow for sorting options
        latestHeader = UIButton(type: .system)
        latestHeader.setTitle("Latest", for: .normal)
        latestHeader.setTitleColor(.black, for: .normal)
        latestHeader.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        
        // Set down arrow image next to the text
        latestHeader.setImage(UIImage(systemName: "arrowtriangle.down.fill"), for: .normal)
        latestHeader.tintColor = .black
        latestHeader.semanticContentAttribute = .forceRightToLeft // Arrow on right side
        latestHeader.addTarget(self, action: #selector(showSortingOptions), for: .touchUpInside)

        // Stack view to hold headers
        let headerStackView = UIStackView(arrangedSubviews: [sNoHeader, particularHeader, amountHeader, latestHeader])
        headerStackView.axis = .horizontal
        headerStackView.distribution = .fillEqually
        headerStackView.spacing = 10

        headerView.addSubview(headerStackView)
        headerStackView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            headerStackView.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 10),
            headerStackView.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: -10),
            headerStackView.topAnchor.constraint(equalTo: headerView.topAnchor, constant: 5),
            headerStackView.bottomAnchor.constraint(equalTo: headerView.bottomAnchor, constant: -5)
        ])

        return headerView
    }

    

    


//    
//    @objc func showSortingOptions() {
//        let alertController = UIAlertController(title: "Sort By", message: nil, preferredStyle: .actionSheet)
//        
//        alertController.addAction(UIAlertAction(title: "Latest", style: .default, handler: { [weak self] _ in
//            self?.latestHeader.setTitle("Latest", for: .normal)
//            self?.viewModels.fetchLatestWalletTransaction(skey: skey)
//        }))
//        
//        alertController.addAction(UIAlertAction(title: "By Date", style: .default, handler: { [weak self] _ in
//            self?.latestHeader.setTitle("By Date", for: .normal)
//            let date = self?.startDate ?? "" // Provide a default or prompt for a date
//            self?.viewModels.fetchTransactionsByDate(skey: skey, date: date)
//        }))
//        
//        alertController.addAction(UIAlertAction(title: "Old", style: .default, handler: { [weak self] _ in
//            self?.latestHeader.setTitle("Old", for: .normal)
//            // Handle Old sorting
//        }))
//        
//        alertController.addAction(UIAlertAction(title: "Date Range", style: .default, handler: { [weak self] _ in
//            self?.latestHeader.setTitle("Date Range", for: .normal)
//            let startDate = self?.startDate ?? ""
//            let endDate = self?.endDate ?? ""
//            self?.viewModels.fetchTransactions(skey: skey, startDate: startDate, endDate: endDate)
//        }))
//        
//        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
//        
//        if let topController = UIApplication.shared.keyWindow?.rootViewController {
//            topController.present(alertController, animated: true, completion: nil)
//        }
//    }
    
    
    
    @objc func showSortingOptions() {
        print("createdAtDates", createdAt ?? "nil")
        print("updatedAt", updatedAt ?? "nil")
        
        // Create alert controller
        let alertController = UIAlertController(title: "Sort By", message: nil, preferredStyle: .actionSheet)
        
        // Latest
        alertController.addAction(UIAlertAction(title: "Latest", style: .default, handler: { _ in
            // Update the title immediately on selection
            self.latestHeader.setTitle("Latest", for: .normal)
            
            // Perform the fetch and table reload on the main thread
            DispatchQueue.main.async {
                self.viewModels.fetchLatestWalletTransaction(skey: skey)
                self.tableView.reloadData()
                self.latestHeader.setTitle("Latest", for: .normal)
            }
        }))
        
        // By Date
        alertController.addAction(UIAlertAction(title: "By Date", style: .default, handler: { _ in
            // Update the title immediately on selection
            self.latestHeader.setTitle("By Date", for: .normal)
            
            // Perform the fetch and table reload on the main thread
            DispatchQueue.main.async {
                self.viewModels.fetchTransactions(skey: skey, date: self.createdAt ?? "")
                self.tableView.reloadData()
                self.latestHeader.setTitle("By Date", for: .normal)
            }
        }))
        
        // Old
        alertController.addAction(UIAlertAction(title: "Old", style: .default, handler: { _ in
            // Update the title immediately on selection
            self.latestHeader.setTitle("Old", for: .normal)
            
            // Perform the fetch and table reload on the main thread
            DispatchQueue.main.async {
                self.viewModels.fetchOldWalletTransactions(skey: skey)
                self.tableView.reloadData()
                self.latestHeader.setTitle("Old", for: .normal)
            }
        }))
        
        // Date Range
        alertController.addAction(UIAlertAction(title: "Date Range", style: .default, handler: { _ in
            // Update the title immediately on selection
            self.latestHeader.setTitle("Date Range", for: .normal)
            
            // Perform the fetch and table reload on the main thread
            DispatchQueue.main.async {
                self.viewModels.fetchTransactions(skey: skey, startDate: self.createdAt ?? "", endDate: self.updatedAt ?? "")
                self.tableView.reloadData()
                self.latestHeader.setTitle("Date Range", for: .normal)
            }
        }))
        
        // Cancel
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        // Present alert controller
        if let topController = UIApplication.shared.keyWindow?.rootViewController {
            topController.present(alertController, animated: true, completion: nil)
        }
    }

    func fetchLatestWalletTransaction(skey: String) {
        guard let url = URL(string: "https://api.maxupi.in/api/v1/wallet/p-latest-wallet") else {
            onError?("Invalid URL")
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer YOUR_BEARER_TOKEN", forHTTPHeaderField: "Authorization")

        let parameters: [String: Any] = ["skey": skey]

        do {
            let jsonData = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
            request.httpBody = jsonData
        } catch {
            onError?("Invalid parameters")
            return
        }

        let task = URLSession.shared.dataTask(with: request) { [weak self] data, response, error in
            guard let self = self else { return }

            if let error = error {
                DispatchQueue.main.async {
                    self.onError?(error.localizedDescription)
                }
                return
            }

            guard let data = data else {
                DispatchQueue.main.async {
                    self.onError?("No data received")
                }
                return
            }

            do {
                let response = try JSONDecoder().decode(LatestWalletResponse.self, from: data)
                if response.status == "failed" {
                    DispatchQueue.main.async {
                        self.onError?(response.message)
                    }
                } else {
                    self.viewModels.transactions = response.data // Update transactions data
                    DispatchQueue.main.async {
                        self.updateUILayouts()
                        self.tableView.reloadData() // Reload table data
                    }
                }
            } catch {
                DispatchQueue.main.async {
                    self.onError?("Failed to decode response")
                }
            }
        }

        task.resume()
    }

    
}




class TransactionPrimaryCell: UITableViewCell {

    let sNoLabel = UILabel()
    let particularLabel = UILabel()
    let amountLabel = UILabel()
    let dateLabel = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCell()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    
    func setupCell() {
        // Create a container view to hold the stack view
        let containerView = UIView()
        containerView.backgroundColor = UIColor.white
        containerView.layer.cornerRadius = 10
        containerView.layer.masksToBounds = true
        containerView.layer.borderColor = UIColor.lightGray.cgColor
        containerView.layer.borderWidth = 0.6
        
        contentView.addSubview(containerView)
        
        // Set constraints for the container view
        containerView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            containerView.heightAnchor.constraint(equalToConstant: 50),
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5)
        ])
        
        // Stack view to organize labels horizontally
        let stackView = UIStackView(arrangedSubviews: [sNoLabel, particularLabel, amountLabel, dateLabel])
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.alignment = .center
        stackView.spacing = 10
        containerView.addSubview(stackView)

        // Set translatesAutoresizingMaskIntoConstraints to false
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        // Activate constraints for the stack view inside the container view
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 0),
            stackView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 10),
            stackView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -10),
            stackView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: 0)
        ])

        // Customize labels
        sNoLabel.font = UIFont.systemFont(ofSize: 14)
        sNoLabel.textAlignment = .center

        particularLabel.font = UIFont.systemFont(ofSize: 14)
        particularLabel.textAlignment = .center

        amountLabel.font = UIFont.boldSystemFont(ofSize: 14)
        amountLabel.textColor = .systemGreen
        amountLabel.textAlignment = .center

        dateLabel.font = UIFont.systemFont(ofSize: 14)
        dateLabel.textAlignment = .right

        // Optional: Adjust the alignment or content mode as needed
    }

}


