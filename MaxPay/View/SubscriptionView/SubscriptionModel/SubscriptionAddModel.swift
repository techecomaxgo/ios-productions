import Foundation

final class SubscriptionAddModel {
    
    var subscription: SubscriptionResponseAdd?
    
    // MARK: Data Binding Closure
    var eventHandler: ((_ event: Event) -> Void)?
    
    // MARK: Fetching Data from Server
    func subscriptionmodelAdd(_ strDeviceid: String, total: String, txn_id: String, jsonString: String) {
        
        // Convert jsonString to Data
        guard let jsonData = jsonString.data(using: .utf8) else {
            print("Invalid JSON string")
            return
        }
        
        do {
            // Parse JSON string to a Swift Array of Dictionaries
            if let jsonObject = try JSONSerialization.jsonObject(with: jsonData, options: []) as? [[String: Any]] {
                
                let params: [String: Any] = [
                    "subscriptions": jsonObject,  // Ensure it's an array of dictionaries
                    "skey": strDeviceid,
                    "total": total,
                    "txn_id": txn_id
                ]
                
                // ✅ Convert params to JSON string for API request
                guard let finalJsonData = try? JSONSerialization.data(withJSONObject: params, options: []),
                      let finalJsonString = String(data: finalJsonData, encoding: .utf8) else {
                    print("Failed to convert JSON to String")
                    return
                }
                
                print("Formatted JSON for API Request: \n\(finalJsonString)")
                
                self.eventHandler?(.loading)
                
                // ✅ Send JSON string as raw body in API request
                ApiManager.sharedInstance.SubscriptionAddRequest(jsonString: finalJsonString) { [weak self] (model, err) in
                    
                    guard let self = self else { return }
                    
                    self.eventHandler?(.stopLoading)
                    
                    if let err = err {
                        print("Failed to fetch data:", err)
                        self.eventHandler?(.error(err))
                        return
                    }
                    
                    if let model = model {
                        print(model)
                        self.subscription = model
                        self.eventHandler?(.dataLoaded)
                    } else {
                        print("No data received")
                        self.eventHandler?(.error(nil))
                    }
                }
            } else {
                print("Error: JSON is not in expected format")
            }
        } catch {
            print("Error parsing JSON: \(error)")
        }
    }
}

// MARK: - Event Enum
extension SubscriptionAddModel {
    enum Event {
        case loading
        case stopLoading
        case dataLoaded
        case error(Error?)
    }
}
