import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:stripe_app/bloc/pagar/pagar_bloc.dart';

class TotalPayButton extends StatelessWidget {
  const TotalPayButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Container(
      width: width,
      height: 100,
      //con esto nos aseguramos que el contenido no se pegue a los bordes
      padding: EdgeInsets.symmetric(horizontal: 15),
      decoration:  BoxDecoration(
        color: Colors.lightBlue.shade900,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        )
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [ 
              Text(
                'Total', 
                style: TextStyle(
                  fontSize: 20, fontWeight: FontWeight.bold, 
                  color: Colors.white
                ),
              ),
              Text('255.55 USD',
                style: TextStyle(
                  fontSize: 20, fontWeight: FontWeight.bold, 
                  color: Colors.white
                ),
              )
            ],
          ),
          _BtnPay()       
        ],
      ),
    );
  }
}

class _BtnPay extends StatelessWidget {
  const _BtnPay({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final pagarBloc = BlocProvider.of<PagarBloc>(context); 
    return pagarBloc.state.tarjetaActiva ? buildBotonTarjeta(context) : buildAppleAndGooglePay(context);
    // return BlocBuilder<PagarBloc,PagarState>(
    //   builder: (context, state) {
    //     return state.tarjetaActiva ? buildBotonTarjeta(context) : buildAppleAndGooglePay(context);  
    //   }
    // );
  }

  Widget buildBotonTarjeta(BuildContext context) {
    return MaterialButton(
      height: 45,
      minWidth: 170,
      shape: const StadiumBorder(),
      elevation: 0,
      color: Colors.white,
      child:Row(
        children: [
          Icon(FontAwesomeIcons.solidCreditCard) ,
          Text('  Pay', style: TextStyle(color:Colors.black,fontSize: 22),)
        ],  
      ),
      onPressed: (){}
    );
  }

  Widget buildAppleAndGooglePay(BuildContext context) {
    return MaterialButton(
      height: 45,
      minWidth: 150,
      shape: const StadiumBorder(),
      elevation: 0,
      color: Colors.white,
      child:Row(
        children: [
          Platform.isAndroid ? Icon(FontAwesomeIcons.google) : Icon(FontAwesomeIcons.applePay),
          Text('  Pay', style: TextStyle(color:Colors.black,fontSize: 22),)
        ],  
      ),
      onPressed: (){}
    );
  }
}