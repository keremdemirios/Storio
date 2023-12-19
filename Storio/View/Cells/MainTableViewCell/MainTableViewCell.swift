//
//  MainTableViewCell.swift
//  Storio
//
//  Created by Kerem Demir on 19.12.2023.
//

import UIKit

class MainTableViewCell: UITableViewCell {

    public static var identifier: String {
        get {
            return "MainTableViewCell"
        }
    }
    
    public static func register() -> UINib {
        UINib(nibName: "MainTableViewCell", bundle: nil)
    }
    
    @IBOutlet weak var nicknameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
