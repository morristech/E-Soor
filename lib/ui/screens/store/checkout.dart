import 'package:flutter/material.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';
import 'package:flutter_credit_card/credit_card_model.dart';
import 'package:flutter_credit_card/credit_card_form.dart';

class CheckOutPage extends StatefulWidget {
  @override
  _CheckOutPageState createState() => _CheckOutPageState();
}

class _CheckOutPageState extends State<CheckOutPage> {
  String cardNumber = '';
  String expiryDate = '';
  String cardHolderName = '';
  String cvvCode = '';
  bool isCvvFocused = false;
 void onCreditCardModelChange(CreditCardModel creditCardModel){
  setState(() {
      cardNumber = creditCardModel.cardNumber;
      expiryDate = creditCardModel.expiryDate;
      cardHolderName = creditCardModel.cardHolderName;
      cvvCode = creditCardModel.cvvCode;
      isCvvFocused = creditCardModel.isCvvFocused;
  });  
 }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        appBar: AppBar(),
        resizeToAvoidBottomInset: true,
        body: SafeArea(
          child: Column(
            children: <Widget>[
              CreditCardWidget(
                cardNumber: cardNumber,
                expiryDate: expiryDate,
                cardHolderName: cardHolderName,
                cvvCode: cvvCode,
                showBackView: isCvvFocused,
                cardBgColor: Colors.black,
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: CreditCardForm(
                    cursorColor: Colors.white,
                    themeColor: Colors.white,
                    textColor: Colors.white,
                    onCreditCardModelChange: onCreditCardModelChange,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

