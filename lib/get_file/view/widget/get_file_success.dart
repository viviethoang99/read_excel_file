import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:json_editor/json_editor.dart';

import '../../cubit/get_file_cubit.dart';

class GetFileSuccess extends StatelessWidget {
  const GetFileSuccess({
    super.key,
    required this.listData,
  });

  final List<String> listData;

  @override
  Widget build(BuildContext context) {
    return JsonEditor.string(
      jsonString: listData.toString(),
      onValueChanged: context.read<GetFileCubit>().onChangeJson,
    );
  }
}
