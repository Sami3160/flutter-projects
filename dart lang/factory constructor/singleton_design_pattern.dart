// single design pattern
// any class returning only one instance and provide globval access to taht single instance



//use???
// ensures only one object of class is ever created throughout applicatiojn lifecycle
// provides unified globallty accessible point to retrive this sole instance from anywhere in codebase
// class itself is responsible for managing its own creation and ensure no other instances are produced





class Test{
  static Test _instance=Test._internal();

  factory Test(){
    //using property of factory that static members can be accessed here
    return _instance;
  }


  Test._internal();   // a named constructor, will act as private constructor

}


void main(){
  Test t1=Test();
  Test t2=Test();


  print(t1.hashCode);
  print(t2.hashCode);
}