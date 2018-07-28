//  
//  NewsViewModelImpl.swift
//  RxCoordinator-Example
//
//  Created by Paul Kraft on 28.07.18.
//  Copyright © 2018 Joan Disho. All rights reserved.
//

import Foundation
import RxSwift
import Action
import RxCoordinator

class NewsViewModelImpl: NewsViewModel, NewsViewModelInput, NewsViewModelOutput {

    // MARK: - Inputs

    lazy var selectedNews = newsSelectedAction.inputs

    // MARK: - Actions

    lazy var newsSelectedAction = Action<News, Void> { [unowned self] news in
        return self.coordinator.rx.trigger(.newsDetail(news))
    }

    // MARK: - Outputs

    lazy var news = newsObservable.map { $0.articles }
    lazy var title = newsObservable.map { $0.title }

    let newsObservable: Observable<(title: String, articles: [News])>

    // MARK: - Private

    private let newsService: NewsService
    private let coordinator: AnyCoordinator<NewsRoute>

    // MARK: - Init

    init(newsService: NewsService, coordinator: AnyCoordinator<NewsRoute>) {
        self.newsService = newsService
        self.newsObservable = newsService.mostRecentNews().share(replay: 1)
        self.coordinator = coordinator
    }

}
