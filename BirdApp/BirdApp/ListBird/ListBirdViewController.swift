//
//  ViewController.swift
//  BirdApp
//
//  Created by Nelson Ramirez on 28-08-22.
//

import UIKit

class ListBirdViewController: UIViewController {
    private let tableView = UITableView()
    private let refreshControl = UIRefreshControl()
    private let searchController = UISearchController()
    
    private var birds = [Bird]()
    private var filteredBirds = [Bird]()
    
    var isSearchBarEmpty: Bool {
      return searchController.searchBar.text?.isEmpty ?? true
    }
    
    var isFiltering: Bool {
      return searchController.isActive && !isSearchBarEmpty
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = ListBirdConstants.title
        navigationController?.title = ListBirdConstants.title
        
        setUpView()
        
        fetchBirdsAndUpdateView()
    }
    
    private func setUpView() {
        setUpTableView()
        setUpRefreshControl()
        setUpSearchBar()
    }
    
    private func setUpTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = UITableView.automaticDimension
        tableView.register(BirdDetailCell.self, forCellReuseIdentifier: "birdCell")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.refreshControl = refreshControl
        view.addSubview(tableView)
    
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func setUpRefreshControl() {
        refreshControl.addTarget(self, action: #selector(fetchBirdsAndUpdateView), for: .valueChanged)
    }
    
    private func setUpSearchBar() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Buscar pajaritos"
        navigationItem.searchController = searchController
        definesPresentationContext = true
        navigationItem.hidesSearchBarWhenScrolling = false
    }
    
    private func filterContentForSearchText(_ searchText: String) {
      filteredBirds = birds.filter { (bird: Bird) -> Bool in
          return bird.name.spanish.lowercased().contains(searchText.lowercased())
      }
      
      tableView.reloadData()
    }

    @objc
    private func fetchBirdsAndUpdateView() {
        fetchBirds { [weak self] birds in
            self?.birds = birds
            
            DispatchQueue.main.async {
                self?.tableView.reloadData()
                self?.refreshControl.endRefreshing()
                
            }
        }
    }
    
    private func fetchBirds(completionHandler: @escaping ([Bird]) -> Void) {
        guard let url = URL(string: "https://aves.ninjas.cl/api/birds") else { return }

        let task = URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
          if let error = error {
            print("Error with fetching birds: \(error)")
            return
          }
          
          guard let httpResponse = response as? HTTPURLResponse,
                (200...299).contains(httpResponse.statusCode) else {
              print("Error with the response, unexpected status code: \(String(describing: response))")
            return
          }

          if let data = data,
            let birds = try? JSONDecoder().decode([Bird].self, from: data) {
            completionHandler(birds)
          }
        })
        task.resume()
    }
    
    private func showBigPicture(indexPath: IndexPath) {
        let fullImage: String
        
        if isFiltering {
            fullImage = filteredBirds[indexPath.row].images.full
        } else {
            fullImage = birds[indexPath.row].images.full
        }
        
        let viewController = BigPictureViewController(imageUrl: fullImage)
        self.present(viewController, animated: true)
    }
}

extension ListBirdViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltering {
            return filteredBirds.count
        }
            
        return birds.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard
            let cell = tableView.dequeueReusableCell(withIdentifier: "birdCell", for: indexPath) as? BirdDetailCell
        else {
            return UITableViewCell()
        }
        
        let bird: Bird
        
        if isFiltering {
            bird = filteredBirds[indexPath.row]
        } else {
            bird = birds[indexPath.row]
        }
    
        cell.configure(
            imageUrl: bird.images.thumb,
            latinName: bird.name.latin,
            spanishName: bird.name.spanish,
            englishName: bird.name.english
        )
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        showBigPicture(indexPath: indexPath)
    }
}

extension ListBirdViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        guard let text = searchBar.text else { return }
        filterContentForSearchText(text)
    }
}
