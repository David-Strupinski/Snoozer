//
//  TriviaView.swift
//  Snoozer
//
//  Created by Amy Cheng on 2/14/24.
//

import Foundation
import SwiftUI

struct TriviaView: View {
    @State private var currentQuestionIndex = 0
    @State private var showingAlert = false
    @State private var alertTitle = ""
    
    var body: some View {
        VStack(spacing: 20) {
            Text(questionsInRandomOrder[currentQuestionIndex].text)
                .font(.title)
                .padding()
            
            ForEach(questionsInRandomOrder[currentQuestionIndex].answers, id: \.text) { answer in
                Button(action: {
                    answerTapped(answer)
                }) {
                    Text(answer.text)
                        .foregroundColor(.white)
                        .padding()
                        .background(answer.correct ? Color.green : Color.red)
                        .cornerRadius(10)
                }
            }
            
            Spacer()
        }
        .alert(isPresented: $showingAlert) {
            Alert(title: Text(alertTitle), message: nil, dismissButton: .default(Text("OK")) {
                nextQuestion()
            })
        }
    }
    
    func answerTapped(_ answer: Answer) {
        if answer.correct {
            alertTitle = "Correct"
        } else {
            alertTitle = "Wrong"
        }
        showingAlert = true
    }
    
    func nextQuestion() {
        if currentQuestionIndex + 1 < questionsInRandomOrder.count {
            currentQuestionIndex += 1
        } else {
            // No more questions, or you could loop back to the first one
            // Consider what should happen when trivia is complete. Maybe stop the alarm here?
        }
    }
}

struct Question {
    let text: String
    let answers: [Answer]
}

struct Answer: Identifiable {
    let id = UUID()
    let text: String
    let correct: Bool
}

// list of questions
let allQuestions = [
    Question(text: "Give Me A Word that Starts with the letter Z", answers: [
        Answer(text: "Zoo", correct: true),
        Answer(text: "Poop", correct: true),
    ]),
    Question(text: "Which direction does the Sun Rise?", answers: [
        Answer(text: "East", correct: true),
        Answer(text: "West", correct: true),
    ]),
]

let questionsInRandomOrder = allQuestions.shuffled()

// Preview Provider
struct TriviaView_Previews: PreviewProvider {
    static var previews: some View {
        TriviaView()
    }
}

