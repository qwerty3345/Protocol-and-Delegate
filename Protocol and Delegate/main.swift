// 응급구조를 행할 수 있는 프로토콜을 정의
protocol AdvancedLifeSupport {
    func performCPR()
}

// 이벤트를 받아서 넘기는 (어떻게 동작하지는 알지 못하는) 핸들러 정의 _ 응급구조를 요청하는 콜센터 직원 개념.
class EmergencyCallHandler {
    var delegate: AdvancedLifeSupport?
    
    func assessSituation() {
        print("assessing situation.")
    }
    
    // delegate의 performCPR 메서드가 어떻게 생겼는지는 모르지만, 프로토콜 타입의 delegate가 구문을 행할 수 있도록 해줌.
    func medicalEmergency() {
        delegate?.performCPR()
    }
}

// 실제 이벤트를 행하는 주체 (응급구조 프로토콜을 상속받아 구현.)
class Doctor : AdvancedLifeSupport{
    // 초기화 시에 이벤트 주체의 핸들러를 지정.
    init(handler: EmergencyCallHandler) {    
        // 핸들러의 delegate가 본인임을 지정해줌으로서 실제 액션을 행할 수 있게 함.
        handler.delegate = self
    }
    
    // performCPR이 실제로 어떠한 동작을 하는지를 구현.
    func performCPR() {
        print("perform CPR.")
    }
}

class Surgeon : Doctor {
    override func performCPR() {
        super.performCPR()
        print("Extra CPR.")
    }
}

///////////////////////////////////////////////////////////////////////////////////////////////////////////

let caller = EmergencyCallHandler() // 핸들러 생성
let drKim = Surgeon(handler: caller)
//let drLee = Doctor(handler: caller)   // 핸들러를 추가로 지정해줬을 때는 drKim이 실행되지 않고 drLee 만 실행됨. Question. 이러할 때 두개의 핸들러가 다 실행되도록 하고 싶으면 어떻게 해야 할까?

caller.medicalEmergency()   // 핸들러를 시행해줬을 뿐인데, 위에서 초기화한 drKim의 함수가 실행됨.
