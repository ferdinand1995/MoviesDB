//
//  MoviesVC.swift
//  MoviesDB
//
//  Created by Ferdinand on 18/11/22.
//

import UIKit
import SnapKit

class MoviesVC: UIViewController {

    // MARK: UIView
    private(set) lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: PinterestLayout())
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.setContentOffset(CGPoint.zero, animated: false)
        collectionView.backgroundColor = UIColor.white
        return collectionView
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 32)
        label.text = "OMDb API"
        label.textColor = UIColor.softBlackDarkMode
        return label
    }()

    private let searchView: UIView = {
        let view = UIView()
        if #available(iOS 13.0, *) {
            view.backgroundColor = .systemBackground
        } else {
            view.backgroundColor = .white
        }
        return view
    }()

    private let searchTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Search..."
        textField.font = UIFont.mainFont(ofSize: 14)
        return textField
    }()

    private let searchImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "ic_search")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    let cancelButton: UIButton = {
        let button = UIButton()
        button.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        button.setTitle("Cancel", for: .normal)
        button.setTitleColor(UIColor.softBlackDarkMode, for: .normal)
        return button
    }()

    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 8
        stackView.alignment = .fill
        stackView.distribution = .fill
        return stackView
    }()
    
    // MARK: Variables
    var presenter: MoviesPresentation?

    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
        initLayout()
        registerForKeyboardNotifications()
        self.hideKeyboardWhenTappedAround()
        presenter?.viewDidLoad()
    }

    // MARK: Initialize
    private func initView() {
        view.backgroundColor = .brokenWhiteDarkMode
        view.addSubview(titleLabel)
        searchView.layer.cornerRadius = 8
        searchView.layer.masksToBounds = true
        searchView.layer.borderWidth = 0.6
        searchView.layer.borderColor = UIColor.softBlackDarkMode.cgColor
        searchView.addSubview(searchImageView)
        searchTextField.returnKeyType = UIReturnKeyType.search
        searchTextField.delegate = self
        searchView.addSubview(searchTextField)
        cancelButton.isHidden = true
        cancelButton.addTarget(self, action: #selector(cancelButtonTapped(_:)), for: .touchUpInside)
        [searchView, cancelButton].forEach { stackView.addArrangedSubview($0) }
        view.addSubview(stackView)
        if let layout = collectionView.collectionViewLayout as? PinterestLayout {
            layout.delegate = self
        }
        collectionView.backgroundColor = .brokenWhiteDarkMode
        collectionView.register(cellWithClass: MovieContentCell.self)
        collectionView.dataSource = self
        collectionView.delegate = self
        view.addSubview(collectionView)
    }

    private func initLayout() {

        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(16)
            make.leading.equalToSuperview().offset(16)
        }

        stackView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(8)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(56)
        }

        searchImageView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(8)
            make.centerY.equalToSuperview()
            make.width.equalTo(24)
        }

        searchTextField.snp.makeConstraints { make in
            make.leading.equalTo(searchImageView.snp.trailing).offset(8)
            make.top.equalToSuperview().offset(16)
            make.bottom.equalToSuperview().offset(-16)
            make.trailing.equalToSuperview()
        }

        collectionView.snp.makeConstraints { make in
            make.top.equalTo(stackView.snp.bottom).offset(8)
            make.bottom.trailing.leading.equalToSuperview()
        }
    }

    // MARK: Action
    @objc func cancelButtonTapped(_ sender: UIButton) {
        UIView.animate(withDuration: 0.3, delay: 0, options: [.curveEaseOut], animations: {
                guard !self.cancelButton.isHidden else { return }
                self.cancelButton.isHidden = true
                self.cancelButton.alpha = 0
                self.searchTextField.resignFirstResponder()
                self.view.layoutIfNeeded()
            })
    }

    // MARK: Keyboard Handler
    override func dismissKeyboard() {
        super.dismissKeyboard()
        cancelButtonTapped(self.cancelButton)
    }

    private func registerForKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardShown(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
    }

    @objc private func keyboardShown(_ notificiation: NSNotification) {
        collectionView.setContentOffset(CGPoint.zero, animated: false)
    }
}

// MARK: Action
extension MoviesVC: MoviesView {
    
    func showErrorMessage() {
        let errorTitle: String = "Error"
        let alertController = UIAlertController(title: errorTitle, message: "Ooops, something went wrong. Please try again later!")
        self.present(alertController, animated: true)
    }
    
    func showMoviesData(_ movies: OMDBResult?) {
        if let searchResult = movies?.search?.count, searchResult > 0 {
            collectionView.backgroundView = nil
        } else {
            collectionView.backgroundView = EmptyView(frame: collectionView.frame)
        }
        collectionView.reloadData()
    }
}
