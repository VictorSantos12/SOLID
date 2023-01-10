class ITEmployee {
   
   dynamic itDegree;
   programmingSkills() {}

}

class ManagementEmployee {
   
   dynamic managementDegree;
   managementSkills() {}

}

class TechLead implements ITEmployee {
  @override
  var itDegree;

  @override
  programmingSkills() {}

}

class BusinessManager implements ManagementEmployee {
  @override
  var managementDegree;
  
  @override
  managementSkills() {}

}


