//
//  TriviaView.swift
//  Snoozer
//
//  Created by Amy Cheng on 2/14/24.
//

import Foundation
import SwiftUI

struct TriviaView: View {
    var body: some View {
        VStack {
            /*
            // connect "Stop Alarm" button to TriviaView
            TriviaView()
                .tabItem {
                    Label("Trivia")
                }
                .tag(4)
             */
        }
    }
     
}
struct Question {
    let text: String
    let answers: [Answer]
}
struct Answer {
    let text: String
    let correct: Bool
}
// list of questions
let allQuestions = [
    Question(text: "Give Me A Word that Starts with the letter Z", answers: [
        Answer(text: "Zoo", correct: true),
        Answer(text: "zoo", correct: true),
        //Answer(text: "Zebra", correct: true),
    ]),
    Question(text: "Which direction does the Sun Rise?", answers: [
        Answer(text: "East", correct: true),
        Answer(text: "east", correct: true),
    ]),
]
let questionsInRandomOrder = allQuestions.shuffled()
