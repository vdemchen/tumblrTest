
import UIKit

class FindVC: UIViewController {
    
    //MARK: - Views properties
    
    @IBOutlet private weak var tableView: UITableView!
    
    private let searchController: UISearchController = UISearchController(searchResultsController: nil)
    private var timer: Timer? = nil

    
    //MARK: - Private Properties
    
    
    //MARK: - Public Properties
    
    
    
    //MARK: - Lifecycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setupNavigationBar()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupView()
    }
    
    //MARK: - Setup View
    
    private func setupView() {
        self.setupSearchBar()
        self.setupTableView()
        self.navigationItem.searchController = self.searchController
    }
    
    private func setupNavigationBar() {
        self.navigationController?.isNavigationBarHidden = false
        self.title = "Find on Tumblr"
    }
    
    private func setupSearchBar() {
        self.searchController.searchBar.delegate = self
        self.searchController.hidesNavigationBarDuringPresentation = false
        self.searchController.dimsBackgroundDuringPresentation = false
        self.searchController.searchBar.placeholder = "Type something..."
        self.searchController.searchBar.sizeToFit()
        if #available(iOS 11.0, *) {
            self.navigationItem.hidesSearchBarWhenScrolling = true
        }
        self.searchController.searchBar.searchBarStyle = .minimal
        self.searchController.isActive = true
    }
    
    private func setupTableView() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(
            PostTableViewCell.nib(),
            forCellReuseIdentifier: PostTableViewCell.identifier()
        )
        self.tableView.separatorStyle = .none
    }
    
    //MARK: - Private methods
    
    private func makeRequest(tag: String) {
        RequestBuilder.findPost(tag: tag) { (result) in
            switch result {
            case .success(let data):
                TempDataManager.updateItems(data: data.response)
                self.tableView.reloadData()
            case .error(let error):
                self.showErrorAlertWith(message: error?.localizedDescription ?? "")
            }
        }
    }
    
    //MARK: - Public methods
}


extension FindVC: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        TempDataManager.deleteItems()
        self.makeRequest(tag: searchBar.text ?? "")
    }
}

extension FindVC: UITableViewDelegate {
    
}

extension FindVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return TempDataManager.shared.items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: PostTableViewCell.identifier(),
            for: indexPath
            ) as! PostTableViewCell
        cell.feed = TempDataManager.shared.items[indexPath.row]
        return cell
    }
    
    
}

