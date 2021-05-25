import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/note_list_bloc.dart';
import '../note_screen.dart';
import 'note_card.dart';

class NoteList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NoteListBloc, NoteListState>(
      builder: (context, state) => ListView.builder(
        padding: const EdgeInsets.only(top: 12.0),
        itemCount: state.notes.length,
        itemBuilder: (context, index) => NoteCard(
          data: state.notes[index],
          onPressed: () async {
            await Navigator.push(
                context,
                CupertinoPageRoute(
                  builder: (_) => NoteScreen(data: state.notes[index]),
                ));

            BlocProvider.of<NoteListBloc>(context).add(NoteListUpdated());
          },
          onDissmissed: () {
            BlocProvider.of<NoteListBloc>(context)
              ..add(NoteListItemDeleted(state.notes[index]));
          },
        ),
      ),
    );
  }
}
