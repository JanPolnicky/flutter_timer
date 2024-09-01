part of 'job_file_bloc.dart';

class FileState {
  final List<JobFile> files;
  final JobFile? selectedFile;

  FileState({required this.files, this.selectedFile});
}