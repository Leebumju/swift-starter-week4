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
        for order in exerciseRountine {
            print("\(order.name)")
            order.action()
        }
    }
}

enum fitnessCenterError: Error {
    case fullFatigue
    case failDream
    case wrongInput
    case noRegisterPerson
    case etc
}

struct Person {
    var personName: String = ""
    var personBodyCondition: BodyCondition = BodyCondition()
    
    func exercise(set: Int, routine: Routine) throws {
        print("\(routine.routineName)을 \(set)set 시작합니다.")
        guard self.personBodyCondition.fatigue < 100 else {
            throw fitnessCenterError.fullFatigue
        }
        for _ in 1...set {
            routine.startRoutine()
        }
        print("\n")
    }
}

var yagomFintnessCenter: FitnessCenter = FitnessCenter()

print("안녕하세요. 야곰 피트니스 센터입니다. 회원님의 이름은 무엇인가요?")
var registerPerson: Person = Person()
var inputName: String? = readLine()

if let name = inputName {
    registerPerson.personName = name
}

struct FitnessCenter {
    var dreamOfBodyCondition: BodyCondition = BodyCondition()
    var member: Person?
    var hellRoutine: Routine = Routine(routineName: "hellRoutine", exerciseRountine: [situp,situp,activeRest,squirt,squirt,activeRest,run,run])
    var ohMyGodRoutine: Routine = Routine(routineName: "ohMyGodRoutine", exerciseRountine: [squirt,squirt,run,run,activeRest,activeRest])
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
/*
hellRoutine.startRoutine()

myBodyCondition.showBodyCondition()
*/


//---------------------------------------------------------
print("운동 목표치를 순서대로 알려주세요.")

print("상체근력:")
var inputUpperStrength: String? = readLine()

if let inputNumber = inputUpperStrength {
    let transferNumber: Int? = Int(inputNumber)
    if let number = transferNumber {
        yagomFintnessCenter.dreamOfBodyCondition.upperBodyStrength = number
    }
}

print("하체근력:")
var inputLowerStrength: String? = readLine()

if let inputNumber = inputLowerStrength {
    let transferNumber: Int? = Int(inputNumber)
    if let number = transferNumber {
        yagomFintnessCenter.dreamOfBodyCondition.lowerBodyStrength = number
    }
}

print("근지구력:")
var inputMuscularEndurance: String? = readLine()

if let inputNumber = inputMuscularEndurance {
    let transferNumber: Int? = Int(inputNumber)
    if let number = transferNumber {
        yagomFintnessCenter.dreamOfBodyCondition.muscularEndurance = number
    }
}

print("\n설정한 목표 운동치")
print("상체근력: \(yagomFintnessCenter.dreamOfBodyCondition.upperBodyStrength)")
print("하체근력: \(yagomFintnessCenter.dreamOfBodyCondition.lowerBodyStrength)")
print("근지구력: \(yagomFintnessCenter.dreamOfBodyCondition.muscularEndurance)")
//---------------------------------------------------------
print("\n몇 번째 루틴으로 운동하시겠어요?")
print("1. hellRoutine")
print("2. ohMyGodRoutine")

var myRoutine: String? = readLine()

print("\n 몇 세트를 반복하시겠어요?")
var selectSet: String? = readLine()

//1이면 hellRoutine, 2이면 ohmyGodroutine
func selectRoutine(selectSet: String?) throws {
    guard myRoutine == "1" || myRoutine == "2" else {
        throw fitnessCenterError.wrongInput
    }
    
    guard selectSet != "0" else {
        throw fitnessCenterError.wrongInput
    }
    
    if let mySet = selectSet {
        let transferMySet: Int? = Int(mySet)
        if let transferMySet = transferMySet {
            if myRoutine == "1" {
                do {
                    try registerPerson.exercise(set: transferMySet, routine: yagomFintnessCenter.hellRoutine)
                } catch fitnessCenterError.fullFatigue {
                    print("피로도가 100이 넘어 회원이 도망쳤습니다.")
                }
            } else if myRoutine == "2" {
                do {
                    try registerPerson.exercise(set: transferMySet, routine: yagomFintnessCenter.ohMyGodRoutine)
                } catch fitnessCenterError.fullFatigue {
                    print("피로도가 100이 넘어 회원이 도망쳤습니다.")
                }
            }
        }
    }
    registerPerson.personBodyCondition = myBodyCondition
    registerPerson.personBodyCondition.showBodyCondition()
}

do{
    try selectRoutine(selectSet: selectSet)
} catch fitnessCenterError.wrongInput {
    print("입력값을 확인해주세요")
}

//성공입니다! 현재 야곰님의 컨디션은 다음과 같습니다.
/*상체근력: 120
하체근력: 80
근지구력: 90
피로도: 80


    func selectRoutine(selectSet: String?) {
        if let mySet = selectSet {
            let transferMySet: Int? = Int(mySet)
            if let transferMySet = transferMySet {
                if selectRoutine == "1" {
                    registerPerson.exercise(set: transferMySet, routine: yagomFintnessCenter.hellRoutine)
                } else if selectRoutine == "2" {
                    registerPerson.exercise(set: transferMySet, routine: yagomFintnessCenter.ohMyGodRoutine)
                } else {
                    print("번호를 잘못 입력했습니다")
                }
            }
        }
    }
*/
