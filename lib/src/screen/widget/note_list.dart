import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/note_list_bloc.dart';
import '../note_screen.dart';
import 'note_card.dart';

class NoteList extends StatefulWidget {
  const NoteList({Key? key}) : super(key: key);

  @override
  State<NoteList> createState() => _NoteListState();
}

class _NoteListState extends State<NoteList> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NoteListBloc, NoteListState>(
      builder: (context, state) => ListView.builder(
        padding: const EdgeInsets.only(top: 12.0),
        itemCount: state.notes.length,
        itemBuilder: (context, index) => NoteCard(
          data: state.notes[index],
          onPressed: () async {
            final bloc = BlocProvider.of<NoteListBloc>(context);

            await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => NoteScreen(data: state.notes[index]),
                ));

            bloc.add(NoteListUpdated());
          },
          onDissmissed: () {
            BlocProvider.of<NoteListBloc>(context)
                .add(NoteListItemDeleted(state.notes[index]));
          },
        ),
      ),
    );
  }
}
