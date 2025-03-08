//
//  ImageDownloader.swift
//  DownloadingImageExcercise
//
//  Created by fajar on 07/03/25.
//

import Foundation
import UIKit

class ImageDownloader{
    
    func downloadImage(url:URL) async throws -> UIImage {
        async let data = try Data(contentsOf: url)
        return UIImage(data: try await data)!
    }
    
    
}
