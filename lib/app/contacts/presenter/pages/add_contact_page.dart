import 'dart:io';

import 'package:brasil_fields/brasil_fields.dart';
import 'package:contact_list_dio/app/contacts/presenter/controller/contact_controller.dart';
import 'package:contact_list_dio/app/contacts/repository/contact_repository.dart';
import 'package:contact_list_dio/app/contacts/repository/i_contact_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AddContactPage extends StatefulWidget {
  const AddContactPage({super.key});

  @override
  State<AddContactPage> createState() => _AddContactPageState();
}

class _AddContactPageState extends State<AddContactPage> {
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
        title: const Text(
          'Adicionar novo contato',
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: controller.formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Campo obrigatório';
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    label: Text('Nome'),
                    border: OutlineInputBorder(),
                  ),
                  controller: controller.nameController,
                ),
                const SizedBox(height: 20),
                TextFormField(
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    TelefoneInputFormatter(),
                  ],
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Campo obrigatório';
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    label: Text('Telefone'),
                    border: OutlineInputBorder(),
                  ),
                  controller: controller.contactController,
                ),
                const SizedBox(height: 20),
                SizedBox(
                  height: 50,
                  width: 200,
                  child: ElevatedButton.icon(
                    icon: const Icon(
                      Icons.camera_alt_outlined,
                      color: Colors.black,
                    ),
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        side: const BorderSide(
                          color: Colors.black,
                        )),
                    onPressed: () {
                      showModalBottomSheet(
                          context: context,
                          builder: (context) {
                            return Container(
                              child: Wrap(
                                runAlignment: WrapAlignment.center,
                                alignment: WrapAlignment.center,
                                children: [
                                  ListTile(
                                    onTap: () async {
                                      await controller.pickerImage();
                                      setState(() {});
                                    },
                                    leading:
                                        const Icon(Icons.camera_alt_outlined),
                                    title: const Text('Camera'),
                                  ),
                                  const ListTile(
                                    leading: Icon(Icons.image),
                                    title: Text('Galeria'),
                                  )
                                ],
                              ),
                            );
                          });
                    },
                    label: const Text(
                      'Foto',
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                if (controller.file != null)
                  SizedBox(
                    height: 200,
                    width: 300,
                    child: Image.file(
                      File(controller.file!.path),
                    ),
                  ),
                Padding(
                  padding: const EdgeInsets.only(top: 100),
                  child: SizedBox(
                    height: 50,
                    width: MediaQuery.of(context).size.width,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black),
                      onPressed: () async {
                        controller.insertContact();
                      },
                      child: const Text(
                        'Cadastrar',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
