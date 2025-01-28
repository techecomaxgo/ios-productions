import Alamofire
import Foundation

class SecureNetworkManager {

    // The server's public certificate file name (in .cer format)
    private let serverCertificateFileName = "server_certificate"  // This should be the name of your certificate in the project
    
    // Get the certificate data from the project
    private func getCertificateData() -> Data? {
        guard let certificatePath = Bundle.main.path(forResource: serverCertificateFileName, ofType: "cer") else {
            print("Certificate not found in the bundle.")
            return nil
        }
        
        do {
            let certificateData = try Data(contentsOf: URL(fileURLWithPath: certificatePath))
            return certificateData
        } catch {
            print("Failed to load certificate: \(error)")
            return nil
        }
    }

    // Create ServerTrustPolicy to pin the certificate
    /*private func createServerTrustPolicy() -> ServerTrustPolicy {
        // Use the certificate data to perform pinning
        guard let certificateData = getCertificateData() else {
            fatalError("Failed to load certificate data.")
        }
        
        // Create SecCertificate from certificate data
        if let cert = SecCertificateCreateWithData(nil, certificateData as CFData) {
            // Alamofire expects an array of certificates for pinning
            return .pinCertificates(certificates: [cert], validateCertificateChain: true, validateHost: true)
        } else {
            fatalError("Failed to create SecCertificate from data.")
        }
    }

    // Alamofire session manager with custom server trust policy
    private func createSessionManager() -> SessionManager {
        // Create the custom ServerTrustPolicy
        let serverTrustPolicy = createServerTrustPolicy()
        
        // Create a custom ServerTrustManager with the policy for the server
        let serverTrustManager = ServerTrustPolicyManager(
            policies: [
                "api.maxupi.in": serverTrustPolicy
            ]
        )
        
        // Return a session manager with the custom serverTrustManager
        let sessionManager = SessionManager(configuration: .default, serverTrustPolicyManager: serverTrustManager)
        return sessionManager
    }

    // Method to make a network request
    func makeRequest() {
        let sessionManager = createSessionManager()
        
        // Alamofire request with SSL pinning
        sessionManager.request("https://your.server.com/api/endpoint")
            .validate()
            .responseJSON { response in
                switch response.result {
                case .success(let value):
                    print("Request successful: \(value)")
                case .failure(let error):
                    print("Request failed: \(error.localizedDescription)")
                    // Handle the error appropriately, such as network failure or SSL validation failure
                }
            }
    }
     */
}
