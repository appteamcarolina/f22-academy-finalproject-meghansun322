//
//  ChannelsFeedView.swift
//  Slack
//
//  Created by Meghan Sun on 11/1/22.
//

import SwiftUI

struct ChannelsFeedView: View {
    @State var search = ""
    
    @StateObject var vm = ChannelListViewModel()
    @State var feedIsTyping: Bool = false
    
    var body: some View {
        
        NavigationStack {
            
            ZStack{
                Color("misty-gray")
                    .ignoresSafeArea()
                
                VStack{
                    
                    FeedsHeaderView()
                
                    ScrollView {
                        VStack (alignment: .leading, spacing: 20){
                            
                            TopFeedView(search: $search, feedIsTyping: $feedIsTyping)
                               
                            
                            Divider()
                                .overlay(.white)
                            
                            FeedHeadingView(title: "Channels")

                            
                            ForEach($vm.channels, id: \.self) { $channel in
                                NavigationLink {
                                    ChannelView(channel: ChannelViewModel(channel: channel))
                                } label: {
                                    ChannelsFeedRowView(symbol: "number", name: channel.name)
                                    
                                }
                            }
                            
                            
                            Button {
                                print("clicked")
                            } label: {
                               ChannelsFeedRowView(symbol: "plus", name: "Add Channel")
                            }
                            
                            
                            Divider()
                                .overlay(.white)
                            
                            FeedHeadingView(title: "Direct Messages")
                           
                          
                            ForEach(Profile.profiles_example, id: \.self) { profile in
                                DirectMessageView(profile: profile)
                                
                            }
                            
                        }
                    }
                    
                    Divider()
                        .overlay(.white)
                    
                   
                }
                .foregroundColor(Color("light-gray"))
            }
            
        }
    }
}

struct ChannelsFeedView_Previews: PreviewProvider {
    static var previews: some View {
        ChannelsFeedView()
    }
}


struct FeedsHeaderView: View {
    var body: some View{
        HStack{
            Image("app-team-logo")
                .resizable()
                .frame(width: 35, height: 35)
                .cornerRadius(5)
                .padding(.trailing, 5)
            Text("App Team Carolina")
                .fontWeight(.bold)
                .font(.title2)
            Spacer()
            Image(systemName: "line.3.horizontal.decrease")
        }
        .padding([.trailing, .leading, .bottom])
        .foregroundColor(.white)
        .background(Color.black)
    }
}

struct TopFeedView: View {
    @Binding var search: String
    @Binding var feedIsTyping: Bool
    
    var body: some View {
        
        CustomTextField(
            placeholder: Text("Jump to...").foregroundColor(.white),
            text:  $search,
            onEditingChanged: {self.feedIsTyping = $0}
        )
            .padding(12)
        
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.white, lineWidth: 0.25)
            )
            .padding(.top, 5)
            .padding([.leading, .trailing], 10)
            .foregroundColor(Color.white)
        
        ChannelsFeedRowView(symbol: "ellipsis.message", name: "Threads")
        
        ChannelsFeedRowView(symbol: "paperplane", name: "Drafts & Sent")
    }
}

struct FeedHeadingView: View {
    var title: String
    
    var body: some View {
        HStack{
            Text(title)
                .fontWeight(.bold)
                .font(.subheadline)
                .foregroundColor(.white)
            
            Spacer()
            
            Image(systemName: "chevron.down")
        }
        .padding([.leading, .trailing], 10)
        
    }
}


struct ChannelsFeedRowView: View {
    
    var symbol: String
    var name: String
    
    var body: some View{
        HStack{
            Image(systemName: symbol)
                .padding(.trailing, 8)
            Text(name)
        }
        .padding(.bottom, 5)
        .padding([.leading, .trailing], 10)
       
    }
}


struct DirectMessageView: View {
    var profile: Profile
    
    var body: some View {
        HStack {
            Image(profile.image)
                .resizable()
                .frame(width: 30, height: 30)
                .cornerRadius(6)
                .padding(.trailing, 8)
              
            
            Text(profile.name)
                
        }
        .padding([.leading], 5)
        .padding([.leading, .trailing], 10)
        
    }
}


