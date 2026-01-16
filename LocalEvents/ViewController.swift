//
//  ViewController.swift
//  Local Events
//
//  Created by Dimitra Malliarou on 13/1/26.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate{
    
    @IBOutlet var tableView: UITableView!
    @IBOutlet var spinner: UIActivityIndicatorView!
    
    private let loadEventsViewModel: LoadEventsViewModel
    private let loadImages = LoadImage()
    
    init(loadEventsViewModel: LoadEventsViewModel) {
        self.loadEventsViewModel = loadEventsViewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        self.loadEventsViewModel = LoadEventsViewModel()
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Events"
        tableView.dataSource = self
        tableView.delegate = self
        
        spinner.isHidden = false
        spinner.startAnimating()
        bindViewModel()
        loadEventsViewModel.loadEvents()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return loadEventsViewModel.events.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "EventCell", for: indexPath) as! TableViewCell
        
        let imageURL = URL(string: "https://dev.loqiva.com/\(loadEventsViewModel.events[indexPath.row].mediaurl ?? "")")
        loadImages.loadImage(url: imageURL!) { (image) in
            DispatchQueue.main.async {
                cell.eventImageView.image = image
            }
        }
        cell.eventImageView.contentMode = .scaleAspectFill
        cell.eventImageView.clipsToBounds = true
        cell.eventImageView.layer.cornerRadius = 10
        cell.eventImageView.layer.masksToBounds = true
        
        cell.titleLebel.text = loadEventsViewModel.events[indexPath.row].title
        
        if let data = loadEventsViewModel.events[indexPath.row].description.data(using: String.Encoding.unicode), let attributeString = try? NSAttributedString(data:data, options: [.documentType: NSAttributedString.DocumentType.html], documentAttributes: nil) {
            
            cell.descriptionLebel.attributedText = attributeString
        }
        
        return cell
    }
}

private extension ViewController {
    private func bindViewModel() {
        loadEventsViewModel.onEventsFetched = { [weak self] in
            self?.tableView.reloadData()
            self?.spinner.stopAnimating()
        }
        
        loadEventsViewModel.onEventsCanceled = { [weak self] in
            self?.spinner.stopAnimating()
        }
    }
}
