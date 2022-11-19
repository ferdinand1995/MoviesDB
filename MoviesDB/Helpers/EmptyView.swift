//
//  EmptyView.swift
//  MoviesDB
//
//  Created by Ferdinand on 19/11/22.
//

import UIKit
import SnapKit

class EmptyView: UIView {
    
    // MARK: View
    private let wrapperView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.isOpaque = true
        return view
    }()
    
    private let emptyImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "ic_film")?.withColor(UIColor.darkGrayDarkMode)
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.text = "You haven't search movie yet!"
        label.textAlignment = .center
        label.textColor = UIColor.softBlackDarkMode
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        initView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override class var requiresConstraintBasedLayout: Bool {
        return true
    }
    
    private func initView() {
        wrapperView.addSubview(emptyImageView)
        wrapperView.addSubview(titleLabel)
        addSubview(wrapperView)
        initLayout()
    }

    // MARK: Layout
    private func initLayout() {
        wrapperView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(32)
            make.trailing.equalToSuperview().offset(-32)
            make.center.equalToSuperview()
        }
        
        emptyImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.centerX.equalToSuperview()
            make.width.height.equalTo(40)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(emptyImageView.snp.bottom).offset(16)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
        }
    }
}
