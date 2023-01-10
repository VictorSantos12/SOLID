abstract class DependencyInterface {
   resources() { 
    // some resource
  }
}

class Dependency implements DependencyInterface{
  @override
  resources() { }
}

class AnotherDependency implements DependencyInterface{
  @override
  resources() { }
}

class MyClass {
   
  final DependencyInterface dependency;
  
  const MyClass({
    required this.dependency,
  });
  
}

final myClass = MyClass(dependency: Dependency()).dependency.resources();
// final myClass = MyClass(dependency: AnotherDependency()).dependency.resources();

