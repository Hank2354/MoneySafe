//
//  CategoriesSettingsViewController.swift
//  MoneySafe
//
//  Created by Vladislav Mashkov on 01.01.2022.
//

import Foundation
import UIKit

class CategoriesSettingsViewController: UIViewController, CategoriesSettingsViewControllerType {
    
    var presenter: CategoriesSettingsPresenterType?
    
    var categoryViews = [CategoryView]()
    
    // MARK: - Create UI Elements
    var headerLabel:                       UILabel          =  {
        
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
    
        label.text = "Изменение категорий"
        label.font = UIFont.boldSystemFont(ofSize: 36)
        label.textAlignment = .left
        label.adjustsFontSizeToFitWidth = true
        label.textColor = .white
    
        label.sizeToFit()
    
        return label
    }()
    
    var descriptionLabel:                  UILabel          =  {
        
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        
        label.text = "Выбирайте категории, просто нажимая на них"
        label.font = UIFont.systemFont(ofSize: 14)
        label.textAlignment = .left
        label.textColor = .white
        
        label.adjustsFontSizeToFitWidth = true
        label.sizeToFit()
        
        return label
    }()
    
    private var categoriesScrollView:      UIScrollView     =  {
        let scrollView = UIScrollView()
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        scrollView.bounces = true
        
        return scrollView
    }()
    
    lazy var continueButton:               UIButton         =  {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        
        button.isEnabled = true
        
        button.alpha = 1
        
        button.setTitle("Сохранить", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        button.setTitleColor(.black, for: .normal)
        
        button.backgroundColor = .white
        
        button.layer.cornerRadius = 16
        
        button.addTarget(self, action: #selector(saveCategories), for: .touchUpInside)
        
        return button
    }()
    
    private lazy var backNavBarButton:     UIBarButtonItem  =  {
        let buttonItem = UIBarButtonItem()
        buttonItem.image = .backButtonImage
        buttonItem.tintColor = .white
        
        buttonItem.addTarget(sender: self, action: #selector(backAction))
        
        return buttonItem
    }()
    
    // MARK: - Configuration methods
    private func setupLayout()                                                     {
        
        // MARK: - General setup
        view.addSubview(headerLabel)
        view.addSubview(descriptionLabel)
        view.addSubview(categoriesScrollView)
        view.addSubview(continueButton)
        
        var constraints = [NSLayoutConstraint]()
        
        constraints.append(headerLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: view.frame.height * 0.1))
        constraints.append(headerLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20))
        constraints.append(headerLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20))
        constraints.append(headerLabel.heightAnchor.constraint(lessThanOrEqualToConstant: 90))
        
        constraints.append(descriptionLabel.topAnchor.constraint(equalTo: headerLabel.bottomAnchor, constant: 15))
        constraints.append(descriptionLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20))
        constraints.append(descriptionLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20))
        
        constraints.append(categoriesScrollView.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 15))
        constraints.append(categoriesScrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 15))
        constraints.append(categoriesScrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -15))
        constraints.append(categoriesScrollView.bottomAnchor.constraint(equalTo: continueButton.topAnchor, constant: -20))
        
        constraints.append(continueButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10))
        constraints.append(continueButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10))
        constraints.append(continueButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10))
        constraints.append(continueButton.heightAnchor.constraint(equalToConstant: 50))
        
        NSLayoutConstraint.activate(constraints)
    }
    
    func setContinueButtonActiveStatus()                                           {
        continueButton.isEnabled = true
        continueButton.alpha = 1
    }
    
    func setContinueButtonDisactiveStatus()                                        {
        continueButton.isEnabled = false
        continueButton.alpha = 0.5
    }
    
    func continueButtonEnableTest()                                                {
        
        for element in categoryViews {
            
            if element.isActive {
                setContinueButtonActiveStatus()
                break
            }
            setContinueButtonDisactiveStatus()
        }

    }
    
    // MARK: - User actions
    @objc func backAction()                                                        {
        presenter?.isBackButtonPressed()
    }
    
    @objc func categoryButtonTapped(tapGestureRecognizer: UITapGestureRecognizer)  {
        
        guard let tappedView = tapGestureRecognizer.view as? CategoryView else { return }
        
        presenter?.changeCategoryViewStatus(tappedView: tappedView)
        
        continueButtonEnableTest()
    }
    
    @objc func saveCategories()                                                    {
        presenter?.isSaveButtonPressed()
    }
    
    // MARK: - Open methods
    func update(with categories: [GeneralCategoryModel])                           {
        
        for category in categories {
            let myView = CategoryView(categoryModel: category)
            
            myView.addGestureRecognizer(UITapGestureRecognizer(target: self,
                                                               action: #selector(categoryButtonTapped(tapGestureRecognizer:))))
            
            myView.heightAnchor.constraint(equalToConstant: 50).isActive = true
            myView.categoryViewType = category.categoryType
            
            categoryViews.append(myView)
        }
       
        let categoryViewsForLeftColumn = categoryViews.split()[0]
        let categoryViewsForRightColumn = categoryViews.split()[1]
        
        let leftColumnStackView = UIStackView(arrangedSubviews: categoryViewsForLeftColumn)
        leftColumnStackView.translatesAutoresizingMaskIntoConstraints = false
        leftColumnStackView.axis = .vertical
        leftColumnStackView.spacing = 20
        
        let rightColumnStackView = UIStackView(arrangedSubviews: categoryViewsForRightColumn)
        rightColumnStackView.translatesAutoresizingMaskIntoConstraints = false
        rightColumnStackView.axis = .vertical
        rightColumnStackView.spacing = 20
        
        let generalStackView = UIStackView(arrangedSubviews: [leftColumnStackView, rightColumnStackView])
        generalStackView.translatesAutoresizingMaskIntoConstraints = false
        generalStackView.axis = .horizontal
        generalStackView.spacing = 20
        generalStackView.distribution = .fillEqually
        
        categoriesScrollView.addSubview(generalStackView)
        
        NSLayoutConstraint.activate([
            generalStackView.widthAnchor.constraint(equalToConstant: view.frame.width - 30),
            generalStackView.leadingAnchor.constraint(equalTo: categoriesScrollView.leadingAnchor),
            generalStackView.trailingAnchor.constraint(equalTo: categoriesScrollView.trailingAnchor),
            generalStackView.topAnchor.constraint(equalTo: categoriesScrollView.topAnchor),
            generalStackView.bottomAnchor.constraint(equalTo: categoriesScrollView.bottomAnchor)
        ])
        
    }
    
    // MARK: - ViewController life cycle
    override func viewDidLoad()                                                    {
        super.viewDidLoad()
        
        view.backgroundColor = .mainBlue
        
        navigationItem.leftBarButtonItem = backNavBarButton
        
        setupLayout()
        
    }
}
