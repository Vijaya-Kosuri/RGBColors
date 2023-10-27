import Foundation

class CustomDataDelegate: NSObject, URLSessionDataDelegate {
  var receivedData: Data = Data()
  var expectedContentLength: Int64 = 0
  var downloadProgressHandler: ((Float) -> Void)?
  
  func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive data: Data) {
    receivedData.append(data)
    
    print("expectedContentLength 1: \(expectedContentLength)")
    if expectedContentLength == NSURLSessionTransferSizeUnknown {
      let progress = Float(receivedData.count) / 1024 // Assuming progress in KB
      downloadProgressHandler?(progress)
      print("progress 1: \(progress)")
    } else {
      let progress = Float(receivedData.count) / Float(expectedContentLength)
      downloadProgressHandler?(progress)
      print("progress 2: \(progress)")
    }
  }
  
  func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive response: URLResponse, completionHandler: @escaping (URLSession.ResponseDisposition) -> Void) {
    if let httpResponse = response as? HTTPURLResponse {
      if let contentLength = httpResponse.value(forHTTPHeaderField: "Content-Length") {
        if let length = Int64(contentLength) {
          expectedContentLength = length
        }
      }
    }
    completionHandler(.allow)
  }
  
}
