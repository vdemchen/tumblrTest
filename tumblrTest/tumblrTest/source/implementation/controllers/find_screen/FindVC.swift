
import UIKit

class FindVC: UIViewController {
    
    //MARK: - Views properties
    
    @IBOutlet private weak var tableView: UITableView!
    
    private let searchController: UISearchController = UISearchController(searchResultsController: nil)
    private let worker = FindWorker()
   
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
    
    //MARK: - Private methods
    
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
        self.tableView.separatorStyle = .singleLine
    }
    
    private func setupCellEvents(completion: @escaping(CellEvents)->()) {
        let events: CellEvents = CellEvents { [weak self] (feed) in
            guard let strongSelf = self else { return }
            let vc = InfoVC()
            
            strongSelf.navigationController?.pushViewController(vc, animated: true)
        }
        completion(events)
    }
}


extension FindVC: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.worker.findFeed(tag: searchBar.text ?? "") { (result) in
            switch result {
            case .success(_):
                PopupView().showNotificationMessage(title: "Ready!")
            case .error:
                PopupView().showNotificationMessage(title: "Nothing find!", colorView: UIColor.red)
            }
            self.tableView.reloadData()
        }
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
        self.setupCellEvents { (events) in
            cell.events = events
        }
        cell.feed = TempDataManager.shared.items[indexPath.row]
        return cell
    }
    
    
}

