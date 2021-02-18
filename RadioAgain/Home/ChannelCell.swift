//
//  ChannelCell.swift
//  RadioAgain
//
//  Created by Keval Patel on 11/22/20.
//

import UIKit

struct ChannelCellModel {
    let title: String
    let channelImageUrl: String
    let dj: String
    let genre: String
    let disclabel: String
}
class ChannelCell: UITableViewCell {
    @IBOutlet weak var channelImage: UIImageView!
    @IBOutlet weak var dj: UILabel!
    @IBOutlet weak var genre: UILabel!
    @IBOutlet weak var disclabel: UILabel!
    @IBOutlet weak var title: UILabel!

    override class func awakeFromNib() {
        super.awakeFromNib()
    }
    
    public func update(channelCellModel: ChannelCellModel) {
        title.text = channelCellModel.title
        dj.text = channelCellModel.dj
        genre.text = channelCellModel.genre
        disclabel.text = channelCellModel.disclabel
    }
    
}
