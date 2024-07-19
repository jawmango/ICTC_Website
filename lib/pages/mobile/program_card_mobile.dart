import 'package:ICTC_Website/models/program.dart';
import 'package:ICTC_Website/widgets/programPage.dart';
import 'package:flutter/material.dart';
import 'package:html_unescape/html_unescape.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ProgramCardMobileWidget extends StatefulWidget {
  const ProgramCardMobileWidget({Key? key, required this.program}) : super(key: key);

  final Program program;

  @override
  State<ProgramCardMobileWidget> createState() => _ProgramCardMobileWidgetState();
}

class _ProgramCardMobileWidgetState extends State<ProgramCardMobileWidget> {
  late Future<String?> programUrl = getProgramUrl();

  Future<String?> getProgramUrl() async {
    try{
      final url = await Supabase.instance.client.storage
        .from('programs')
        .createSignedUrl(
          '${widget.program.id}/program.png',
          60
        );
      return url;
    } catch (e) {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
   return AspectRatio(
    aspectRatio: 1,
     child: Container(
      width: 400,
      height: 500,
      child: Card(
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        color: Colors.white,
        surfaceTintColor: Colors.white,
        elevation: 2,
        child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20),
                Container(
                  margin: EdgeInsets.only(bottom: 20),
                  width: MediaQuery.of(context).size.width * 0.8,
                  height: 280,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.black12)
                  ),
                  child: FutureBuilder(
                    future: programUrl, 
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }
     
                      if (snapshot.hasData) {
                        final url = snapshot.data!;
                        return Image.network(
                          url,
                          fit: BoxFit.contain,
                        );
                      }
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image(image: AssetImage('assets/images/logo_ictc.png'), fit: BoxFit.cover, height: 50, width: 50,),SizedBox(height:20  ,),
                        Text('No image attached.', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w400, color: Colors.black54))
                          ],
                        ),
                      );
                    }
                  ),
                ),
                Text('${widget.program.title}',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600)),
                SizedBox(height: 20),
                Text(
                  '${HtmlUnescape().convert(widget.program.description ?? "No description provided.")}',
                  maxLines: 3,
                  textHeightBehavior: TextHeightBehavior(
                      applyHeightToFirstAscent: true,
                      applyHeightToLastDescent: true),
                ),
                Spacer(),
                SizedBox(height: 20),
                
                Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      FilledButton(
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => ProgramPage(program: widget.program)));
                          // Navigator.of(context).pushNamed(program.route ?? "/home");
                        },  
                        child: Text("Explore Courses",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600)),
                      ),
                    ]),
     
                  //Expanded(child: Placeholder())
                // Padding(
                //   padding: EdgeInsets.only(top: 40),
                //   child: AspectRatio(
                //     aspectRatio: 20 / 10,
                //     child: Image.asset(
                //       'assets/images/program1.png',
                //       fit: BoxFit.fitWidth,
                //     ),
                //   ),
                // ),
              ],
            )),
      ),
       ),
   );
}
}
