import UIKit

final class ArticleListTableViewController: UITableViewController {

    init() {
        super.init(style: .insetGrouped)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private var currentPage = 1
    private var isLoading = false
    private var hasMoreArticle = true
    
    // Data structure to hold articles grouped by year
    private var groupedArticles: [(year: Int, articles: [Article])] = []
    
    private var articles = [Article]() {
        didSet {
            Task { @MainActor in
                self.groupArticlesByYear()
                self.tableView.reloadData()
                self.isLoading = false
            }
        }
    }
    
    // Group articles by year and sort years in descending order
    private func groupArticlesByYear() {
        let groupedByYear = Dictionary(grouping: articles) { $0.publicationYear }
        
        // Convert to array of tuples sorted by year (descending)
        groupedArticles = groupedByYear.map { (year: $0.key, articles: $0.value) }
            .sorted { $0.year > $1.year }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 100
        tableView.register(ArticleCell.self, forCellReuseIdentifier: "ArticleCell")
        title = "Headlines"
        showLoader()
        fetchArticle()
    }
    private func fetchArticle() {
        guard !isLoading , hasMoreArticle else { return }
        isLoading = true
        
        Task {
            do {
                let result = try await ArticleService.fetchArticles(page: currentPage)
                hasMoreArticle = result.hasMorePages
                currentPage += 1
                
                self.articles.append(contentsOf: result.articles)
                
            } catch {
                print(error)
                self.isLoading = false
            }
        }
    }
   private func showLoader() {
       let footerView = UIView(frame: CGRect(x: 10, y: 0, width: 30, height: 30))
       let spiner = UIActivityIndicatorView(style: .medium)
       spiner.translatesAutoresizingMaskIntoConstraints = false
       footerView.addSubview(spiner)
       NSLayoutConstraint.activate([
        spiner.centerXAnchor.constraint(equalTo: footerView.centerXAnchor),
        spiner.centerYAnchor.constraint(equalTo: footerView.centerYAnchor)
       ])
       
       spiner.startAnimating()
       tableView.tableFooterView = footerView
    }

    // MARK: - UITableViewDataSource

    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let position = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let scrollViewHeight = scrollView.frame.size.height
        
        if position > (contentHeight - scrollViewHeight - 100), !isLoading, hasMoreArticle {
            fetchArticle()
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return groupedArticles.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groupedArticles[section].articles.count
    }
    
    // Custom section header view with year label
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = UIColor.systemBackground
        
        let yearLabel = UILabel()
        yearLabel.translatesAutoresizingMaskIntoConstraints = false
        yearLabel.font = UIFont.boldSystemFont(ofSize: 20)
        yearLabel.textColor = UIColor.label
        yearLabel.text = String(groupedArticles[section].year)
        
        headerView.addSubview(yearLabel)
        
        NSLayoutConstraint.activate([
            yearLabel.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 16),
            yearLabel.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: -16),
            yearLabel.topAnchor.constraint(equalTo: headerView.topAnchor, constant: 8),
            yearLabel.bottomAnchor.constraint(equalTo: headerView.bottomAnchor, constant: -8)
        ])
        
        return headerView
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 44
    }

    // MARK: - UITableViewDelegate

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ArticleCell", for: indexPath) as! ArticleCell
        let article = groupedArticles[indexPath.section].articles[indexPath.row]
        return cell.configured(withTitle: article.webTitle, subtitle: article.formattedPublicationDate, imageURL: article.imageURL)
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let article = groupedArticles[indexPath.section].articles[indexPath.row]
        let detailViewController = ArticleDetailViewController(article: article)
        navigationController?.pushViewController(detailViewController, animated: true)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
