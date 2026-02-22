//
//  ViewController.swift
//  FirstApp
//
//  Created by victoria on 22.02.2026.
//

import UIKit

class ViewController: UIViewController {

    // MARK: - Constants
    
    private enum Constant {
        enum Layout {
            static let sideInset: CGFloat = 16
            static let imageHeight: CGFloat = 250
            static let buttonHeight: CGFloat = 44
        }
    }
    
    // MARK: - Models
    
    private struct GalleryItem {
        let imageName: String
        let title: String
    }
    
    // MARK: - Subviews
    
    private let headerLabel: UILabel = {
        let label = UILabel()
        label.text = "Кошки"
        label.font = .systemFont(ofSize: 28, weight: .bold)
        label.textAlignment = .center
        label.textColor = .black
        label.numberOfLines = 0
        label.setContentHuggingPriority(.required, for: .vertical)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .medium)
        label.textAlignment = .center
        label.textColor = .black
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var previousButton: UIButton = {
        var config = UIButton.Configuration.plain()
        config.title = "⬅️ Влево"
        config.baseForegroundColor = .black
        config.contentInsets = NSDirectionalEdgeInsets(
            top: 8,
            leading: 16,
            bottom: 8,
            trailing: 16
        )
        
        let button = UIButton(configuration: config)
        
        button.layer.cornerRadius = 12
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.black.cgColor
        
        button.addAction(
            UIAction { [weak self] _ in
                self?.showPrevious()
            },
            for: .touchUpInside
        )
        
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var nextButton: UIButton = {
        var config = UIButton.Configuration.plain()
        config.title = "Вправо ➡️"
        config.baseForegroundColor = .black
        config.contentInsets = NSDirectionalEdgeInsets(
            top: 8,
            leading: 16,
            bottom: 8,
            trailing: 16
        )
        
        let button = UIButton(configuration: config)
        
        button.layer.cornerRadius = 12
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.black.cgColor
        
        button.addAction(
            UIAction { [weak self] _ in
                self?.showNext()
            },
            for: .touchUpInside
        )
        
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var buttonStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [previousButton, nextButton])
        stack.axis = .horizontal
        stack.spacing = 20
        stack.alignment = .center
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private lazy var mainStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [
            headerLabel,
            imageView,
            titleLabel,
            buttonStack
        ])
        stack.axis = .vertical
        stack.spacing = 25
        stack.alignment = .center
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    // MARK: - Properties
    
    private let items: [GalleryItem] = [
        GalleryItem(imageName: "koshka", title: "Кошка"),
        GalleryItem(imageName: "busya", title: "Буся"),
        GalleryItem(imageName: "stesha", title: "Стеша"),
        GalleryItem(imageName: "lastik", title: "Ластик"),
        GalleryItem(imageName: "muska", title: "Муська"),
    ]
    
    private var currentIndex: Int = 0
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        updateUI()
    }
    
    // MARK: - Methods
    
    private func configureView() {
        view.backgroundColor = .white
        
        view.addSubview(mainStack)
        
        NSLayoutConstraint.activate([
            mainStack.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            mainStack.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            mainStack.leadingAnchor.constraint(greaterThanOrEqualTo: view.leadingAnchor, constant: 20),
            mainStack.trailingAnchor.constraint(lessThanOrEqualTo: view.trailingAnchor, constant: -20),
            
            imageView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8),
            imageView.heightAnchor.constraint(equalToConstant: 250)
        ])
    }
    
    private func updateUI() {
        let item = items[currentIndex]
        imageView.image = UIImage(named: item.imageName)
        titleLabel.text = item.title
    }
    
    private func showNext() {
        currentIndex += 1
        if currentIndex >= items.count {
            currentIndex = 0
        }
        updateUI()
    }
    
    private func showPrevious() {
        currentIndex -= 1
        if currentIndex < 0 {
            currentIndex = items.count - 1
        }
        updateUI()
    }
}
