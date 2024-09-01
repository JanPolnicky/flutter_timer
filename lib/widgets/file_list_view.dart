import 'package:flutter/material.dart';
import 'package:anim/models/job_model.dart';
import 'package:anim/models/file_model.dart';
import 'package:anim/bloc/job_file_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FileListView extends StatelessWidget {
  final List<JobFile> files;
  final Function(JobFile) onFileTap;

  FileListView({required this.files, required this.onFileTap});

  @override
  Widget build(BuildContext context) {
    if (files.isEmpty) {
      return const Center(child: Text('No files available'));
    }
    return ListView(
      children: files.map((file) {
        return ListTile(
          title: Text(file.name),
          onTap: () {
            context.read<FileBloc>().add(SelectFile(file: file));
            onFileTap(file);
          },
        );
      }).toList(),
    );
  }
}