import UIKit
import Flutter

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
    
    var navigationController: UINavigationController!
    
    override func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?
        ) -> Bool {
        
        
        let controller = self.window.rootViewController as! FlutterViewController
        
        linkNativeCode(controller: controller)
        
        GeneratedPluginRegistrant.register(with: self)
        
        self.navigationController = UINavigationController(rootViewController: controller)
        self.window.rootViewController = self.navigationController
        self.navigationController.setNavigationBarHidden(true, animated: false)
        self.window.makeKeyAndVisible()
        
        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }
}

extension AppDelegate {
    
    func linkNativeCode(controller: FlutterViewController) {
        setupMethodChannelForSurveyMonkey(controller: controller)
    }
    
    private func setupMethodChannelForSurveyMonkey(controller: FlutterViewController) {
        
        let surveyMonkeyChannel = FlutterMethodChannel.init(name: "com.Rahim.myFlutterApp/surveyMonkey", binaryMessenger: controller)
        
        surveyMonkeyChannel.setMethodCallHandler { (call, result) in
            
            if call.method == "surveyMonkey" {
                let vc = UIStoryboard.init(name: "Main", bundle: .main)
                        .instantiateViewController(withIdentifier: "SurveyMonkeyViewController") as! SurveyMonkeyViewController
                if let arguments = call.arguments as? String {
                    vc.surveyHash = arguments
                }
                vc.surveyResult = result
                self.navigationController.pushViewController(vc, animated: true)
            }
        }
    }
}
