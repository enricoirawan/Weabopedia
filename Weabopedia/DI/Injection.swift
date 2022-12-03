//
//  DI.swift
//  Weabopedia
//
//  Created by Enrico Irawan on 30/11/22.
//
import Swinject

class Injection {
    let container: Container = {
        let container = Container()
        
        // MARK: - Data Source
        container.register(AnimeRemoteDataSource.self) { _ in
            AnimeRemoteDataSourceImpl()
        }
        container.register(GenreRemoteDataSource.self) { _ in
            GenreRemoteDataSourceImpl()
        }
        
        // MARK: - Repository
        container.register(AnimeRepository.self) { resolver in
            AnimeRepositoryImpl(
                animeRemoteDataSource: resolver.resolve(
                    AnimeRemoteDataSource.self
                )!
            )
        }
        container.register(GenreRepository.self) { resolver in
            GenreRepositoryImpl(
                genreRemoteDataSource: resolver.resolve(
                    GenreRemoteDataSource.self
                )!
            )
        }
        
        // MARK: - Use Case
        container.register(GetListAnimeUseCase.self) { resolver in
            GetListAnimeUseCase(
                animeRepository: resolver.resolve(
                    AnimeRepository.self
                )!
            )
        }
        container.register(GetListGenreUseCase.self) { resolver in
            GetListGenreUseCase(
                genreRepository: resolver.resolve(
                    GenreRepository.self
                )!
            )
        }
        container.register(GetAnimeDetailUseCase.self) { resolver in
            GetAnimeDetailUseCase(
                animeRepository: resolver.resolve(
                    AnimeRepository.self
                )!
            )
        }
        container.register(SearchAnimeUseCase.self) { resolver in
            SearchAnimeUseCase(
                animeRepository: resolver.resolve(
                    AnimeRepository.self
                )!
            )
        }
        
        // MARK: - Presenter
        container.register(HomeViewController.self) { resolver in
            let controller = HomeViewController()
            controller.getListAnimeUseCase = resolver.resolve(GetListAnimeUseCase.self)
            controller.getListGenreUseCase = resolver.resolve(GetListGenreUseCase.self)
            return controller
        }
        container.register(DetailViewController.self) { resolver in
            let controller = DetailViewController()
            controller.getAnimeDetailUseCase = resolver.resolve(GetAnimeDetailUseCase.self)
            return controller
        }
        container.register(SearchViewController.self) { resolver in
            let controller = SearchViewController()
            controller.searchAnimeUseCase = resolver.resolve(SearchAnimeUseCase.self)
            return controller
        }
        return container
    }()
}
