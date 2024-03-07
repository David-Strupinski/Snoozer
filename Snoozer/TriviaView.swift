import SwiftUI

struct TriviaView: View {
    // State variables to track current question index and alert presentation
    @State private var currentQuestionIndex = 0
    @State private var showingAlert = false
    @State private var alertTitle = ""
    
    var body: some View {
        VStack(spacing: 20) {
            // Display the current trivia question
            Text(questionsInRandomOrder[currentQuestionIndex].text)
                .font(.title)
                .padding()
            
            // Display answer buttons for the current question
            ForEach(questionsInRandomOrder[currentQuestionIndex].answers) { answer in
                Button(action: {
                    answerTapped(answer)
                }) {
                    Text(answer.text)
                        .foregroundColor(.white)
                        .padding()
                        .background(answer.correct ? Color.green : Color.green)
                        .cornerRadius(10)
                }
            }
            
            Spacer()
        }
        // Display an alert for the user response
        .alert(isPresented: $showingAlert) {
            Alert(title: Text(alertTitle), message: nil, dismissButton: .default(Text("OK")) {
                nextQuestion()
            })
        }
        .onAppear {
            // Play the alarm sound and trigger haptic feedback as soon as the view appears
            SoundManager.instance.playSound(sound: .alarm)
            // Trigger haptic feedback
            HapticManager.instance.notification(type: .success)
            GyroscopeManager.shared.startMonitoring()
        }
        .onDisappear {
            GyroscopeManager.shared.stopMonitoring() // Stop monitoring when the view disappears
        }
    }
    
    // Function to handle user tap on an answer
    func answerTapped(_ answer: Answer) {
        if answer.correct {
            alertTitle = "Correct"
        } else {
            alertTitle = "Wrong"
        }
        showingAlert = true
    }
    
    // Function to move to the next question
    func nextQuestion() {
        if currentQuestionIndex + 1 < questionsInRandomOrder.count {
            currentQuestionIndex += 1
        } else {
            // No more questions, consider what should happen next
            // Maybe stop the alarm if trivia is complete?
        }
    }
}

// Struct to represent a trivia question
struct Question {
    let text: String
    let answers: [Answer]
}

// Struct to represent a trivia answer
struct Answer: Identifiable {
    let id = UUID()
    let text: String
    let correct: Bool
}

// List of trivia questions
let allQuestions = [
    Question(text: "Give Me A Word that Starts with the letter Z", answers: [
        Answer(text: "Arizona", correct: false),
        Answer(text: "Buzz", correct: false),
        Answer(text: "Zombie", correct: true),
    ]),
    Question(text: "Which direction does the Sun Rise?", answers: [
        Answer(text: "East", correct: true),
        Answer(text: "West", correct: false),
        Answer(text: "North", correct: false),
        Answer(text: "South", correct: false),

    ]),
]

// Shuffle the questions for random order
let questionsInRandomOrder = allQuestions.shuffled()

// Preview Provider
struct TriviaView_Previews: PreviewProvider {
    static var previews: some View {
        TriviaView()
    }
}
