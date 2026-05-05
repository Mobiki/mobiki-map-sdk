import UIKit
import MobikiSDK

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        // Real Perpa API key — kept here so the public demo runs out of the box.
        // Customers replace this with the key Mobiki provisions for their venue.
        Mobiki.configure(apiKey: "b6c76bd6f9a6c90c8bf634e7b60d574a0a1860fe5c03f1934a08ef70fed2bd14")

        let window = UIWindow(frame: UIScreen.main.bounds)
        window.rootViewController = UINavigationController(rootViewController: ViewController())
        window.makeKeyAndVisible()
        self.window = window

        return true
    }
}
