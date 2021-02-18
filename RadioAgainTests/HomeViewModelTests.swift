//
//  HomeViewModelTests.swift
//  HomeViewModelTests
//
//  Created by Keval Patel on 11/13/20.
//

import XCTest
import RxCocoa
import RxSwift
import RxTest
//import RxBlocking

@testable import RadioAgain

class HomeViewModelTests: XCTestCase {
    var sut: HomeViewModel!
    var scheduler: TestScheduler!
    var buttonClikckEvents: PublishRelay<Void>!
    var disposeBag = DisposeBag()
    
    override func setUp() {
        super.setUp()
        scheduler = TestScheduler(initialClock: 0)
        buttonClikckEvents = PublishRelay<Void>()
        let homeViewModelInput = HomeViewModelInput(buttonClickEvent: buttonClikckEvents.asObservable(),
                                                    radioManager: RadioManager.shared)
        let transitionModel = PlaceHolderTransitionModel()
        SharingScheduler.mock(scheduler: scheduler) {
            sut = HomeViewModel(transitionModel: transitionModel, input: homeViewModelInput)
        }
    }
    
    func testNavigateToDetail(){
        let detailHomeTransitionModel = scheduler.createObserver(DetailHomeTransitionModel.self)
        sut.navigateToDetail.asObservable()
            .bind(to: detailHomeTransitionModel)
            .disposed(by: disposeBag)
        
        scheduler.createColdObservable([.next(1, ())])
            .bind(to: buttonClikckEvents)
            .disposed(by: disposeBag)

        scheduler.start()
        let outputModel = detailHomeTransitionModel.events.first?.value.element
        let messageString = scheduler.createObserver(String.self)
        
        outputModel?.transferedMessage
            .bind(to: messageString)
            .disposed(by: disposeBag)
        
        guard let msg = messageString.events.first?.value.element else {
            XCTFail()
            return
        }
        
        XCTAssertEqual(msg, HomeViewModel.Constants.messageString.rawValue)
    }
    
    func testClickTitle() {
        let title = scheduler.createObserver(String.self)
        sut.clickTitle.asObservable()
            .bind(to: title)
            .disposed(by: disposeBag)
        
        scheduler.createColdObservable([.next(1, ())])
            .bind(to: buttonClikckEvents)
            .disposed(by: disposeBag)

        scheduler.start()
        
        guard let output = title.events.first?.value.element else {
            XCTFail()
            return
        }
        
        XCTAssertEqual(output, HomeViewModel.Constants.tappedString.rawValue)
    }
    
    override func tearDown() {
        super.tearDown()
        sut = nil
        buttonClikckEvents = nil
        scheduler = nil
    }
}

