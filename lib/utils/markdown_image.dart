import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

void updateMarkdownWithImageLink(String imageName, String serverImageName) {
  final markdownController = TextEditingController();
  final currentMarkdown = markdownController.text;
  final updatedMarkdown = currentMarkdown.replaceAll(
    '[$imageName]()',
    '[$imageName](http://your-django-server.com/media/files/$serverImageName)',
  );
  markdownController.text = updatedMarkdown;
}

class MarkdownExample extends StatelessWidget {
  final TextEditingController markdownController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Markdown Example'),
      ),
      body: Column(
        children: [
          Expanded(
            child: TextField(
              controller: markdownController,
              maxLines: null,
              decoration: InputDecoration(
                hintText: 'Enter Markdown content here...',
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () async {
              // Example image file
              final imageFile = File('path/to/your/image.png');
              final serverImageName = await uploadImage(imageFile);
              updateMarkdownWithImageLink('image_name.png', serverImageName);
            },
            child: Text('Upload Image and Update Markdown'),
          ),
          Expanded(
            child: Markdown(
              data: markdownController.text,
              styleSheet: MarkdownStyleSheet.fromTheme(Theme.of(context)),
            ),
          ),
        ],
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: MarkdownExample(),
  ));
}