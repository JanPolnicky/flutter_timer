import 'dart:math';

class JobFile {
  final String id;
  final String name;
  String content;

  JobFile({required this.id, required this.name, this.content = ''});

  void generateRandomContent() {
    final random = Random();
    content = List.generate(100, (index) => String.fromCharCode(random.nextInt(26) + 97)).join();
  }

  void updateContent() {
    content = 'Updated content at ${DateTime.now()}';
  }
}