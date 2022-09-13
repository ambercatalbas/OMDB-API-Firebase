//
//  DetailViewController.swift
//  OMDB-API-Firebase
//
//  Created by Amber Çatalbaş on 10.09.2022.
//

import UIKit
import MobilliumBuilders
import FirebaseAnalytics

final class DetailViewController: BaseViewController<DetailViewModel> {
    
    private let scrollView = UIScrollViewBuilder()
        .alwaysBounceVertical(true)
        .build()
    private let contentView = UIViewBuilder()
        .build()
    private let ivPoster = UIImageViewBuilder()
        .build()
    private let stackViewLbl = UIStackViewBuilder()
        .distribution(.fillProportionally)
        .spacing(10)
        .axis(.vertical)
        .build()
    private let lblTitle = UILabelBuilder()
        .font(.font(.josefinSansSemibold, size: .custom(size: 22)))
        .textColor(.appCinder)
        .numberOfLines(0)
        .build()
    private let lblYear = UILabelBuilder()
        .font(.font(.josefinSansRegular, size: .custom(size: 16)))
        .textColor(.appCinder)
        .numberOfLines(0)
        .build()
    private let lblType = UILabelBuilder()
        .font(.font(.josefinSansRegular, size: .custom(size: 16)))
        .textColor(.appCinder)
        .numberOfLines(0)
        .build()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubViews()
        configureContents()
        
    }
    
}

// MARK: - UILayout
extension DetailViewController {
    
    private func addSubViews() {
        makeScrollView()
        makeContentView()
        makeIvPoster()
        makeStackViewLbl()
    }
    
    private func makeScrollView() {
        view.addSubview(scrollView)
        scrollView.edgesToSuperview()
    }
    
    private func makeContentView() {
        scrollView.addSubview(contentView)
        contentView.widthToSuperview()
        contentView.edgesToSuperview()
    }
    
    private func makeIvPoster() {
        contentView.addSubview(ivPoster)
        ivPoster.centerXToSuperview()
        ivPoster.topToSuperview().constant = 20
        ivPoster.leftToSuperview(offset: 20, relation: .equalOrGreater)
        ivPoster.rightToSuperview(offset: -20, relation: .equalOrLess)
    }
    
    private func makeStackViewLbl() {
        contentView.addSubview(stackViewLbl)
        stackViewLbl.topToBottom(of: ivPoster).constant = 20
        stackViewLbl.leadingToSuperview().constant = 20
        stackViewLbl.trailingToSuperview().constant = -20
        stackViewLbl.addArrangedSubview(lblTitle)
        stackViewLbl.addArrangedSubview(lblYear)
        stackViewLbl.addArrangedSubview(lblType)

    }
    
}

// MARK: - Configure
extension DetailViewController {
    
    private func configureContents() {
        view.backgroundColor = .appBackgrounlightGreen
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: .backArrow, style: .plain, target: self, action: #selector(backButtonTapped))
        let movie = self.viewModel.movie
        title = movie.title
        ivPoster.setImage(movie.poster)
        lblTitle.attributedText = String(format: "%@ %@",
                                         L10n.DetailViewController.movieName,
                                         movie.title ?? "").attributedTextBold(boldString: L10n.DetailViewController.movieName,
                                                                               font: .font(.josefinSansRegular, size: .custom(size: 20)),
                                                                               boldFont: .font(.josefinSansBold, size: .custom(size: 22)))
        lblYear.attributedText = String(format: "%@ %@", L10n.DetailViewController.movieYear, movie.year
                              ?? "").attributedTextBold(boldString: L10n.DetailViewController.movieYear,
                                                        font: .font(.josefinSansRegular, size: .custom(size: 20)),
                                                        boldFont: .font(.josefinSansBold, size: .custom(size: 22)))
        lblType.attributedText = String(format: "%@ %@",
                                        L10n.DetailViewController.movieType,
                                        movie.type ?? "").attributedTextBold(boldString: L10n.DetailViewController.movieType,
                                                                             font: .font(.josefinSansRegular, size: .custom(size: 20)),
                                                                             boldFont: .font(.josefinSansBold, size: .custom(size: 22)))
        
        self.eventMovie(movie: movie)
    }
   
}

// MARK: - Actions
extension DetailViewController {
    
    @objc
    func backButtonTapped() {
        viewModel.showHomeScreen()
    }
    
    func eventMovie(movie: Movie) {
        
        Analytics.logEvent("movie", parameters: [
            "name": (movie.title ?? "") as String,
            "year": (movie.year ?? "") as String,
            "type": (movie.type ?? "") as String,
        ])
    }
}
