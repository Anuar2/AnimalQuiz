//
//  QuestionViewController.swift
//  AnimalQuiz
//
//  Created by Anuar Orazbekov on 28.05.2022.
//

import UIKit

class QuestionViewController: UIViewController {
    
    @IBOutlet var progressView: UIProgressView!
    @IBOutlet var questionLabel: UILabel!
    @IBOutlet var rangedSlider: UISlider!
    func didSet() {
            let answerCount = Float(currentAnswers.count - 1)
            rangedSlider.value = answerCount
                    }
    
    @IBOutlet var multipleStackView: UIStackView!
    @IBOutlet var singleStackView: UIStackView!
    @IBOutlet var rangedStackView: UIStackView!
    
    
    @IBOutlet var singleButtons1: UIButton!
    @IBOutlet var singleButtons2: UIButton!
    @IBOutlet var singleButtons3: UIButton!
    @IBOutlet var singleButtons4: UIButton!
    
    @IBOutlet var multipleLabel1: UILabel!
    @IBOutlet var multipleLabel2: UILabel!
    @IBOutlet var multipleLabel3: UILabel!
    @IBOutlet var multipleLabel4: UILabel!
    
    @IBOutlet var rangedLabel1: UILabel!
    @IBOutlet var rangedLabel2: UILabel!
    
    @IBOutlet var multipleSwitches1: UISwitch!
    @IBOutlet var multipleSwitches2: UISwitch!
    @IBOutlet var multipleSwitches3: UISwitch!
    @IBAction func multipleSwitches4(_ sender: Any) {
    }
    
    
    
    // MARK: Properties
    private let questions = Question.getQuestions()
    private var questionIndex = 0
    private var answerChosen: [Answer] = []
    private var currentAnswers: [Answer] { questions[questionIndex].answers
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }
    
    @IBAction func singleButtonAnswerPressed(_ sender: UIButton) {
        let singleButtons = [singleButtons1, singleButtons2, singleButtons3, singleButtons4]
        guard let currentIndex = singleButtons.firstIndex(of: sender) else{
            return }
        let currentAnswer = currentAnswers[currentIndex]
        answerChosen.append(currentAnswer)
        
        nextQuestion()
    }
    
    @IBAction func multipleAnswerPressed() {
        let multipleSwitches = [multipleSwitches1,multipleSwitches2,multipleSwitches3,multipleSwitches4] as [Any]
        for (multipleSwitch, answer) in zip(multipleSwitches, currentAnswers){
            if (multipleSwitch as AnyObject).isOn{
                answerChosen.append(answer)
            }
        }
        nextQuestion()
    }
    
    @IBAction func rangedAnswerButtonPressed() {
        let index = Int(rangedSlider.value)
        answerChosen.append(currentAnswers[index])
        
        nextQuestion()
    }
}

// MARK: - Private
extension QuestionViewController: UITextFieldDelegate {
    private func updateUI() {
//        Hide stacks
        for stackView in [singleStackView, multipleStackView, rangedStackView]{
            stackView?.isHidden = true
        }
        
//        get current question
        let currentQuestion = questions[questionIndex]
        
//        set current for label
        questionLabel.text = currentQuestion.text
        
//        calculate progress
        let totalProgress = Float(questionIndex) / Float(questions.count)
        
//        set progress for progressView
        progressView.setProgress(totalProgress, animated: true)
        
        title = "Вопрос № \(questionIndex + 1) из \(questions.count)"
        
//        show current StackView
        showCurrentStackView(for: currentQuestion.type)
    }
    
    private func showCurrentStackView(for type: ResponseType) {
        switch type {
        case .simple:
            showSingleStackView(with: currentAnswers)
        case .multiple:
            showMultipleStackView(with: currentAnswers)
        case .range:
            showRangedStackView(with: currentAnswers)
        }
    }
    
    private func showSingleStackView(with answers: [Answer]){
        singleStackView.isHidden = false
        
        let singleButtons = [singleButtons1, singleButtons2, singleButtons3, singleButtons4]
        
        for (button, answer)in zip(singleButtons, answers) {
            button?.setTitle(answer.text, for: .normal)
        }
    }
    
    private func showMultipleStackView(with answers: [Answer]) {
        multipleStackView.isHidden = false
        
        let multipleLabels = [multipleLabel1, multipleLabel2, multipleLabel3, multipleLabel4]
        
        for(label, answer) in zip(multipleLabels, answers){
            label?.text = answer.text
        }
    }
    private func showRangedStackView(with answers: [Answer]){
        rangedStackView.isHidden = false
        
        let rangedLabels = [rangedLabel1, rangedLabel2]
        
        rangedLabels.first?!.text = answers.first?.text
        rangedLabels.last?!.text = answers.last?.text
    }
    
    private func nextQuestion() {
        questionIndex += 1
        
        if questionIndex < questions.count{
            updateUI()
            return
        }
        
        performSegue(withIdentifier: "showResult", sender: nil)
    }
}
// dsadsada
// nenwewe
