abstract class Benefit {
  contractBenefits();
}

class CLT implements Benefit {
  @override
  contractBenefits() {
     print('Labor Rights');
   }
}

class PJ implements Benefit {
  @override
  contractBenefits() { 
    print('Bigger Salary');
  }
}

class Trainee implements Benefit {
  @override
  contractBenefits() { 
    print('Less responsibilities');
  }
}

class Benefits {
  
  void defineBenefits(Benefit contractType) {
    contractType.contractBenefits();
  } 
}

void main() {
  final cltBenefits = Benefits().defineBenefits(CLT());
  final pjBenefits = Benefits().defineBenefits(PJ());
  final traineeBenefits = Benefits().defineBenefits(Trainee());  
}