import 'package:flutter/material.dart';
import 'package:anim/models/job_model.dart';
import 'package:anim/models/file_model.dart';
import 'package:anim/bloc/job_bloc.dart';
import 'package:anim/bloc/job_file_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:expandable/expandable.dart';
import 'package:multi_split_view/multi_split_view.dart';
import 'package:tabbed_view/tabbed_view.dart';
import 'file_list_view.dart';
import 'tabbed_view_widget.dart';

class ExpandableRow extends StatefulWidget {
  final Job job;

  ExpandableRow({required this.job});

  @override
  State<ExpandableRow> createState() => _ExpandableRowState();
}

class _ExpandableRowState extends State<ExpandableRow> {
  late TabbedViewController _tabbedViewController;
  late List<TabData> tabs;

  @override
  void initState() {
    super.initState();
    tabs = [];
    _tabbedViewController = TabbedViewController(tabs);
  }

  void _addTab(JobFile file) {
    if (!tabs.any((tab) => tab.text == file.name)) {
      setState(() {
        tabs.add(TabData(
          text: file.name,
        ));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return ExpandableNotifier(
      child: ScrollOnExpand(
        child: Column(
          children: [
            Expandable(
              controller: ExpandableController(initialExpanded: widget.job.isExpanded),
              collapsed: ExpandableButton(
                child: ListTile(
                  title: Text(widget.job.name),
                  onTap: () {
                    context.read<JobBloc>().add(ToggleJobExpansion(jobId: widget.job.id));
                  },
                ),
              ),
              expanded: Column(
                children: [
                  ExpandableButton(
                    child: ListTile(
                      title: Text(widget.job.name),
                      onTap: () {
                        context.read<JobBloc>().add(ToggleJobExpansion(jobId: widget.job.id));
                      },
                    ),
                  ),
                  MultiSplitView(
                    initialAreas: [
                      Area(
                        flex: 1,
                        builder: (context, size) {
                          return BlocBuilder<FileBloc, FileState>(
                            builder: (context, state) {
                              return FileListView(
                                files: widget.job.files,
                                onFileTap: _addTab,
                              );
                            },
                          );
                        },
                      ),
                      Area(
                        flex: 2,
                        builder: (context, size) {
                          return CustomTabbedView(
                            controller: _tabbedViewController,
                            files: widget.job.files,
                          );
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}