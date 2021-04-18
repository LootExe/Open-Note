//import 'package:equatable/equatable.dart';

abstract class NoteData {
  //extends Equatable {
  String title;
  DateTime editTime;

  //@override
  //List<Object> get props => [title, editTime];

  NoteData({required this.title, required this.editTime});

  NoteData clone();
}
