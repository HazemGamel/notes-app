import 'package:flutter/material.dart';
import 'package:notes/component/constans.dart';
import 'package:notes/models/notesmodel.dart';

class CardNotes extends StatelessWidget {
  final void Function()? ontab;
 final NotesModel notesModel;
  final void Function()? ondelete;

  const CardNotes({Key? key,required this.ondelete, required this.ontab,
    required this.notesModel}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ontab,
      child: Card(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
                flex: 1,
                child:Image.network("$linkphoto/${notesModel.notesImage}",
                  fit: BoxFit.fill,
                  width: 100,
                  height: 100,)),
            Expanded(
              flex: 2,
              child: ListTile(
                title: Text("${notesModel.notesTitle}"),
                subtitle: Text("${notesModel.notesContent}"),
                trailing: IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: ondelete,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
