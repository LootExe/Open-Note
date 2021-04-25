abstract class NoteData {
  String title;
  NoteType type;
  DateTime editTime;

  NoteData({required this.title, required this.type, required this.editTime});

  NoteData clone();
  bool compareTo(NoteData data);
  Map<String, dynamic> toJson();
}

enum NoteType {
  Todo,
  Text,
}
