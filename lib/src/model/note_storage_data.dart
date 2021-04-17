import 'package:json_annotation/json_annotation.dart';

import './note_data.dart';

part 'note_storage_data.g.dart';

@JsonSerializable()
class NoteStorageData {
  Map<int, NoteType> storageDetails;

  NoteStorageData({required this.storageDetails});

  factory NoteStorageData.fromJson(Map<String, dynamic> json) =>
      _$NoteStorageDataFromJson(json);
  Map<String, dynamic> toJson() => _$NoteStorageDataToJson(this);
}
