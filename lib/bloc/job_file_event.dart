part of 'job_file_bloc.dart';

class FileEvent {}

class LoadFile extends FileEvent {
  final JobFile file;

  LoadFile(this.file);
}

class UpdateFile extends FileEvent {
  final JobFile file;

  UpdateFile(this.file);
}

class LoadFiles extends FileEvent {
  final List<JobFile> files;

  LoadFiles({required this.files});
}

class SelectFile extends FileEvent {
  final JobFile file;

  SelectFile({required this.file});
}