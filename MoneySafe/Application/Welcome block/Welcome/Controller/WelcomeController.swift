//
//  WelcomeController.swift
//  MoneySafe
//
//  Created by Vladislav Mashkov on 17.12.2021.
//

import UIKit

private let reuseIdentifier = "Cell"

class WelcomeController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    // MARK: - General variables
    var pages = [
        PageModel(imagename: "welcomeImage1",
                  header: "Анализируйте ваши расходы",
                  description: "Оптимизируйте свои расходы для накопления средств от месяца к месяцу"),
        
        PageModel(imagename: "welcomeImage2",
                  header: "Планируйте свой бюджет",
                  description: "Устанавливайте необходимые ограничения для категорий, чтобы не тратить больше, чем планировали"),
        
        PageModel(imagename: "welcomeImage3",
                  header: "Давайте настроим ваш аккаунт!",
                  description: "Мы добавим кошельки, а так же выберем необходимые категории")
    ]
    
    // MARK: - button targets methods
    @objc private func previousPage()  {
        let maxIndex = pages.count - 1
        let nextIndex = min(pageControl.currentPage - 1, maxIndex)
        let indexPath = IndexPath(item: nextIndex, section: 0)
        
        pageControl.currentPage = nextIndex
        
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }
    
    @objc private func nextPage()      {
        
        if pageControl.currentPage == pageControl.numberOfPages - 1 {
            UserDefaults.standard.set(true, forKey: "firstLoad")
            
            let appDelegate = UIApplication.shared.delegate as? AppDelegate
            guard let appDelegate = appDelegate else { return }
            
            appDelegate.startingSetupBlockStarting()
        }
        
        let maxIndex = pages.count - 1
        let nextIndex = min(pageControl.currentPage + 1, maxIndex)
        let indexPath = IndexPath(item: nextIndex, section: 0)
        
        pageControl.currentPage = nextIndex
        
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        
        
    }
    
    // MARK: - Create and setup bottom panel
    private var pageControl:      UIPageControl   =   {
        let pc = UIPageControl()
        pc.translatesAutoresizingMaskIntoConstraints = false
        
        pc.allowsContinuousInteraction = false
        pc.backgroundStyle = .minimal
        
        pc.currentPage = 1
        pc.numberOfPages = 3
        
        pc.isUserInteractionEnabled = false
        
        pc.currentPageIndicatorTintColor = UIColor.mainPurple
        pc.pageIndicatorTintColor = UIColor.lazyPurple
        
        return pc
    }()
    
    private var aheadButton:      UIButton        =   {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        
        button.setTitle("Далее", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        button.setTitleColor(UIColor.mainPurple, for: .normal)
        
        button.addTarget(self, action: #selector(nextPage), for: .touchUpInside)
        
        return button
    }()
    
    private var previousButton:   UIButton        =   {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        
        button.setTitle("Назад", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        button.setTitleColor(UIColor.lazyGray, for: .normal)
        
        button.addTarget(self, action: #selector(previousPage), for: .touchUpInside)
        
        return button
    }()
    
    private func setupBottomPanel()    {
        
        let bottomStackView = UIStackView(arrangedSubviews: [previousButton, pageControl, aheadButton])
        bottomStackView.translatesAutoresizingMaskIntoConstraints = false
        bottomStackView.distribution = .fillEqually
        bottomStackView.axis = .horizontal
        collectionView.addSubview(bottomStackView)
        
        NSLayoutConstraint.activate([
            bottomStackView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -60),
            bottomStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            bottomStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            bottomStackView.heightAnchor.constraint(equalToConstant: 25)
        ])
    }
    
    override func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        
        let x = targetContentOffset.pointee.x
        
        pageControl.currentPage = Int(x / view.frame.width)
    }

    // MARK: - Life cycle of viewController
    override func viewDidLoad()        {
        super.viewDidLoad()
        self.collectionView?.backgroundColor = .white
        setupBottomPanel()
        
        self.collectionView.isPagingEnabled = true
        self.collectionView.showsHorizontalScrollIndicator = false
        
        self.collectionView?.register(Page.self, forCellWithReuseIdentifier: "cell")
    }
}
