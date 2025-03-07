//
//  PendingOperations.swift
//  DownloadingImageExcercise
//
//  Created by fajar on 07/03/25.
//

import Foundation

class PendingOperations{
    lazy var downloadInProgress:[IndexPath:Operation] = [:]
    
    lazy var downloadQueue:OperationQueue = {
        var queue = OperationQueue()
        queue.name = "com.dicoding.imageDownload"
        queue.maxConcurrentOperationCount = 2
        return queue
    }()
    
}
