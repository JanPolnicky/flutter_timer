// lib/utils/data_generator.dart

import 'package:anim/models/file_model.dart';
import 'package:anim/models/job_model.dart';

List<JobFile> generateJobFiles(int jobId) {
  return List<JobFile>.generate(10, (index) {
    return JobFile(
      id: '$jobId-${index + 1}',
      name: 'File ${index + 1}',
      content: 'Content of file ${index + 1} for job $jobId',
    );
  });
}

List<Job> generateJobs(int numberOfJobs) {
  return List<Job>.generate(numberOfJobs, (index) {
    int jobId = index + 1;
    return Job(
      id: '$jobId',
      name: 'Job $jobId',
      files: generateJobFiles(jobId),
    );
  });
}