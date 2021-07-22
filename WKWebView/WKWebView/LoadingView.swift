//
//  LoadingView.swift
//  WKWebView
//
//  Created by Nitin Bhatt on 7/20/21.
//

import SwiftUI

struct ActivityIndicator: UIViewRepresentable{
    typealias UIView = UIActivityIndicatorView
    var isAnimating: Bool
    let style: UIActivityIndicatorView.Style
    fileprivate var configuration =  {(indicator: UIView) in}
    
    func makeUIView(context: UIViewRepresentableContext<ActivityIndicator>) -> UIActivityIndicatorView {
        return UIActivityIndicatorView(style: style)
    }
    
    func updateUIView(_ uiView: UIView, context: UIViewRepresentableContext<Self>) {
        isAnimating ? uiView.startAnimating() : uiView.stopAnimating()
        configuration(uiView)
    }
}

extension View where Self == ActivityIndicator{
    func configure(_ configuration: @escaping (Self.UIView) -> Void) -> Self{
        Self.init(isAnimating: self.isAnimating, style: self.style, configuration: configuration)
    }
}

struct LoadingView: View {
    @Binding var isShowing:Bool
    
    var body: some View {
        VStack{
            ActivityIndicator(isAnimating: isShowing, style: .large){
                $0.color = UIColor.white
                $0.hidesWhenStopped = false
            }
            Text("Loading").font(.title3).foregroundColor(.white)
        }.frame(width: 120, height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/).background(Color(.blue)).cornerRadius(20).opacity(self.isShowing ? 1 : 0)
    }
}
