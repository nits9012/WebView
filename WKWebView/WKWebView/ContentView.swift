//
//  ContentView.swift
//  WKWebView
//
//  Created by Nitin Bhatt on 7/20/21.
//

import SwiftUI

struct ContentView: View {
    
    @State var loading = false
    @State var url =  String()
    @State var state = WebView.ProgessState.initial
    
    var body: some View {
        
        ZStack{
          VStack{
            WebView(urlString: $url, loading: $loading, state: $state)
          }.onAppear(){
            url = "https://www.google.com"
          }
            
            LoadingView(isShowing: $loading)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
