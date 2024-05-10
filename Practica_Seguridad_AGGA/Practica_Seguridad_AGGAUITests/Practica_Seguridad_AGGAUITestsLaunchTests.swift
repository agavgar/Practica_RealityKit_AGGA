//
//  Practica_Seguridad_AGGAUITestsLaunchTests.swift
//  Practica_Seguridad_AGGAUITests
//
//  Created by Alejandro Alberto Gavira García on 10/5/24.
//

import XCTest

final class Practica_Seguridad_AGGAUITestsLaunchTests: XCTestCase {

    override class var runsForEachTargetApplicationUIConfiguration: Bool {
        true
    }

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    func testLaunch() throws {
        let app = XCUIApplication()
        app.launch()

        // Insert steps here to perform after app launch but before taking a screenshot,
        // such as logging into a test account or navigating somewhere in the app

        let attachment = XCTAttachment(screenshot: app.screenshot())
        attachment.name = "Launch Screen"
        attachment.lifetime = .keepAlways
        add(attachment)
    }
}
