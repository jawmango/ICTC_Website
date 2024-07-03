import 'package:ICTC_Website/pages/desktop/profile/editProfileForm.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:ICTC_Website/models/student.dart';
import 'package:flutter/widgets.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ProfileDetails extends StatefulWidget {
  const ProfileDetails({Key? key, required this.student}) : super(key: key);

  final Student student;

  @override
  State<ProfileDetails> createState() => _ProfileDetailsState();
}

class _ProfileDetailsState extends State<ProfileDetails> {
  late Future<String?> avatarUrl = getAvatarUrl();

  Future<String?> getAvatarUrl() async {
    try {
      final url = await Supabase.instance.client.storage
          .from('avatars')
          .createSignedUrl(
              '${Supabase.instance.client.auth.currentSession!.user.id}/avatar.png',
              60);

      return url;
    } catch (e) {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        color: Colors.white,
        elevation: 4,
        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 40),
              shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(0), // Adjust the radius as needed
      ),
        child: Padding(
          padding: EdgeInsets.all(2.0),
          child: Column(
            mainAxisAlignment:
             MainAxisAlignment.center,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.2,
                height: MediaQuery.of(context).size.height * 0.530,
                child: Container(
                  margin: EdgeInsets.only(top: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Container(
                        // IMAGE
                        margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                        width: MediaQuery.of(context).size.width * 0.2,
                        height: 240,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                            color: Colors.white,
                            border: Border.all(color: Colors.black12)),
                        child: FutureBuilder(
                          future: avatarUrl,
                          builder: (context, snapshot) {
                            if (snapshot.connectionState == ConnectionState.waiting) {
                              return Center(
                                child: CircularProgressIndicator(),
                              );
                            }
          
                            if (snapshot.hasData) {
                              final url = snapshot.data!;
                              return CircleAvatar(
                                radius: 10,
                                backgroundImage: NetworkImage(url),
                                );
                            }
          
                            return Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.error_outline_rounded),
                                  Text('Add a picture.')
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                      SizedBox(height: 20),
                      Center(
                        child: Text(
                          '${widget.student.toString()}',
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: Colors.black87,
                              fontSize: 24),
                        ),
                      ),
                      Center(
                        child: Text(
                          '${widget.student.email}',
                          style: TextStyle(
                              fontWeight: FontWeight.w400,
                              color: Color.fromARGB(255, 0, 0, 0),
                              fontSize: 18),
                        ),
                      ),
                      Center(
                        child: Container(
                          margin: EdgeInsets.only(bottom: 58),
                          width: MediaQuery.of(context).size.width * 0.2,
                          child: Center(
                            child: Text(
                              "Contact: ${widget.student.contactNumber}",
                              style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  color: Color.fromARGB(255, 0, 0, 0),
                                  fontSize: 18),
                            ),
                          ),
                        ),
                      ),
                      Material(
                        // color: Colors.black12,
                        child: InkWell(
                          splashColor: Colors.black26,
                          onTap: () async {
                            // select an image
                            final image = await FilePicker.platform.pickFiles(
                                type: FileType.custom, allowedExtensions: ['png']);
                            if (image == null) {
                              return;
                            }
          
                            // upload image to supabase
                            final supa = Supabase.instance.client;
          
                            print(
                                "${supa.auth.currentSession!.user.id}/avatar.${image.files.first.extension}");
                            await supa.storage
                                .from('avatars')
                                .uploadBinary(
                                    "${supa.auth.currentSession!.user.id}/avatar.${image.files.first.extension}",
                                    image.files.first.bytes!,
                                    fileOptions: FileOptions(upsert: true))
                                .whenComplete(() {
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                  content: Text("Image uploaded successfully!")));
                              setState(() {
                                avatarUrl = getAvatarUrl();
                              });
                            });
                          },
                          child: Container(
                            color: Color.fromARGB(123, 255, 201, 40),
                            margin:EdgeInsets.fromLTRB(5, 0, 5, 0),
                            height: 40,
                            width: MediaQuery.of(context).size.width * 0.2,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  "Upload Image",
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                      color: const Color.fromARGB(255, 0, 0, 0)),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 6,
                      ),
                      Material(
                        // color: Colors.black12,
                        child: InkWell(
                          splashColor: Colors.black26,
                          onTap: () async {
                            await showDialog<void>(
                                context: context,
                                builder: (context) => buildEditDialog(context));
                          },
                          child: Container(
                            color: Color.fromARGB(123, 255, 201, 40),
                            margin:EdgeInsets.fromLTRB(5, 0, 5, 0),
                            height: 40,
                            width: MediaQuery.of(context).size.width * 0.2,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  "Edit Profile",
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildEditDialog(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white,
      elevation: 4,
      // shape: RoundedRectangleBorder(
      //   borderRadius: BorderRadius.circular(16),
      // ),
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.30,
        height: MediaQuery.of(context).size.height * 0.6,
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Center(
                      child: Text(
                        'Edit Profile',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: Icon(Icons.close_rounded),
                  )
                ],
              ),
              SizedBox(height: 20),
              Expanded(
                child: SingleChildScrollView(
                  child: ProfileForm(student: widget.student),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
