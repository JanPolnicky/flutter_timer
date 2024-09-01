import 'package:anim/bloc/job_file_bloc.dart';
import 'package:anim/widgets/expandable_row.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:anim/bloc/job_bloc.dart';
import 'package:expandable/expandable.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  void dispose() {
    context.read<FileBloc>().dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => JobBloc()..add(LoadJobs())),
        BlocProvider(create: (_) => FileBloc()),
      ],
      child: MaterialApp(
        home: Scaffold(
          appBar: AppBar(title: const Text('Job List')),
          body: Column(
            children: [
              Expanded(
                child: BlocBuilder<JobBloc, JobState>(
                  builder: (context, state) {
                    return ListView(
                      children: state.jobs.map((job) {
                        return ExpandableRow(job: job);
                      }).toList(),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}