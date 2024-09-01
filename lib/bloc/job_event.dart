part of 'job_bloc.dart';

abstract class JobEvent {}

class LoadJobs extends JobEvent {}

class ToggleJobExpansion extends JobEvent {
  final String jobId;

  ToggleJobExpansion({required this.jobId});
}