import 'package:chat/models/auth_form_data.dart';
import 'package:flutter/material.dart';

class AuthForm extends StatefulWidget {
  const AuthForm({ Key? key }) : super(key: key);

  @override
  _AuthFormState createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formKey = GlobalKey<FormState>();
  final _formData = AuthFormData();

  void _submmit(){
    final isValid = _formKey.currentState?.validate() ?? false;

    if (!isValid)
      return;

  }
  
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(20),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          child: Column(
            children: [
              if ( _formData.isSignup)
                TextFormField(
                  key: ValueKey('name'),
                  initialValue: _formData.name,
                  onChanged: (name)=> _formData.name = name,
                  decoration: InputDecoration(labelText: 'Nome'),
                  validator: (_name){
                    final name = _name ?? '';
                    if (name.trim().length < 5){
                      return 'Nome deve ter no minimo 5 caracteres.';
                    }
                    return null;
                  },
                ),
              TextFormField(
                key: ValueKey('email'),
                initialValue: _formData.email,
                onChanged: (email)=> _formData.email = email,
                decoration: InputDecoration(labelText: 'E-mail'),
                validator: (_email){
                    final email = _email ?? '';
                    if (!email.contains('@')){
                      return 'Email inválido.';
                    }
                    return null;
                  },
              ),
              TextFormField(
                key: ValueKey('password'),
                initialValue: _formData.password,
                onChanged: (password)=> _formData.password = password,
                obscureText: true,
                decoration: InputDecoration(labelText: 'Senha'),
                validator: (_password){
                    final password = _password ?? '';
                    if (password.length < 6){
                      return 'Senha deve ter no minimo 6 caracteres.';
                    }
                    return null;
                  }
              ),
              SizedBox(height: 12),
              ElevatedButton(
                child: Text(
                  _formData.isLogin 
                  ? 'Entrar'
                  : 'Criar Conta'
                ),
                onPressed: _submmit
              ),
              SizedBox(height: 12),
              TextButton(
                child: Text(
                  _formData.isLogin 
                  ? 'Criar uma nova conta?'
                  : 'Já possui conta?'
                ),
                onPressed: (){
                  setState(() {
                    _formData.toggleAuthMode();
                  });
                }
              ),
            ],
          ),
        ),
      ),
    );
  }
}