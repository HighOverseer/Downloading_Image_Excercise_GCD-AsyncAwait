//
//  ImageDownloader.swift
//  DownloadingImageExcercise
//
//  Created by fajar on 07/03/25.
//

import Foundation
import UIKit

class ImageDownloader:Operation{
    
    private let movie:Movie
    
    init(movie:Movie){
        self.movie = movie
    }
    
    override func main(){
        if isCancelled{
            return
        }
        
        guard let imageData = try? Data(contentsOf: self.movie.poster) else{
            return
        }
        
        if isCancelled{
            return
        }
        
        if (!imageData.isEmpty){
            movie.image = UIImage(data: imageData)
            movie.state = .downloaded
        }else{
            movie.image = nil
            movie.state = .failed
        }
    }
}
