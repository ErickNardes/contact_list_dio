class ContactModel {
  final String? id;
  final String name;
  final String photo;
  final String contact;
  ContactModel({
    this.id,
    required this.name,
    required this.photo,
    required this.contact,
  });

  static ContactModel fromMap(Map<String, dynamic> map) {
    return ContactModel(
        id: map['objectId'],
        name: map['name'],
        photo: map['photo'],
        contact: map['contact']);
  }

  static Map<String, dynamic> contactModelToMap(ContactModel model) {
    return {
      'name': model.name,
      'contact': model.contact,
      'photo': model.photo,
    };
  }
}
