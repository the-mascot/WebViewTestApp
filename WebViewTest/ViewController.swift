//
//  ViewController.swift
//  WebviewTestApp
//
//  Created by NorthstarPC-Mac on 11/15/24.
//

import UIKit
import WebKit
import AVFoundation
import WKWebViewRTC

class ViewController: UIViewController, WKScriptMessageHandler {
    
    var webView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    
    @IBAction func openWebView(_ sender: Any) {
        let contentController = WKUserContentController()
        contentController.add(self, name: "iOSApp")

        let webView = WKWebView(frame: self.view.bounds)
        webView.configuration.allowsInlineMediaPlayback = true
        webView.configuration.userContentController = contentController
        webView.configuration.mediaTypesRequiringUserActionForPlayback = []
        webView.configuration.preferences.javaScriptEnabled = true
        
        
        
        if #available(iOS 16.4, *) {
            webView.isInspectable = true
        }
        
        let url = URL(string: "https://qariv.hanwhalife.com")
        let request = URLRequest(url: url!)
        // WkWebViewRTC 적용
        WKWebViewRTC(wkwebview: webView, contentController: webView.configuration.userContentController)
        webView.load(request)
    }
    
    // 권한 요청 함수
        func requestPermissions(completion: @escaping (Bool) -> Void) {
            // 카메라 권한 요청
            AVCaptureDevice.requestAccess(for: .video) { cameraGranted in
                if !cameraGranted {
                    print("카메라 권한 거부됨")
                    completion(false)
                    return
                }
                print("카메라 권한 허용됨")
                completion(true)
            }
        }
    
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        if message.name == "iOSApp", let code = message.body as? String {
            webView.removeFromSuperview()
            webView = nil // 참조 해제
            print("Received message: \(code)")
            
            if code == "0000" {
                print("성공")
            } else {
                print("실패")
            }
        }
    }
    
}


