abstract class Benefit {
  contractBenefits();
}

class CLT implements Benefit {
  @override
  contractBenefits() { }
}

class PJ implements Benefit {
  @override
  contractBenefits() { }
}

class Trainee implements Benefit {
  @override
  contractBenefits() { }
}

class Benefits {
  
  void defineBenefits(Benefit contractType) {
    contractType.contractBenefits();
  } 
}


final cltBenefits = Benefits().defineBenefits(CLT());

final pjBenefits = Benefits().defineBenefits(PJ());

final traineeBenefits = Benefits().defineBenefits(Trainee());
