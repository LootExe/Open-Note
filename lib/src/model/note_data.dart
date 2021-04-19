abstract class NoteData {
  String title;
  DateTime editTime;

  NoteData({required this.title, required this.editTime});

  NoteData clone();
  bool compareTo(NoteData data);
}
