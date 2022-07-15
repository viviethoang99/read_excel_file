part of 'get_file_cubit.dart';

abstract class GetFileState extends Equatable {
  const GetFileState();

  @override
  List<Object> get props => [];
}

class GetFileInitialState extends GetFileState {}

class GetFileLoadingState extends GetFileState {}

class GetFileSuccessState extends GetFileState {
  const GetFileSuccessState(this.listData);

  final List<String> listData;
}

class GetFileFailedState extends GetFileState {}
