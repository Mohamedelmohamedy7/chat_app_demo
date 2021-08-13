import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class userImagepicgker extends StatefulWidget {
  final void Function (File pickedimage) imagepickfn;

   userImagepicgker(this.imagepickfn);
  @override
  _userImagepicgkerState createState() => _userImagepicgkerState();
}

class _userImagepicgkerState extends State<userImagepicgker> {
  File? _pickerImage;

  final ImagePicker _Picker = ImagePicker();

  void _imagepick(ImageSource src) async {
    final pickedimagefile = await _Picker.getImage(source: src,imageQuality: 50,maxWidth: 150);
    if (pickedimagefile != null) {
      setState(() {
        _pickerImage = File(pickedimagefile.path);
      });
      widget.imagepickfn(_pickerImage!);
    } else {
      print("No Image Selected");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 40,
          backgroundColor: Colors.grey,
          backgroundImage:
              _pickerImage != null ? FileImage(_pickerImage!) : null,
        ),
        SizedBox(),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            FlatButton.icon(
              onPressed:()=>_imagepick(ImageSource.camera),
              icon: Icon(Icons.camera_alt_outlined),
              label :Text("Add Image\n from Camera",textAlign: TextAlign.center,),
              textColor: Theme.of(context).primaryColor,
            ), FlatButton.icon(
              onPressed:()=>_imagepick(ImageSource.gallery),
              icon: Icon(Icons.image_outlined),
              label :Text("Add Image\n from gallery",textAlign: TextAlign.center,),
              textColor: Theme.of(context).primaryColor,
            ),
          ],
        )
      ],
    );
  }
}
