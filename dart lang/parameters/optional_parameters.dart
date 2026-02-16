void greet(String name, [int? age]){
  print('Name is ${name} and age is ${age}');
} 
void main(){
  greet("sami", 21);
  greet("sami");
}