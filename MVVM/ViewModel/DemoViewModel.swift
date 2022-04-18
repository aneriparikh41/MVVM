//
//  DemoViewModel.swift
//  MVVM
//
//  Created by Aneri Parikh on 14/04/22.
//

import Foundation

protocol DemoViewModelProtocol {
    func fetchData()

    func updateData()

    var demoDataFetched : (() -> ()) { get set }

    var demo: Demo? { get }
}

class DemoViewModel: DemoViewModelProtocol {

    private let service: ServiceLayer?

    var demoDataFetched : (() -> ()) = {}
    internal var demo: Demo? {
        didSet {
            demoDataFetched()
        }
    }

    let urlString = "http://dummy.restapiexample.com/api/v1/employees"

    init(service: ServiceLayer?) {
        self.service = service
    }

    func fetchData() {
        service?.fetchDemoData(url: urlString) {[weak self] data, error in
            guard let self = self else { return }
            if error == nil {
                self.demo = data
            }
        }
    }

    func updateData() {
        // call another API
    }
}
