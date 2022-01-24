//
//  main.swift
//  swift-starter-week4
//
//  Created by 이범준 on 2022/01/10.
//

import Foundation

struct BodyCondition {
    var upperBodyStrength: Int = 0
    var lowerBodyStrength: Int = 0
    var muscularEndurance: Int = 0
    var fatigue: Int = 0
    
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

let situp: Exercise = Exercise(name: "윗몸일으키기", action: {
    registerPerson.personBodyCondition.upperBodyStrength = registerPerson.personBodyCondition.upperBodyStrength + Int.random(in: 10...20)
    registerPerson.personBodyCondition.fatigue = registerPerson.personBodyCondition.fatigue + Int.random(in: 10...20)
})

let squirt: Exercise = Exercise(name: "스쿼트", action: {
    registerPerson.personBodyCondition.lowerBodyStrength = registerPerson.personBodyCondition.lowerBodyStrength + Int.random(in: 20...30)
    registerPerson.personBodyCondition.fatigue = registerPerson.personBodyCondition.fatigue + Int.random(in: 10...20)
})

let run: Exercise = Exercise(name: "오래달리기", action: {
    registerPerson.personBodyCondition.muscularEndurance = registerPerson.personBodyCondition.muscularEndurance + Int.random(in: 20...30)
    registerPerson.personBodyCondition.upperBodyStrength = registerPerson.personBodyCondition.upperBodyStrength + Int.random(in: 5...10)
    registerPerson.personBodyCondition.lowerBodyStrength = registerPerson.personBodyCondition.lowerBodyStrength + Int.random(in: 5...10)
    registerPerson.personBodyCondition.fatigue = registerPerson.personBodyCondition.fatigue + Int.random(in: 20...30)
})

let activeRest: Exercise = Exercise(name: "동적휴식", action: {
    registerPerson.personBodyCondition.fatigue = registerPerson.personBodyCondition.fatigue - Int.random(in: 5...10)
})


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

struct Person {
    var personName: String = ""
    var personBodyCondition: BodyCondition = BodyCondition()
    
    func noNamePerson() throws {
        guard personName != "" else {
            throw fitnessCenterError.noRegisterPerson
        }
    }
    
    func exercise(set: Int, routine: Routine) {
        print("\(routine.routineName)을 \(set)set 시작합니다.")
        for _ in 1...set {
            routine.startRoutine()
        }
        print("\n")
    }
    
    func fatigueFull() throws {
        guard self.personBodyCondition.fatigue < 100 else {
            throw fitnessCenterError.fullFatigue
        }
    }
}

struct FitnessCenter {
    var dreamOfBodyCondition: BodyCondition = BodyCondition()
    var member: Person?
    var hellRoutine: Routine = Routine(routineName: "hellRoutine", exerciseRountine: [situp,situp,activeRest,squirt,squirt,activeRest,run,run])
    var ohMyGodRoutine: Routine = Routine(routineName: "ohMyGodRoutine", exerciseRountine: [squirt,squirt,run,run,activeRest,activeRest])
    
    func checkMember(member: Person?) {
        do {
            try member?.noNamePerson()
        } catch fitnessCenterError.noRegisterPerson {
            print("사람이 없어요")
            exit(0)
        } catch {
            print("some error")
        }
    }
    
    func completeDream(member: Person?) throws {
        if let existPerson = member {
            guard existPerson.personBodyCondition.upperBodyStrength > yagomFintnessCenter.dreamOfBodyCondition.upperBodyStrength else {
                throw fitnessCenterError.failDream
            }
        }
        if let existPerson = member {
            guard existPerson.personBodyCondition.lowerBodyStrength > yagomFintnessCenter.dreamOfBodyCondition.lowerBodyStrength else {
                throw fitnessCenterError.failDream
            }
        }
        if let existPerson = member {
            guard existPerson.personBodyCondition.muscularEndurance > yagomFintnessCenter.dreamOfBodyCondition.muscularEndurance else {
                throw fitnessCenterError.failDream
            }
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

func setUpperStrength(inputUpperStrength: String?) {
    if let inputNumber = inputUpperStrength {
        let transferNumber: Int? = Int(inputNumber)
        if let number = transferNumber {
            yagomFintnessCenter.dreamOfBodyCondition.upperBodyStrength = number
        }
    }
}

func setLowerStrength(inputLowerStrength: String?) {
    if let inputNumber = inputLowerStrength {
        let transferNumber: Int? = Int(inputNumber)
        if let number = transferNumber {
            yagomFintnessCenter.dreamOfBodyCondition.lowerBodyStrength = number
        }
    }
}

func setMuscularEndurance(inputMuscularEndurance: String?) {
    if let inputNumber = inputMuscularEndurance {
        let transferNumber: Int? = Int(inputNumber)
        if let number = transferNumber {
            yagomFintnessCenter.dreamOfBodyCondition.muscularEndurance = number
        }
    }
}

func showSettingDream() {
    print("\n설정한 목표 운동치")
    print("상체근력: \(yagomFintnessCenter.dreamOfBodyCondition.upperBodyStrength)")
    print("하체근력: \(yagomFintnessCenter.dreamOfBodyCondition.lowerBodyStrength)")
    print("근지구력: \(yagomFintnessCenter.dreamOfBodyCondition.muscularEndurance)")
}
//----------------------------------

// -------------------------
var yagomFintnessCenter: FitnessCenter = FitnessCenter()

print("안녕하세요. 야곰 피트니스 센터입니다. 회원님의 이름은 무엇인가요?")

var registerPerson: Person = Person()
var inputName: String? = readLine()

if let name = inputName {
    registerPerson.personName = name
    yagomFintnessCenter.checkMember(member: registerPerson)
}

print("운동 목표치를 순서대로 알려주세요.")

print("상체근력:")
var inputUpperStrength: String? = readLine()
setUpperStrength(inputUpperStrength: inputUpperStrength)

print("하체근력:")
var inputLowerStrength: String? = readLine()
setLowerStrength(inputLowerStrength: inputLowerStrength)

print("근지구력:")
var inputMuscularEndurance: String? = readLine()
setMuscularEndurance(inputMuscularEndurance: inputMuscularEndurance)

showSettingDream()
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
                registerPerson.exercise(set: transferMySet, routine: yagomFintnessCenter.hellRoutine)
                do {
                    try registerPerson.fatigueFull()
                } catch fitnessCenterError.fullFatigue {
                    print("피로도가 100이 넘어 회원이 도망쳤습니다.")
                }
            } else if myRoutine == "2" {
                registerPerson.exercise(set: transferMySet, routine: yagomFintnessCenter.ohMyGodRoutine)
                do {
                    try registerPerson.fatigueFull()
                } catch fitnessCenterError.fullFatigue {
                    print("피로도가 100이 넘어 회원이 도망쳤습니다.")
                }
            }
        }
    }
    registerPerson.personBodyCondition.showBodyCondition()
}


do{
    try selectRoutine(selectSet: selectSet)
} catch fitnessCenterError.wrongInput {
    print("입력값을 확인해주세요")
}

do {
    try yagomFintnessCenter.completeDream(member: registerPerson)
} catch fitnessCenterError.failDream {
    print("목표치에 미달했습니다.")
}
