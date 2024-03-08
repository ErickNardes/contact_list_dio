import 'dart:io';

import 'package:contact_list_dio/app/contacts/presenter/controller/contact_controller.dart';
import 'package:contact_list_dio/app/contacts/repository/contact_repository.dart';
import 'package:flutter/material.dart';

class ContactPage extends StatefulWidget {
  const ContactPage({super.key});

  @override
  State<ContactPage> createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  final ContactRepository iContactRepository = ContactRepository();
  late final ContactController controller;

  @override
  void initState() {
    super.initState();
    controller = ContactController(repository: iContactRepository);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Lista de contatos'),
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () async {
            await controller.getListContacts();
            setState(() {});
          },
          label: Text('Buscar Contatos'),
        ),
        body: SizedBox(
          child: ListView.builder(
              itemCount: controller.listContacts.length,
              itemBuilder: (context, index) {
                final item = controller.listContacts[index];
                return ListTile(
                  trailing: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.file(File(item.photo))),
                  subtitle: Text(item.contact),
                  title: Text(
                    item.name,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                );
              }),
        ));
  }
}
