//
//  MovieTableViewCell.swift
//  DownloadingImageExcercise
//
//  Created by fajar on 07/03/25.
//

import UIKit

class MovieTableViewCell: UITableViewCell {

    @IBOutlet weak var indicatorLoading: UIActivityIndicatorView!
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var movieImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
