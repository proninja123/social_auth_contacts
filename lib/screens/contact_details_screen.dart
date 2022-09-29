import 'package:flutter/material.dart';
import 'package:socialautologin/utils/colors.dart';

class ContactDetailsScreen extends StatelessWidget {
  const ContactDetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: whiteColor,
        iconTheme: const IconThemeData(
          color: blackColor
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: Container(
                alignment: Alignment.center,
                height: 80,
                width: 80,
                decoration: BoxDecoration(
                  color: Colors.blue.withOpacity(0.2),
                  shape: BoxShape.circle
                ),
                child: const Icon(Icons.account_circle_rounded, size: 70,),
              ),
            ),
             const Padding(
               padding: EdgeInsets.symmetric(vertical: 10),
               child: Text("AMAN", style: TextStyle(
                 color: blackColor,
                 fontWeight: FontWeight.bold,
                 fontSize: 18
                  ),),
             ),
            const SizedBox(height: 20,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Container(
                        height: 50,
                        width: 50,
                        decoration: const BoxDecoration(
                          color: Colors.black12,
                          shape: BoxShape.circle
                        ),
                        child: const Icon(Icons.call),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Text("Call")
                    ],
                  ),
                  Column(
                    children: [
                      Container(
                        height: 50,
                        width: 50,
                        decoration: const BoxDecoration(
                            color: Colors.black12,
                            shape: BoxShape.circle
                        ),
                        child: const Icon(Icons.message),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Text("Message")
                    ],
                  ),
                  Column(
                    children: [
                      Container(
                        height: 50,
                        width: 50,
                        decoration: const BoxDecoration(
                            color: Colors.black12,
                            shape: BoxShape.circle
                        ),
                        child: const Icon(Icons.video_call),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Text("Video")
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20,),
            const Divider(),
            const SizedBox(height: 20,),
            Row(
              children: [
                Expanded(
                  child: Row(
                    children: [
                      Icon(Icons.call),
                      SizedBox(width: 10,),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text("8477857998", style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600
                            ),),
                            Text("Mobile | India")
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.black12.withOpacity(0.1)
                  ),
                  child: const Icon(Icons.message_outlined),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
