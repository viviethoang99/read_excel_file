import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:excel/excel.dart';
import 'package:file_picker/file_picker.dart';
import 'package:json_editor/json_editor.dart';

part 'get_file_state.dart';

class GetFileCubit extends Cubit<GetFileState> {
  GetFileCubit() : super(GetFileInitialState());

  Future<void> onTap() async {
    try {
      emit(GetFileLoadingState());
      final excel = await selectFileExel();
      if (excel == null) {
        emit(GetFileFailedState());
        return;
      }
      final listJson = await getDataFromExcel(excel);
      emit(GetFileSuccessState(listJson));
    } catch (_) {
      emit(GetFileFailedState());
    }
  }

  Future<Excel?> selectFileExel() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['xlsx', 'csv', 'xls'],
    );
    if (result?.files.isEmpty ?? true) return null;
    final fileBytes = result!.files.first.bytes;
    return Excel.decodeBytes(fileBytes!);
  }

  Future<List<String>> getDataFromExcel(Excel excel) async {
    final jsonMap = <String>[];
    for (final table in excel.tables.keys) {
      final listRow = excel.tables[table]!.rows;
      final keys = dataKeyToString(listRow.first);
      var i = 0;
      for (final row in listRow) {
        if (i == 0) {
          i++;
        } else {
          final temp = <String, dynamic>{};
          var j = 0;
          for (final key in keys) {
            temp[key] = '${row[j]?.value}';
            j++;
          }
          final data = json.encode(temp);
          jsonMap.add(data);
        }
      }
    }
    return jsonMap;
  }

  void onChangeJson(JsonElement value) {}

  List<String> dataKeyToString(List<Data?> listData) {
    return listData.map((data) => data!.value.toString()).toList();
  }
}
