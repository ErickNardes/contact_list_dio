import 'package:contact_list_dio/app/contacts/model/contact_model.dart';

abstract class IContactRepository {
  Future<int> insertContact(ContactModel model);
  Future<List<ContactModel>> getContacts();
}
