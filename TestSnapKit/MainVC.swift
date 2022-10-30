//
//  MainVC.swift
//  TestSnapKit
//
//  Created by ericzero on 10/14/22.
//

import UIKit
import SnapKit
class MainVC: UIViewController {
    
    let questionImg = UIImageView()
    let resultLabel = UILabel()
    let questionLabel = UILabel()
    let btn1 = UIButton()
    let btn2 = UIButton()
    let btn3 = UIButton()
    
    let ansColor = UIColor(red: 123/255, green: 155/255, blue: 15/255, alpha: 1)
    
    var questionsArr = [Question]()
    var index = 0
    var result = 0
    lazy var c = questionsArr.count
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        createSubViews()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if questionsArr.count == 0 {
            let model = MyModel()
            questionsArr = model.queArr
            initData(questionsArr[index])
        } else {
            initData(questionsArr[index])
        }
        
    }
    
    func initData(_ ques: Question?) {
        questionImg.image = UIImage(named: ques?.imageName ?? "")
        resultLabel.text = "\(result) / \(index+1)"
        
        questionLabel.text = "\(index+1). Let's guess the type of picture above."
        createVariants()
    }
    
    func createVariants(){
        var threeAns = [questionsArr[index].ansver ?? ""]
        var allAnsArr = [String]()
        for item in questionsArr {
            if item.ansver != questionsArr[index].ansver {
                allAnsArr.append(item.ansver ?? "")
            }
        }
        let ans2 = Int.random(in: 0...allAnsArr.count-1)
        threeAns.append(allAnsArr[ans2])
        allAnsArr.remove(at: ans2)
        
        let ans3 = Int.random(in: 0...allAnsArr.count-1)
        threeAns.append(allAnsArr[ans3])
        threeAns = threeAns.shuffled()
        btn1.setTitle(threeAns[0], for: .normal)
        btn2.setTitle(threeAns[1], for: .normal)
        btn3.setTitle(threeAns[2], for: .normal)
    }
    
    func initSubViews(){
        view.backgroundColor = .white
        title = "Fun Quiz"
        
        questionImg.clipsToBounds = true
        questionImg.contentMode = .scaleAspectFill
        
        resultLabel.textColor = .white
        resultLabel.backgroundColor = .red
        resultLabel.numberOfLines = 2
        resultLabel.textAlignment = .center
        resultLabel.font = .systemFont(ofSize: 22, weight: .bold)
        resultLabel.clipsToBounds = true
        resultLabel.layer.cornerRadius = 5
        
        questionLabel.textColor = .black
        
        btn1.backgroundColor = ansColor
        btn1.layer.cornerRadius = 25
        btn1.addTarget(self, action: #selector(btn1Tapped), for: .touchUpInside)
                        
        btn2.backgroundColor = ansColor
        btn2.layer.cornerRadius = 25
        btn2.addTarget(self, action: #selector(btn1Tapped), for: .touchUpInside)
        
        btn3.backgroundColor = ansColor
        btn3.layer.cornerRadius = 25
        btn3.addTarget(self, action: #selector(btn1Tapped), for: .touchUpInside)
    }
    func addedSubViews(){
        view.addSubview(questionImg)
        questionImg.addSubview(resultLabel)
        view.addSubview(questionLabel)
        view.addSubview(btn1)
        view.addSubview(btn2)
        view.addSubview(btn3)
    }
    func setConstrains() {
        questionImg.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.right.left.equalToSuperview()
            make.height.equalTo(questionImg.snp.width).multipliedBy(0.55)
        }
        resultLabel.snp.makeConstraints { make in
            make.top.equalTo(30)
            make.right.equalTo(-30)
        }
        questionLabel.snp.makeConstraints { make in
            make.top.equalTo(questionImg.snp.bottom).offset(30)
            make.left.equalTo(30)
            make.right.equalTo(-30)
        }
        btn1.snp.makeConstraints { make in
            make.top.equalTo(questionLabel.snp.bottom).offset(70)
            make.left.equalTo(30)
            make.right.equalTo(-30)
            make.height.equalTo(50)
        }
        btn2.snp.makeConstraints { make in
            make.top.equalTo(btn1.snp.bottom).offset(50)
            make.left.equalTo(30)
            make.right.equalTo(-30)
            make.height.equalTo(50)
        }
        btn3.snp.makeConstraints { make in
            make.top.equalTo(btn2.snp.bottom).offset(50)
            make.left.equalTo(30)
            make.right.equalTo(-30)
            make.height.equalTo(50)
        }
    }
    func createSubViews(){
           initSubViews()
           addedSubViews()
           setConstrains()
    }
}

extension MainVC {
    
    @objc private func btn1Tapped(_ sender: UIButton) {
           
        if sender.titleLabel?.text == questionsArr[index].ansver ?? "" {
            result += 1
        }
           
           let vc = MainVC()
            print(self.index+1)
           if self.index+1 < c {
               vc.index = self.index+1
               vc.result = self.result
               vc.questionsArr = self.questionsArr
               navigationController?.pushViewController(vc, animated: true)
           } else {
               let alert = UIAlertController(title: "Game Over!", message: "Your result: \(result)/\(c)!", preferredStyle: .alert)
               alert.addAction(UIAlertAction(title: "Cancel", style: .destructive, handler: {_ in
                   print("Cancel")
               }))
               alert.addAction(UIAlertAction(title: "Restart", style: .default, handler: {_ in
                   print("Restart")
                   vc.index = 0
                   vc.result = 0
                   self.navigationController?.setViewControllers([vc], animated: true)
                   
               }))
               self.present(alert, animated: true, completion: nil)
           }
          
       }
    
}

