import 'package:flutter/material.dart';
import 'package:socialautologin/data/services/authetication_services.dart';
import 'package:socialautologin/utils/country_picker/flutter_country_picker.dart';

class PhoneAuthScreen extends StatefulWidget {
  PhoneAuthScreen({Key? key}) : super(key: key);

  @override
  State<PhoneAuthScreen> createState() => _PhoneAuthScreenState();
}

class _PhoneAuthScreenState extends State<PhoneAuthScreen> {
  String? phoneNumber;

  String? countryCode = "91";

  final phoneNumberController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text('Phone Authentication'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 50),
            child: Container(
                height: 40,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.black, width: 1)),
                child: Row(children: [
                  const SizedBox(
                    width: 8,
                  ),
                  SizedBox(
                    child: CountryPicker(
                      dense: false,
                      showFlag: false,
                      //displays flag, true by default
                      showDialingCode: true,
                      //displays dialing code, false by default
                      showName: false,
                      //displays country name, true by default
                      showCurrency: false,
                      //eg. 'British pound'
                      showCurrencyISO: false,
                      onChanged: (value) {
                        setState(() {
                          countryCode = value.dialingCode;
                        });
                      },
                      selectedCountry: Country.IN,
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 4),
                      child: TextFormField(
                        controller: phoneNumberController,
                        onSaved: (value) {},
                        scrollPadding: EdgeInsets.only(
                            bottom: MediaQuery.of(context).viewInsets.bottom +
                                12 * 4),
                        maxLength: 10,
                        textInputAction: TextInputAction.done,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                            alignLabelWithHint: true,
                            counterText: '',
                            border:
                                OutlineInputBorder(borderSide: BorderSide.none),
                            contentPadding: EdgeInsets.zero,
                            hintText: '000 000 0000',
                            hintStyle: TextStyle(
                                color: Colors.black26,
                                decoration: TextDecoration.none)),
                      ),
                    ),
                  ),
                ])),
          ),
          const SizedBox(
            height: 30,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                  style: ButtonStyle(
                      elevation: MaterialStateProperty.all(0),
                      padding: MaterialStateProperty.all(
                          const EdgeInsets.symmetric(vertical: 15)),
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50))),
                      backgroundColor: MaterialStateProperty.all(
                          Colors.black12 ?? Colors.red)),
                  onPressed: () {
                    AuthenticationServices().signInWithPhoneNumber(
                        context: context,
                        isoCode: countryCode!,
                      phoneNumber: phoneNumberController.text,
                    );
                  },
                  child: const Text(
                    "Get OTP" ?? "",
                    style: TextStyle(
                        color: Colors.black45, fontWeight: FontWeight.w700),
                  )),
            ),
          ),
        ],
      ),
    );
  }
}
