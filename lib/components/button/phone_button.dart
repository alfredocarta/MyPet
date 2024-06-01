import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class PhoneNumberButton extends StatelessWidget {
  final String phoneNumber;

  const PhoneNumberButton({
    super.key,
    required this.phoneNumber,
  });

  void _launchPhoneCall(String phoneNumber) async {
    String url = 'tel:$phoneNumber';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color.fromARGB(255, 167, 165, 165)),
      ),
      padding: const EdgeInsets.only(left: 15, bottom: 12, top: 12, right: 15),
      margin: const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 0),
      child: InkWell(
        onTap: () => _launchPhoneCall(phoneNumber),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // section name
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Chiama il tuo veterinario',
                    style: TextStyle(
                      color: Colors.grey[800],
                      fontSize: 12,
                    ),
                  ),
                  const Text(
                    '3348343186',
                    style: TextStyle(
                      fontStyle: FontStyle.normal,
                      fontSize: 17,
                      color: Colors.black,
                    ),
                  ),

                ],
              ),

              Icon(
                Icons.call,
                color: Colors.grey[400],
              ),
            ],

          /*mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Icon(Icons.phone),
            const SizedBox(width: 8),
            Text(
              phoneNumber,
              style: const TextStyle(
                fontSize: 17,
              ),
            ),
          ],*/
        ),
      ),
    );
  }
}
