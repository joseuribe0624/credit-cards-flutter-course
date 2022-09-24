import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_credit_card/credit_card_widget.dart';
import 'package:stripe_app/bloc/pagar/pagar_bloc.dart';
import 'package:stripe_app/data/tarjetas.dart';
import 'package:stripe_app/helpers/helpers.dart';
import 'package:stripe_app/pages/tarjeta_page.dart';
import 'package:stripe_app/widgets/total_pay_button.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //me ayuda a saber la dimension de ancho y alto de mi pantalla
    final size = MediaQuery.of(context).size;
    final pagarBloc = BlocProvider.of<PagarBloc>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('pagar'),
        actions: [
          IconButton(
            onPressed: () async{
              mostrarLoading(context);
              await Future.delayed(Duration(seconds:1));
              Navigator.pop(context);
            }, 
            icon:const Icon(Icons.add)
          )
        ],
      ),
      body: Stack(
        children: [
          Positioned(
            height: size.height,
            width: size.width,
            top:200,
            child: PageView.builder(
              controller: PageController(
                viewportFraction: 0.9
              ),
              physics: const BouncingScrollPhysics(),
              itemCount: tarjetas.length,
              itemBuilder: (context, index) {
                final tarjeta = tarjetas[index];
                return GestureDetector(
                  onTap: (){
                    pagarBloc.add(OnSeleccionarTarjeta(tarjeta));
                    Navigator.push(context, navegarFadein(context, const TarjetaPage()));
                  },
                  child: Hero(
                    tag: tarjeta.cardNumber,
                    child: CreditCardWidget(
                      cardNumber: tarjeta.cardNumberHidden, 
                      expiryDate: tarjeta.expiracyDate, 
                      cardHolderName: tarjeta.cardHolderName, 
                      cvvCode: tarjeta.cvv, 
                      showBackView: false, 
                      onCreditCardWidgetChange: (CreditCardBrand ) {  },
                    ),
                  ),
                );
              },
            ),
          ),
          Positioned(
            bottom: 0,
            child:TotalPayButton(),

          )
        ],
      ),
    );
  }
}