//
//  WebView.swift
//  WKWebView
//
//  Created by Nitin Bhatt on 7/20/21.
//

import Foundation
import WebKit
import SwiftUI

struct WebView: UIViewRepresentable{
    
    enum ProgessState: String{
        case initial
        case completed
        case inProgress
        case error
    }
    
    
    @Binding var urlString:String
    @Binding var loading:Bool
    @Binding var state:ProgessState
    
    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        webView.navigationDelegate = context.coordinator
        return webView
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        
        switch self.state{
          case .initial:
            if let url = URL(string: self.urlString){
                uiView.load(URLRequest(url: url))
            }
        default:
            break
        }
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, WKNavigationDelegate{
        var parent: WebView
        
        func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
            self.parent.state = .inProgress
            self.parent.loading = true
        }
        
        func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
            self.parent.state = .error
            self.parent.loading = false
        }
        
        func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
            self.parent.state = .completed
            self.parent.loading = false
        }
        
        init(_ parent: WebView) {
            self.parent = parent
        }
    }
}
