
import UIKit
import UserNotifications



class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
       
        
        
    
  
        
    }
    
    
    @IBAction func btn_Notifiy(_ sender: UIButton) {
        
        let title:String = "ChatApp",
        subtitle:String = "1 message",
        body:String = "one person send you a message",
        badage:Int = 1
        
        
        LocalNotification(title: title, subTitle: subtitle, body: body, badage: badage, delayInterval: nil)
        
        
    }
    
    func LocalNotification(title:String ,
                           subTitle:String ,
                           body:String ,
                           badage:Int? ,
                           delayInterval:Int?){
        
        
        let content = UNMutableNotificationContent()
        content.title = title
        content.subtitle = subTitle
        content.body = body
        
        
        var timeInterval:UNTimeIntervalNotificationTrigger?
        
        if let delayInterval = delayInterval{
            
            timeInterval = UNTimeIntervalNotificationTrigger(timeInterval: TimeInterval(delayInterval), repeats: false)
            
        }
        
        if let badage = badage{
            
            var currentBadge = UIApplication.shared.applicationIconBadgeNumber
            
            currentBadge += badage
            
            content.badge = NSNumber(integerLiteral: currentBadge)
            
        }
        
        content.sound = UNNotificationSound.default
        
        
        UNUserNotificationCenter.current().delegate = self
        
        let id:String = UUID().uuidString
        
        let request = UNNotificationRequest(identifier: id, content: content, trigger: timeInterval)
        
        UNUserNotificationCenter.current().add(request, withCompletionHandler: { error in
            
            if let error = error{
                
                print(error.localizedDescription)
            }
            
        })
        
        
    }

}

extension ViewController:UNUserNotificationCenterDelegate{
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        print("Notification presented")
        
        completionHandler([.badge , .alert , .sound])
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        
        let identifier = response.actionIdentifier
        
        switch identifier {
        case UNNotificationDismissActionIdentifier:
            print("the notification is dissmissed")
            completionHandler()
            
        case UNNotificationDefaultActionIdentifier:
            completionHandler()
        default:
            completionHandler()
        }
        
    }
}






