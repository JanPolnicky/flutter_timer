import 'package:anim/models/file_model.dart';

class Job {
  final String id;
  final String name;
  final List<JobFile> files;
  bool isExpanded;

  Job({
    required this.id,
    required this.name,
    required this.files,
    this.isExpanded = false,
  });
}