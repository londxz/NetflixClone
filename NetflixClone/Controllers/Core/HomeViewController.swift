//
//  HomeViewController.swift
//  NetflixClone
//
//  Created by Родион Холодов on 29.07.2025.
//

import UIKit

enum Sections: Int {
    case Popular
    case TrendingMovies
    case TrendingTV
    case UpcomingMovies
    case TopRated
}

class HomeViewController: UIViewController {
    
    private var headerView: HeroHeaderView?
    
    private let sectionTitles = ["Popular", "Trending movies", "Trending tv", "Upcoming movies", "Top rated"]
    
    private let homeFeedTable: UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.register(CollectionViewTableViewCell.self, forCellReuseIdentifier: CollectionViewTableViewCell.identifier)
        table.backgroundColor = .black
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .black
        view.addSubview(homeFeedTable)
        
        homeFeedTable.delegate = self
        homeFeedTable.dataSource = self
        
        headerView = HeroHeaderView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: 450))
        homeFeedTable.tableHeaderView = headerView
        
        configureNavigationBar()
        configureHeaderView()
//        APICaller.shared.getMovie(with: "harry potter trailer") { result in
//            
//        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        homeFeedTable.frame = view.bounds
    }
    
    private func configureHeaderView() {
        APICaller.shared.getPopularMovies { [weak self] result in
            switch result {
            case .success(let titles):
                guard let randomTitle = titles.randomElement() else { return }
                let randomViewModel = TitleViewModel(title: randomTitle.title, posterPath: randomTitle.posterPath)
                self?.headerView?.configure(with: randomViewModel)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    private func configureNavigationBar() {
        let image = UIImage(named: "netflixLogo")?.withRenderingMode(.alwaysOriginal)
        let logoButton = UIButton()
        logoButton.setImage(image, for: .normal)
        logoButton.imageView?.contentMode = .scaleAspectFit
        
        logoButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            logoButton.widthAnchor.constraint(equalToConstant: 32),
            logoButton.heightAnchor.constraint(equalTo: logoButton.widthAnchor)
        ])
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: logoButton)
        navigationItem.rightBarButtonItems = [
            UIBarButtonItem(image: UIImage(systemName: "person"), style: .done, target: self, action: nil),
            UIBarButtonItem(image: UIImage(systemName: "play.rectangle"), style: .done, target: self, action: nil),
        ]
        
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.barTintColor = .black
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        sectionTitles.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CollectionViewTableViewCell.identifier, for: indexPath) as? CollectionViewTableViewCell else { return UITableViewCell() }
        
        cell.delegate = self
        
        switch indexPath.section {
        case Sections.Popular.rawValue:
            DispatchQueue.main.async {
                APICaller.shared.getPopularMovies { result in
                    switch result {
                    case .success(let titles):
                        cell.configure(with: titles)
                    case .failure(let error):
                        print(error.localizedDescription)
                    }
                }
            }
        case Sections.TrendingMovies.rawValue:
            DispatchQueue.main.async {
                APICaller.shared.getPopularMovies { result in
                    switch result {
                    case .success(let titles):
                        cell.configure(with: titles)
                    case .failure(let error):
                        print(error.localizedDescription)
                    }
                }
            }
        case Sections.TrendingTV.rawValue:
            DispatchQueue.main.async {
                APICaller.shared.getPopularMovies { result in
                    switch result {
                    case .success(let titles):
                        cell.configure(with: titles)
                    case .failure(let error):
                        print(error.localizedDescription)
                    }
                }
            }
        case Sections.UpcomingMovies.rawValue:
            DispatchQueue.main.async {
                APICaller.shared.getPopularMovies { result in
                    switch result {
                    case .success(let titles):
                        cell.configure(with: titles)
                    case .failure(let error):
                        print(error.localizedDescription)
                    }
                }
            }
        case Sections.TopRated.rawValue:
            DispatchQueue.main.async {
                APICaller.shared.getPopularMovies { result in
                    switch result {
                    case .success(let titles):
                        cell.configure(with: titles)
                    case .failure(let error):
                        print(error.localizedDescription)
                    }
                }
            }
        default:
            return UITableViewCell()
        }
    
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        200
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        40
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        guard let header = view as? UITableViewHeaderFooterView else { return }
        header.textLabel?.text = sectionTitles[section]
        header.textLabel?.font = .systemFont(ofSize: 18, weight: .semibold)
        header.textLabel?.textColor = .white
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        sectionTitles[section]
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let defaultOffset = view.safeAreaInsets.top
        let offset = scrollView.contentOffset.y + defaultOffset
        
        navigationController?.navigationBar.transform = CGAffineTransform(translationX: 0, y: min(0,-offset))
    }
}

extension HomeViewController: CollectionViewTableViewCellDelegate {
    func collectionViewTableViewCellDidTapCell(_ cell: CollectionViewTableViewCell, viewModel: TitlePreviewViewModel) {
        DispatchQueue.main.async { [weak self] in
            let vc = TitlePreviewViewController()
            vc.configure(with: viewModel)
            self?.navigationController?.pushViewController(vc, animated: true)
        }
    }
}
