//
//  PopularArticlesViewModelTest.swift
//  NyTimesAppTests
//
//  Created by Alok Tyagi on 28/01/2024.
//  Copyright © 2024 Alok. All rights reserved.
//

import XCTest
@testable import NyTimesApp

class PopularArticlesViewModelTest: XCTestCase {

    var mockViewModelObj:PopularArticlesListViewModel?
    var mockApiServiceObj:MockApiService?
    var DEFAULT_URL = "https://static01.nyt.com/images/2020/11/12/upshot/12up-vote-count/12up-vote-count-thumbStandard.jpg"

    override func setUpWithError() throws {
        super.setUp()
        mockApiServiceObj = MockApiService()
        mockViewModelObj = PopularArticlesListViewModel(apiService: mockApiServiceObj!)
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        mockApiServiceObj = nil
        mockViewModelObj = nil
        super.tearDown()
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testFetchArticlesCellsSuccessfully() async {
        
        await mockViewModelObj?.getPopularArticles()
        
        // Given a fetch with a success
        let obj : Result<PopularArticlesModel, ErrorResult> = (mockApiServiceObj?.fetchSuccess())!
        
        switch obj {
        case .success(let data):
            XCTAssertEqual("OK", data.status)
        default:
             XCTFail()
        }

    }
    
    func testFetchArticlesCellsFail() async {
        
        // Given a failed fetch with a certain failure
        let error = ErrorResult.custom(string: "Failed")
        
        await mockViewModelObj?.getPopularArticles()

        let obj : Result<PopularArticlesModel, ErrorResult> = (mockApiServiceObj?.fetchFail(error: error))!
        
        switch obj {
        case .failure(_):
            XCTAssert(true)
        default:
            XCTFail()
        }
        
    }
    
    func testFetchArticlesCellsWithoutImage() async {

        await mockViewModelObj?.getPopularArticles()

        // Given a fetch with no images
        let obj : Result<PopularArticlesModel, ErrorResult> = (mockApiServiceObj?.fetchArtcilesWithoutImages())!

        switch obj {
        case .success(let data):
            mockViewModelObj?.cellViewModels = data
            XCTAssert(mockViewModelObj?.cellViewModels?.articles[0].media.count ?? 0 == 0)
        default:
             XCTFail()
        }

    }
    
    func testFetchArticlesCellsWithImage() async {

        await mockViewModelObj?.getPopularArticles()

        // Given a fetch with images
        let obj : Result<PopularArticlesModel, ErrorResult> =  (mockApiServiceObj?.fetchArtcilesWithImages())!

        switch obj {
        case .success(let data):
            mockViewModelObj?.cellViewModels = data
            XCTAssert(mockViewModelObj?.cellViewModels?.articles[0].media.count ?? 0 > 0)
        default:
             XCTFail()
        }

    }
    
    func testFetchDataWithNoArticles() async {

        await mockViewModelObj?.getPopularArticles()

        // Given a fetch with no articles
        let obj : Result<PopularArticlesModel, ErrorResult> = (mockApiServiceObj?.fetchSuccessfullyWithNoArticles())!

        switch obj {
        case .success(let data):
            mockViewModelObj?.cellViewModels = data
            XCTAssert(mockViewModelObj?.cellViewModels?.articles.count ?? 0 == 0)
        default:
             XCTFail()
        }

    }
}

class MockApiService: APIServiceProtocol {
       
    func getPopularArtciles<T>() async throws -> NyTimesApp.Result<T, NyTimesApp.ErrorResult> where T : Decodable, T : Encodable {
        return Result.success(PopularArticlesModel.with() as! T)
    }
  
    func fetchSuccess() -> NyTimesApp.Result<PopularArticlesModel, NyTimesApp.ErrorResult>  {
        return Result.success(PopularArticlesModel.with())
    }

    func fetchFail(error: ErrorResult) -> NyTimesApp.Result<PopularArticlesModel, NyTimesApp.ErrorResult> {
        return Result.failure(error)
    }
    
    func fetchSuccessfullyWithNoArticles() -> NyTimesApp.Result<PopularArticlesModel, NyTimesApp.ErrorResult>  {
       
        return Result.success(PopularArticlesModel(status: "Ok", resultsNumber: 10,
                                                   articles: []))

    }
    
    func fetchArtcilesWithImages() -> NyTimesApp.Result<PopularArticlesModel, NyTimesApp.ErrorResult> {
       
        return Result.success(PopularArticlesModel(status: "Ok", resultsNumber: 10,
                                                   articles: [Articles(publishedDate: "29-01-2024", title: "title", abstract: "abstract", byline: "byLine", id: 11234567,
                                                                       media:[Media(mediaMetadata: [Metadata(imageUrl:DEFAULT_URL)])])]))

    }
    func fetchArtcilesWithoutImages() -> NyTimesApp.Result<PopularArticlesModel, NyTimesApp.ErrorResult> {
        
        return Result.success(PopularArticlesModel(status: "Ok", resultsNumber: 10,
                                                   articles: [Articles(publishedDate: "29-01-2024", title: "title", abstract: "abstract", byline: "byLine", id: 11234567,
                                                                       media:[])]))

    }

    
}
