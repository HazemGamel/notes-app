class NotesModel {
  String? notesId;
  String? notesTitle;
  String? notesContent;
  String? notesImage;
  String? notesUser;

  NotesModel(
      {this.notesId,
        this.notesTitle,
        this.notesContent,
        this.notesImage,
        this.notesUser});

  NotesModel.fromJson(Map<String, dynamic> json) {
    notesId = json['notes_id'];
    notesTitle = json['notes_title'];
    notesContent = json['notes_content'];
    notesImage = json['notes_image'];
    notesUser = json['notes_user'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['notes_id'] = this.notesId;
    data['notes_title'] = this.notesTitle;
    data['notes_content'] = this.notesContent;
    data['notes_image'] = this.notesImage;
    data['notes_user'] = this.notesUser;
    return data;
  }
}