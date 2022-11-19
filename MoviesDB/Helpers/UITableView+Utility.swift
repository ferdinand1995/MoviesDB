//
//  UITableView+Utility.swift
//
//
//  Created by Ferdinand on 18/11/22.
//

import UIKit
import SnapKit

extension UITableView {

    func setEmptyView(title: String, message: String = "") {

        let emptyView = UIView(frame: CGRect(x: self.center.x, y: self.center.y, width: self.bounds.size.width, height: self.bounds.size.height))

        let titleLabel = UILabel()
        let messageLabel = UILabel()

        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        messageLabel.translatesAutoresizingMaskIntoConstraints = false

        titleLabel.textColor = UIColor.softBlackDarkMode
        titleLabel.font = UIFont.boldMainFont(ofSize: 16)

        if #available(iOS 13.0, *) {
            messageLabel.textColor = UIColor.systemGray2
        } else {
            messageLabel.textColor = UIColor.lightGray
        }
        messageLabel.font = UIFont.mainFont(ofSize: 14)

        emptyView.addSubview(titleLabel)
        emptyView.addSubview(messageLabel)

        titleLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(-16)
        }
        
        messageLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(16)
            make.centerX.equalToSuperview()
        }

        titleLabel.text = title
        messageLabel.text = message
        messageLabel.numberOfLines = 0
        messageLabel.textAlignment = .center

        self.backgroundView = emptyView
        self.separatorStyle = .none
    }

    func restore() {
        self.backgroundView = nil
        self.separatorStyle = .singleLine
    }
}
