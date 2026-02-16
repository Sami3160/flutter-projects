// its similar to static methods and must return instance using return statement
// it returns instance using aother constructor
//there should be atleast two constructors in the class, one is generative amd another is factory constructor
//these factory constructors wont work individually, they need to rely on other constructor


// example
class Abc {
  Abc(){}
  Abc.demo(){}
  factory Abc.test(){
    return Abc();
  }
}


class A {
  int x;
  A(this.x);          // generative constructor
  A.demo():this(5);   // named constructor
  factory A.test(){   // factory constructor
    return A(5);
  }
}



class B {
  B();
  factory B.factory1(){
    return B();
  }
  
  factory B.factory2(){
    return B();
  }
  
  factory B.factory3(){
    return B();
  }
}


void main(){
  Abc obj=Abc.test();
}





//characteristics
// must return an instance
// it can be named or unnamed and can be invoked like normal constructor
// cannot access instance members or functions
// cant use this in factory constructor
// cant use super class connstructros