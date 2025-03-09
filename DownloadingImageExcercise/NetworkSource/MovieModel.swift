//
//  MovieModel.swift
//  DownloadingImageExcercise
//
//  Created by fajar on 07/03/25.
//

import Foundation
import UIKit

enum DownloadState{
    case new, downloaded, failed
}

class Movie {
  let id:Int
  let overview:String
    
  let title: String
  let poster: URL
    
  var state: DownloadState = .new
  var image:UIImage?
 
init(id:Int, overview:String, title: String, poster: URL) {
    self.id = id
    self.overview = overview
    self.title = title
    self.poster = poster
  }
}

