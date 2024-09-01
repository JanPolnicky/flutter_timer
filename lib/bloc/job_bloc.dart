import 'package:anim/models/job_model.dart';
import 'package:anim/utils/data_generator.dart';
import 'package:bloc/bloc.dart';

part 'job_event.dart';
part 'job_state.dart';

class JobBloc extends Bloc<JobEvent, JobState> {
  JobBloc() : super(JobState(jobs: [])) {
    on<LoadJobs>((event, emit) {
      List<Job> jobs = generateJobs(10); // Generate 10 jobs, each with 10 files
      emit(JobState(jobs: jobs));
    });

    on<ToggleJobExpansion>((event, emit) {
      List<Job> updatedJobs = state.jobs.map((job) {
        if (job.id == event.jobId) {
          job.isExpanded = !job.isExpanded;
        } else {
          job.isExpanded = false;
        }
        return job;
      }).toList();
      emit(JobState(jobs: updatedJobs));
    });
  }
}