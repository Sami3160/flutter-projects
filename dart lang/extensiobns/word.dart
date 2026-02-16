// a way to add more functionalities in dart libraries


void main(){
  String a=1.toWord;
  String b=10.toWord;
  print(a);
  print(b);
}


extension on int {
  get toWord {
    if(this==10){
      return "lucky word 10";
    }else{
      return 'the word is ${this}';
    }
  }
}