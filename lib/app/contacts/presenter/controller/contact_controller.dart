import 'package:contact_list_dio/app/contacts/model/contact_model.dart';
import 'package:contact_list_dio/app/contacts/repository/i_contact_repository.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';

class ContactController {
  final IContactRepository repository;
  ContactController({
    required this.repository,
  });
  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final contactController = TextEditingController();
  String pathFile = '';
  XFile? file;
  List<ContactModel> listContacts = [];

  Future<void> pickerImage() async {
    final ImagePicker image = ImagePicker();
    file = await image.pickImage(source: ImageSource.camera);
    if (file != null) {
      pathFile = file!.path;
      // cropImage(file);
    }
  }

  void cropImage(XFile? file) async {
    await ImageCropper().cropImage(
      sourcePath: file!.path,
      aspectRatioPresets: [
        CropAspectRatioPreset.square,
        CropAspectRatioPreset.ratio3x2,
        CropAspectRatioPreset.original,
        CropAspectRatioPreset.ratio4x3,
        CropAspectRatioPreset.ratio16x9
      ],
      uiSettings: [
        AndroidUiSettings(
            toolbarTitle: 'Cropper',
            toolbarColor: Colors.deepOrange,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false),
        IOSUiSettings(
          title: 'Cropper',
        ),
      ],
    );
    file = XFile(file.path);
  }

  Future<void> insertContact() async {
    final model = ContactModel(
        name: nameController.text,
        photo: pathFile,
        contact: contactController.text);

    if (formKey.currentState!.validate()) {
      await repository.insertContact(model);
    }
  }

  Future<void> getListContacts() async {
    final result = await repository.getContacts();
    listContacts = result;
  }
}
