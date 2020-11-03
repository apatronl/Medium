//
//  ContentView.swift
//  TwitterUI
//

import SwiftUI

extension Color {
  static var twitterBlue: Color = Color(red: 29/255, green: 161/255, blue: 241/255)
}

struct ContentView: View {
  
  private let tweets: [Tweet] = [
      Tweet(authorName: "Alejandrina Patrón",
            authorUsername: "ale_patron",
            timestampText: "4h",
            text: "good morning 🌞",
            numberOfReplies: 2,
            numberOfRetweets: 0,
            numberOfLikes: 0),
      Tweet(authorName: "Jack",
            authorUsername: "jack",
            timestampText: "15h",
            text: "just setting up my twttr",
            numberOfReplies: 589,
            numberOfRetweets: 368,
            numberOfLikes: 450),
      Tweet(authorName: "Donald J. Trump",
            authorUsername: "realDonaldTrump",
            timestampText: "6h",
            text: "Despite the negative press covfefe",
            numberOfReplies: 2890,
            numberOfRetweets: 4565,
            numberOfLikes: 896),
      Tweet(authorName: "Jack",
            authorUsername: "jack",
            timestampText: "15h",
            text: "this is a tweet with a lot of text because I need to test multi-line tweets in my new SwiftUI twitter app :)",
            numberOfReplies: 589,
            numberOfRetweets: 368,
            numberOfLikes: 450),
      Tweet(authorName: "Barack Obama",
            authorUsername: "BarackObama",
            timestampText: "12h",
            text: "No one is born hating another person because of the color of his skin or his background or his religion...",
            numberOfReplies: 5589,
            numberOfRetweets: 3568,
            numberOfLikes: 4350),
      Tweet(authorName: "Jack",
            authorUsername: "jack",
            timestampText: "15h",
            text: "this is a tweet with a lot of text because I need to test multi-line tweets in my new SwiftUI twitter app :)",
            numberOfReplies: 589,
            numberOfRetweets: 368,
            numberOfLikes: 450),
      Tweet(authorName: "Jack",
            authorUsername: "jack",
            timestampText: "15h",
            text: "this is a tweet with a lot of text because I need to test multi-line tweets in my new SwiftUI twitter app :)",
            numberOfReplies: 589,
            numberOfRetweets: 368,
            numberOfLikes: 450),
    ]

  
  @State private var selectedTab = 0

  var body: some View {
    ZStack {
      TabView(selection: $selectedTab) {
        FeedView(tweets: tweets).tabItem {
          Image(systemName: "house")
        }.tag(0)
        Text("Tab Content 1").tabItem {
          Image(systemName: "magnifyingglass")
        }.tag(1)
        Text("Tab Content 2").tabItem {
          Image(systemName: "bell")
        }.tag(2)
        Text("Tab Content 3").tabItem {
          Image(systemName: "envelope")
        }.tag(3)
      }.accentColor(.twitterBlue)
      
      VStack {
        Spacer()
        HStack {
          Spacer()
          NewTweetButton()
            .padding(.bottom, 65)
            .padding(.trailing)
        }
      }
    }
  }
}

struct NewTweetButton: View {
  var body: some View {
    Button(action: {}) {
      Image(systemName: "pencil")
        .font(.largeTitle)
        .foregroundColor(.white)
        .padding()
    }
    .background(Color.twitterBlue)
    .mask(Circle())
    .shadow(radius: 5)
  }
}

struct FeedView: View {
  let tweets: [Tweet]
  
  var body: some View {
    NavigationView {
      List(tweets) { tweet in
        TweetView(tweet: tweet)
      }
      .listStyle(PlainListStyle())
      .navigationBarTitle("Twitter", displayMode: .inline)
      .navigationBarItems(
        leading:
          Button(action: {}) {
            Image(systemName: "person.crop.circle.fill")
              .foregroundColor(.twitterBlue)
          },
        trailing:
          Button(action: {}) {
            Image(systemName: "moon.stars")
              .foregroundColor(.twitterBlue)
          }
        )
    }
  }
}

struct TweetView: View {
  let tweet: Tweet
  
  var body: some View {
    HStack(alignment: .top) {
      Image(systemName: "person.crop.circle.fill")
        .font(.system(size: 55))
        .padding(.top)
        .padding(.trailing, 5)
        .foregroundColor(.twitterBlue)
      
      VStack(alignment: .leading) {
        HStack {
          Text(tweet.authorName)
            .bold()
            .lineLimit(1)
          Text("@\(tweet.authorUsername) • \(tweet.timestampText)")
            .lineLimit(1)
            .truncationMode(.middle)
            .foregroundColor(.gray)
        }
        .padding(.top, 5)
        
        Text(tweet.text)
          .lineLimit(nil)
          .multilineTextAlignment(.leading)
        
        TweetActionsView(tweet: tweet)
          .foregroundColor(.gray)
          .padding([.bottom, .top], 10)
          .padding(.trailing, 30)
      }
    }
  }
}

struct TweetActionsView: View {
  let tweet: Tweet
  
  var body: some View {
    HStack {
      Button(action: {}) {
        Image(systemName: "message")
      }
      Text(tweet.numberOfReplies > 0 ? "\(tweet.numberOfReplies)" : "")
      Spacer()
      
      Button(action: {}) {
        Image(systemName: "arrow.2.squarepath")
      }
      Text(tweet.numberOfRetweets > 0 ? "\(tweet.numberOfRetweets)" : "")
      Spacer()
      
      Button(action: {}) {
        Image(systemName: "heart")
      }
      Text(tweet.numberOfLikes > 0 ? "\(tweet.numberOfLikes)" : "")
      Spacer()
      
      Button(action: {}) {
        Image(systemName: "square.and.arrow.up")
      }
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
