//
//  CategoriesView.swift
//  SpaceOdyssey
//
//  Created by NIKOLAI BORISOV on 09.12.2021.
//

import UIKit

/// Class contains UIElements for CategoriesViewController
final class CategoriesView: UIView {
    
    // MARK: - Public Properties
    
    public var cellHeight: CGFloat = 100
    
    public lazy var categoriesTableView: UITableView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.isScrollEnabled = true
        $0.register(cell: CategoriesCell.self)
        $0.backgroundColor = .black
        $0.contentInsetAdjustmentBehavior = .never
        $0.separatorColor = .lightGray
        return $0
    }(UITableView())
    
    // MARK: - Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
        addSubviews()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private Methods
    
    private func setupView() {
        backgroundColor = .black
    }
    
    private func addSubviews() {
        addSubview(categoriesTableView)
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            categoriesTableView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            categoriesTableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            categoriesTableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            categoriesTableView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
}
