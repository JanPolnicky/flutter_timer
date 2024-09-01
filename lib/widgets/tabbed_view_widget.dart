import 'package:anim/models/file_model.dart';
import 'package:flutter/material.dart';
import 'package:tabbed_view/tabbed_view.dart';
import 'package:anim/models/job_model.dart';
import 'package:anim/bloc/job_file_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CustomTabbedView extends StatelessWidget {
  final TabbedViewController controller;
  final List<JobFile> files;

  CustomTabbedView({required this.controller, required this.files});

  @override
  Widget build(BuildContext context) {
    return TabbedView(
      controller: controller,
      contentBuilder: (BuildContext context, int tabIndex) {
        final file = files[tabIndex];
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('File Name: ${file.name}', style: const TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 10),
              BlocBuilder<FileBloc, FileState>(
                builder: (context, state) {
                  return Text(file.content);
                },
              ),
            ],
          ),
        );
      },
      closeButtonTooltip: 'Click here to close the tab',
    );
  }
}