main() {
  splitList(2, 20);
}

splitList(int range, int initValue) {
  List newList = [];
  var nums = List.generate(initValue, (index) => index + 1);
  for (int i = 0; i < nums.length; i += range) {
    if (i + range < initValue) {
      newList.add(nums.sublist(i, i + range));
    } else {
      newList.add(nums.sublist(i));
    }
  }
  print(newList);
  print(nums);
}
