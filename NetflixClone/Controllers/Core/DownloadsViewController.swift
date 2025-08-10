//
//  DownloadsViewController.swift
//  NetflixClone
//
//  Created by Родион Холодов on 29.07.2025.
//

import UIKit

class DownloadsViewController: UIViewController {
    
    private var titles = [TitleItem]()
    
    private let downloadsTable: UITableView = {
        let tableView = UITableView()
        tableView.register(TitleTableViewCell.self, forCellReuseIdentifier: TitleTableViewCell.identifier)
        tableView.backgroundColor = .black
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .black
        
        title = "Downloads"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.barTintColor = .black
        
        downloadsTable.dataSource = self
        downloadsTable.delegate = self
        
        view.addSubview(downloadsTable)
        fetchTitlesFromLocalStorage()
        NotificationCenter.default.addObserver(forName: Notification.Name("Download"), object: nil, queue: nil) { [weak self] _ in
            self?.fetchTitlesFromLocalStorage()
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        downloadsTable.frame = view.bounds
    }
    
    private func fetchTitlesFromLocalStorage() {
        DataPersistenceManager.shared.fetchTitles { [weak self] result in
            switch result {
            case .success(let titles):
                self?.titles = titles
                self?.downloadsTable.reloadData()
            case .failure(let error):
                print(error)
            }
        }
    }
}

extension DownloadsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        titles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
       guard let cell = tableView.dequeueReusableCell(withIdentifier: TitleTableViewCell.identifier, for: indexPath) as? TitleTableViewCell else { return UITableViewCell() }
        
        let title = titles[indexPath.row]
        cell.configure(with: TitleViewModel(title: title.title ?? "Unknown title", posterPath: title.posterPath ?? ""))
        cell.textLabel?.textColor = .white
        cell.backgroundColor = .black
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        200
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        DispatchQueue.main.async { [weak self] in
            let vc = TitlePreviewViewController()
            guard let title = self?.titles[indexPath.row] else { return }
            let viewModel = TitlePreviewViewModel(title: title.title ?? "Unknown title", description: title.overview ?? "No description")
            vc.configure(with: viewModel)
            self?.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        switch editingStyle {
        case .delete:
            DataPersistenceManager.shared.deleteTitleWith(model: titles[indexPath.row]) { [weak self] result in
                switch result {
                case .success():
                    print("Title deleted from local storage")
                    self?.titles.remove(at: indexPath.row)
                    self?.downloadsTable.deleteRows(at: [indexPath], with: .fade)
                case .failure(let error):
                    print(error)
                }
            }
        default:
            break
        }
    }
}
