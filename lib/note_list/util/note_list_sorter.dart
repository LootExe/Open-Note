import 'package:note_repository/note_repository.dart';

List<Note> sortEditDate(List<Note> notes) {
  final sortedNotes = List.of(notes, growable: false)
    ..sort((a, b) => b.editTime.compareTo(a.editTime));

  return sortedNotes;
}

List<Note> sortAlphabetical(
  List<Note> notes, {
  bool ascending = true,
}) {
  final sortedNotes = List.of(notes, growable: false)
    ..sort((a, b) {
      final titleA = a.title.toLowerCase();
      final titleB = b.title.toLowerCase();

      return ascending ? titleA.compareTo(titleB) : titleB.compareTo(titleA);
    });

  return sortedNotes;
}

List<Note> sortManual(List<Note> notes, List<String> order) {
  final sortedNotes = List.of(notes, growable: false);
  final outOfBounds = order.length + 1;

  sortedNotes.sort((a, b) {
    final aIndex = order.contains(a.id) ? order.indexOf(a.id) : outOfBounds;
    final bIndex = order.contains(b.id) ? order.indexOf(b.id) : outOfBounds;

    return aIndex.compareTo(bIndex);
  });

  return sortedNotes;
}
