void main(){
  var a=[1,2,3,4];
  print(a.sum);
}



extension on List<int>{
  get sum{
    int s=0;
    this.forEach((e)=>s+=e);
    return s;
  }
}