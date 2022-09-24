part of 'helpers.dart';

mostrarLoading(BuildContext context){
  showDialog(
    context: context,
    barrierDismissible: false, 
    builder: (_) => AlertDialog(
      title: Text("Espere..."),
      content: LinearProgressIndicator(),
    ),
  );
}

mostrarAlert(BuildContext context, String titulo, String mensaje){
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (_) => AlertDialog(
      title: Text(titulo),
      content: Text(mensaje),
      actions: [
        MaterialButton(
          child: Text("ok"),
          onPressed: (){
            Navigator.of(context).pop();
          }
        )
      ],
    )
  );
}