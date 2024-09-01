import 'dart:async';
import 'package:anim/models/file_model.dart';
import 'package:bloc/bloc.dart';

part 'job_file_event.dart';
part 'job_file_state.dart';

class FileBloc extends Bloc<FileEvent, FileState> {
  final Map<String, Timer> _timers = {};

  FileBloc() : super(FileState(files: [])) {
    on<LoadFiles>((event, emit) {
      for (var file in event.files) {
        file.generateRandomContent();
      }
      emit(FileState(files: event.files));
    });

    on<SelectFile>((event, emit) {
      _startTimer(event.file);
      emit(FileState(files: state.files, selectedFile: event.file));
    });

    on<UpdateFile>((event, emit) {
      event.file.updateContent();
      emit(FileState(files: state.files, selectedFile: state.selectedFile));
    });
  }

  void _startTimer(JobFile file) {
    _timers[file.id]?.cancel();
    _timers[file.id] = Timer.periodic(const Duration(seconds: 10), (timer) {
      add(UpdateFile(file));
    });
  }

  void dispose() {
    _timers.values.forEach((timer) => timer.cancel());
    _timers.clear();
  }
}