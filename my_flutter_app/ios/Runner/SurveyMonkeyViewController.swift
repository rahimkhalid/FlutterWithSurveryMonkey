//
//  SurveyMonkeyViewController.swift
//  Runner
//
//  Created by Rahim Khalid on 15/10/2019.
//  Copyright © 2019 The Chromium Authors. All rights reserved.
//

import UIKit

class SurveyMonkeyViewController: UIViewController {
    
    var surveyResult: FlutterResult!
    var surveyHash: String!
    private lazy var feedbackController: SMFeedbackViewController? = {
        let controller = SMFeedbackViewController(survey: surveyHash)
        controller?.delegate = self
        controller?.scheduleIntercept(from: self, withAppTitle: "SurveyMonkey Integration")
        return controller
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        feedbackController?.present(from: self, animated: true, completion: nil)
    }

}

extension SurveyMonkeyViewController: SMFeedbackDelegate {
    func respondentDidEndSurvey(_ respondent: SMRespondent!, error: Error!) {
        if let _ = respondent {
            surveyResult("Completed")
            self.navigationController?.popViewController(animated: true)
        } else if let error = error as? NSError,
            error.code == 1 {
            surveyResult("INCOMPLETED")
            self.navigationController?.popViewController(animated: true)
        }
    }
}
