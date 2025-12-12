// 1. Sum Arrays
num sum(List<num> arr) {
  return arr.isEmpty ? 0 : arr.reduce((a, b) => a + b);
}

// 2. Odd Ones Out
List<int> oddOnesOut(List<int> nums) {
  Map<int, int> counts = {};
  for (var n in nums) {
    counts[n] = (counts[n] ?? 0) + 1;
  }
  return nums.where((n) => counts[n]! % 2 == 0).toList();
}

// 3. Flatten and Sort
List<int> flattenAndSort(List<List<int>> nums) {
  return nums.expand((e) => e).toList()..sort();
}

// 4. Counting Duplicates
int duplicateCount(String text) {
  Map<String, int> counts = {};
  for (var c in text.toLowerCase().split('')) {
    counts[c] = (counts[c] ?? 0) + 1;
  }
  return counts.values.where((v) => v > 1).length;
}

void main() {
  // 1. Sum Arrays
  print(sum([])); // 0
  print(sum([5])); // 5
  print(sum([-5])); // -5
  print(sum([1, 2, 3.4, 4.3])); // 10.7
  print(sum([1, -3, 2, 3, 4, -1])); // 6

  // 2. Odd Ones Out
  print(oddOnesOut([1, 2, 3, 1, 3, 3])); // [1, 1]
  print(oddOnesOut([75, 68, 75, 47, 68])); // [75, 68, 75, 68]
  print(oddOnesOut([42, 72, 32, 4, 94, 82, 67, 67])); // [67, 67]

  // 3. Flatten and Sort
  print(flattenAndSort([[1, 3, 5], [100], [2, 4, 6]])); // [1, 2, 3, 4, 5, 6, 100]
  print(flattenAndSort([[], [1]])); // [1]
  print(flattenAndSort([[9, 7, 5], [8, 6, 4]])); // [4, 5, 6, 7, 8, 9]

  // 4. Counting Duplicates
  print(duplicateCount("")); // 0
  print(duplicateCount("abcde")); // 0
  print(duplicateCount("aabbcde")); // 2
  print(duplicateCount("aabBcde")); // 2
  print(duplicateCount("Indivisibility")); // 1
}
