import 'dart:convert';

import 'package:contact_list_dio/app/contacts/model/contact_model.dart';
import 'package:contact_list_dio/app/contacts/repository/i_contact_repository.dart';
import 'package:http/http.dart' as http;

class ContactRepository implements IContactRepository {
  @override
  Future<List<ContactModel>> getContacts() async {
    try {
      final response = await http.get(
        Uri.parse('Your api url'),
        headers: {
          'X-Parse-Application-Id': 'Your api key',
          'X-Parse-REST-API-Key': 'Your api key',
        },
      );

      final data = jsonDecode(response.body);

      return data['results']
          .map((e) => ContactModel.fromMap(e))
          .toList()
          .cast<ContactModel>();
    } catch (e) {
      print('Erro ao obter contatos: $e');
      return [];
    }
  }

  @override
  Future<int> insertContact(ContactModel model) async {
    try {
      final respoonse = await http.post(
          Uri.parse('https://parseapi.back4app.com/classes/Contacts'),
          headers: {
            'X-Parse-Application-Id':
                'B2G05yUBHLmFLFqaF32aMBXf1x3QiDgP9CFe4isb',
            'X-Parse-REST-API-Key': 'zRhYgVpdvASvk4mldX87h9T1SiV29cIvaNRc5oGI',
          },
          body: ContactModel.contactModelToMap(model));
      return respoonse.statusCode;
    } catch (e) {
      return 400;
    }
  }
}
