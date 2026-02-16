//factory design pattern (return sub class ionstance)
enum ShapeType { traiangle, rectangle }

abstract class Shape {
  factory Shape(ShapeType type){
    if(type == ShapeType.traiangle){
      return Triangle();
    }else{
      return Rectangle();
    }
  }
  void draw();
}

class Triangle implements Shape {
  void draw(){
    print("Its a triangle");
  }
}


class Rectangle implements Shape{
  void draw(){
    print("Its a rectangle");
  }
}




void main(){
  Shape s1=Shape(ShapeType.traiangle);
  Shape s2=Shape(ShapeType.rectangle);
  s1.draw();
  s2.draw();
}
