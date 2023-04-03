class Marker {
  String name;
  int age;

  Marker(this.name, this.age);

  @override
  String toString() {
    return '{ ${this.name}, ${this.age} }';
  }
}