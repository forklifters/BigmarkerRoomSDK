

import UIKit

enum MethodType {
    case GET
    case POST
    case PUT
}

class NetworkTools {
    class func requestData(type : MethodType, URLString : String,
                           finishedCallback : @escaping (_ result : AnyObject) -> ()) {
        switch type {
        case MethodType.PUT:
                        break
        case MethodType.POST:
            
            break
        default:
            let str = "Hello, playground"
            print(str)
            let url = URL(string: URLString)
            let session = URLSession.shared
            let task = session.dataTask(with: url!) { (data, response, error) in
                guard error == nil else {
                    finishedCallback(error as AnyObject)
                    return
                }
                guard let data = data else {
                    print("Data is empty")
                    finishedCallback(error as AnyObject)
                    return
                }
                let result = try! JSONSerialization.jsonObject(with: data, options: [])
                finishedCallback(result as AnyObject)
            
            }
            task.resume()
            break
        }
        
        
    }
    
    
    
}
