//
//  main.swift
//  swift-starter-week4
//
//  Created by 이범준 on 2022/01/10.
//

import Foundation

struct BodyCondition {
    var upperBodyStrength: Int = 0 //상체근력
    var lowerBodyStrength: Int = 0//하체근력
    var muscularEndurance: Int = 0//근지구력
    var fatigue: Int = 0//피로도
    
    func showBodyCondition() {
        print("상체근력: \(upperBodyStrength)")
        print("하체근력: \(lowerBodyStrength)")
        print("근지구력: \(muscularEndurance)")
        print("피로도: \(fatigue)")
    }
}

struct Exercise {
    let name: String
    let action: () -> Void
}

struct Routine {
    var routineName: String
    var exerciseRountine: [Exercise] = [Exercise]()
    
    func startRoutine() {
        print("-----------")
        print("\(routineName)을 시작합니다.")
        for order in exerciseRountine {
            print("\(order.name)")
            order.action()
        }
        print("-----------")
    }
}

var myBodyCondition: BodyCondition = BodyCondition()

let situp: Exercise = Exercise(name: "윗몸일으키기", action: {
    myBodyCondition.upperBodyStrength = myBodyCondition.upperBodyStrength + Int.random(in: 10...20)
    myBodyCondition.fatigue = myBodyCondition.fatigue + Int.random(in: 10...20)
})

let squirt: Exercise = Exercise(name: "스쿼트", action: {
    myBodyCondition.lowerBodyStrength = myBodyCondition.lowerBodyStrength + Int.random(in: 20...30)
    myBodyCondition.fatigue = myBodyCondition.fatigue + Int.random(in: 10...20)
})

let run: Exercise = Exercise(name: "오래달리기", action: {
    myBodyCondition.muscularEndurance = myBodyCondition.muscularEndurance + Int.random(in: 20...30)
    myBodyCondition.upperBodyStrength = myBodyCondition.upperBodyStrength + Int.random(in: 5...10)
    myBodyCondition.lowerBodyStrength = myBodyCondition.lowerBodyStrength + Int.random(in: 5...10)
    myBodyCondition.fatigue = myBodyCondition.fatigue + Int.random(in: 20...30)
})

let activeRest: Exercise = Exercise(name: "동적휴식", action: {
    myBodyCondition.fatigue = myBodyCondition.fatigue - Int.random(in: 5...10)
})

var hellRoutine: Routine = Routine(routineName: "helloRoutine", exerciseRountine: [situp,situp,activeRest,squirt,squirt,activeRest,run,run])

hellRoutine.startRoutine()

myBodyCondition.showBodyCondition()
