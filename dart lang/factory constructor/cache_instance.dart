// Factory Constructor with Caching
// (Also known as Multiton pattern)

class Person {
  static final _cachedUser =
      {}; // a static map, shared across all instances, stored previously created objects
  String name;
  Person._internal(this.name);

  factory Person(String name) {
    return _cachedUser.putIfAbsent(name, () => Person._internal(name));   //find existing key and return object
  }

  void showData() {
    print("${name}  ${hashCode}");
  }
}
void main(){
  Person p1=Person("Sami");
  Person p2=Person("luffy");
  Person p3=Person("luffy");

  p1.showData();
  p2.showData();
  p3.showData();
}
