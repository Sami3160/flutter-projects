void greet({required String name, int? age=null}){
  print("name is ${name} and the age is ${age??0}");
}

void main(){
  greet(name: "sami", age: 21);
  greet(name: "sami");
}