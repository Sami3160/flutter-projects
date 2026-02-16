void main(){
  var date=DateTime.now();
  print(date.customDate);
}

extension on DateTime{
  get customDate{
    return "Day : ${this.day} \nMonth : ${this.month} \nYear : ${this.year}";
  }
}