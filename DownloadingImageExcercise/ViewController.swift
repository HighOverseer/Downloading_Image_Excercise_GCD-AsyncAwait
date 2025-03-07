//
//  ViewController.swift
//  DownloadingImageExcercise
//
//  Created by fajar on 07/03/25.
//

import UIKit

class ViewController: UIViewController{
   

    @IBOutlet weak var movieTableView: UITableView!
    
    private let pendingOperations = PendingOperations()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        movieTableView.register(UINib(nibName: "MovieTableViewCell", bundle: nil), forCellReuseIdentifier: "movieTableViewCell")
        
        movieTableView.dataSource = self
    }
    
    fileprivate func startOperations(movie:Movie, indexPath:IndexPath){
        if movie.state == .new{
            startDownload(movie: movie, indexPath: indexPath)
        }
    }
    
    fileprivate func startDownload(movie:Movie, indexPath:IndexPath){
        guard pendingOperations.downloadInProgress[indexPath] == nil else{
            return
        }
        
        let imageDownloader = ImageDownloader(movie: movie)
        
        imageDownloader.completionBlock = {
            if imageDownloader.isCancelled{
                return
            }
            
            DispatchQueue.main.async {
                self.pendingOperations.downloadInProgress.removeValue(forKey: indexPath)
                self.movieTableView.reloadRows(at: [indexPath], with: .automatic)
            }
        }
        
        self.pendingOperations.downloadInProgress[indexPath] = imageDownloader
        self.pendingOperations.downloadQueue.addOperation(imageDownloader)
    }
    
    fileprivate func toggleSuspendOperations(isSuspended:Bool){
        pendingOperations.downloadQueue.isSuspended = isSuspended
    }

}


extension ViewController: UITableViewDataSource, UIScrollViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(
            withIdentifier: "movieTableViewCell",
            for: indexPath
        ) as? MovieTableViewCell{
            let movie = movies[indexPath.row]
            
            cell.movieTitle.text = movie.title
            cell.movieImage.image = movie.image
            
            if movie.state == .new{
                cell.indicatorLoading.isHidden = false
                cell.indicatorLoading.startAnimating()
                startOperations(movie: movie, indexPath: indexPath)
            }else{
                cell.indicatorLoading.stopAnimating()
                cell.indicatorLoading.isHidden = true
            }
            
            return cell
            
        }else{
            return UITableViewCell()
        }
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        toggleSuspendOperations(isSuspended: true)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        toggleSuspendOperations(isSuspended: false)
    }
}
