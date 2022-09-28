abstract class NoteData {
  NoteData({required this.title, required this.type, required this.editTime});

  String title;
  NoteType type;
  DateTime editTime;

  NoteData clone();
  bool compareTo(NoteData data);
  Map<String, dynamic> toJson();
}

enum NoteType {
  todo,
  text,
}
