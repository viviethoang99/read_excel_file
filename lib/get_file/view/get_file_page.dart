import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../l10n/l10n.dart';
import '../cubit/get_file_cubit.dart';
import 'widget/get_file_success.dart';

class GetFilePage extends StatelessWidget {
  const GetFilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GetFileCubit(),
      child: const CounterView(),
    );
  }
}

class CounterView extends StatelessWidget {
  const CounterView({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Scaffold(
      appBar: AppBar(title: Text(l10n.counterAppBarTitle)),
      body: BlocBuilder<GetFileCubit, GetFileState>(
        builder: (context, state) {
          if (state is GetFileLoadingState) {
            return Center(
              child: Container(
                width: double.infinity,
                height: double.infinity,
                color: Colors.amber,
              ),
            );
          }
          if (state is GetFileSuccessState) {
            return GetFileSuccess(listData: state.listData);
          }
          return const Center(child: FileUploadButton());
        },
      ),
    );
  }
}

class FileUploadButton extends StatelessWidget {
  const FileUploadButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetFileCubit, GetFileState>(
      builder: (context, state) {
        return TextButton(
          onPressed: context.read<GetFileCubit>().onTap,
          child: const Text('UPLOAD FILE'),
        );
      },
    );
  }
}
