import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:chat/helpers/mostrar_alerta.dart';
import 'package:chat/services/socket_service.dart';
import 'package:chat/services/auth_service.dart';
import 'package:chat/widgets/custom_imput.dart';
import 'package:chat/widgets/logo.dart';
import 'package:chat/widgets/labels.dart';
import 'package:chat/widgets/boton_azul.dart';

class RegisterPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF2F2F2),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Container(
            height: MediaQuery.of(context).size.height * 0.9,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Logo(titulo: 'Registro'),
                _Form(),
                Labels(ruta: 'login', titulo: 'Ya tienes cuenta?', subTitulo: 'Ingresa Ahora!'),
                Text('Términos y condiciones de uso', style: TextStyle(fontWeight: FontWeight.w200))
              ]
            ),
          ),
        ),
      )
   );
  }
}

class _Form extends StatefulWidget {
  @override
  __FormState createState() => __FormState();
}

class __FormState extends State<_Form> {

  final emailCtrl = TextEditingController();
  final passCtrl = TextEditingController();
  final nameCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {

    final authServise = Provider.of<AuthService>(context);
    final socketService = Provider.of<SocketService>(context);
    
    return Container(
      margin: EdgeInsets.only(top:40),
      padding: EdgeInsets.symmetric(horizontal: 50),
      child: Column(
        children: <Widget>[
          CustomImput(
            icon: Icons.perm_identity,
            placeholder: 'Nombre',
            keyboardType: TextInputType.text,
            textController: nameCtrl,
          ),
          CustomImput(
            icon: Icons.mail_outline,
            placeholder: 'Correo',
            keyboardType: TextInputType.emailAddress,
            textController: emailCtrl,
          ),
          CustomImput(
            icon: Icons.lock_outline,
            placeholder: 'Contrasena',
            textController: passCtrl,
            isPassword: true,
          ),
          BotonAzul(
            text: 'Crear cuenta',
            onPressed: authServise.autenticando ? null : () async {
              print(nameCtrl.text);
              final registroOk = await authServise.register(nameCtrl.text.trim(), emailCtrl.text.trim(), passCtrl.text.trim());
              if (registroOk == true) {
                socketService.connect();
                Navigator.pushReplacementNamed(context, 'usuarios');
              } else {
                mostrarAlerta(context, 'Resgitro incorrecto', registroOk);
              }
            },
          )
        ],
      )
    );
  }
}
