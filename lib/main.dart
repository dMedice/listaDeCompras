import 'package:flutter/material.dart';

void main() {
  runApp(AppCrud());
}

class Produto {
  String nome;
  String preco;

  Produto({required this.nome, required this.preco});
}

class AppCrud extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lista de Compras',
      theme: ThemeData(primarySwatch: Colors.purple),
      home: LoginPage(),
    );
  }
}

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('Login'),
      // ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                // Adiciona a imagem do logo
                Image.asset(
                  'images/logo.png',
                  height: 244, // Ajuste conforme necessário
                  width: 275, // Ajuste conforme necessário
                ),

                // Adiciona a segunda imagem acima do logo
              ],
            ),
            SizedBox(height: 20),
            TextField(
              controller: _usernameController,
              decoration: InputDecoration(labelText: 'Usuário'),
            ),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(labelText: 'Senha'),
              obscureText: true,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Verificar credenciais
                if (_usernameController.text == 'Vevete' &&
                    _passwordController.text == 'trocar123') {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => StudentListPage()),
                  );
                } else {
                  // Exibir mensagem de erro
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Credenciais inválidas')),
                  );
                }
              },
              child: Text('Login'),
            ),
          ],
        ),
      ),
    );
  }
}

class StudentListPage extends StatefulWidget {
  @override
  _StudentListPageState createState() => _StudentListPageState();
}

class _StudentListPageState extends State<StudentListPage> {
  // Lista de alunos (simulando um banco de dados)
  List<Produto> students = [
    Produto(nome: 'Morango', preco: '9,00'),
    Produto(nome: 'Abacaxi', preco: '30,00'),
    Produto(nome: 'Suco de Maçã', preco: '12,00'),
    Produto(nome: 'Milho', preco: '15,50'),
    Produto(nome: 'AirFryer', preco: '150,00'),
    Produto(nome: 'Cone do Tio Sam', preco: '5,00'),
    Produto(nome: 'Presunto', preco: '21,32'),
    Produto(nome: 'Oléo de Soja', preco: '2,00'),
    Produto(nome: 'Danoninho Dino', preco: '12,30'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista'),
      ),
      body: ListView.builder(
        itemCount: students.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(students[index].nome),
            subtitle: Text(students[index].preco),
            trailing: IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {
                // Excluir aluno
                students.removeAt(index);
                // Atualizar a interface
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Produto removido')),
                );
                // Atualizar a lista de alunos
                setState(() {});
              },
            ),
            onTap: () async {
              // Editar o aluno
              Produto updatedStudent = await showDialog(
                context: context,
                builder: (context) {
                  TextEditingController _nomeController =
                      TextEditingController(text: students[index].nome);
                  TextEditingController _emailController =
                      TextEditingController(text: students[index].preco);
                  return AlertDialog(
                    title: Text('Editar'),
                    content: Column(
                      children: [
                        TextField(
                          controller: _nomeController,
                          decoration: InputDecoration(labelText: 'Nome'),
                        ),
                        TextField(
                          controller: _emailController,
                          decoration: InputDecoration(labelText: 'Preço'),
                        ),
                      ],
                    ),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text('Cancelar'),
                      ),
                      TextButton(
                        onPressed: () {
                          // Validar e salvar as alterações
                          if (_nomeController.text.isNotEmpty &&
                              _emailController.text.isNotEmpty) {
                            Navigator.pop(
                              context,
                              Produto(
                                nome: _nomeController.text.trim(),
                                preco: _emailController.text.trim(),
                              ),
                            );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                  content: Text(
                                      'Preencha todos os campos corretamente')),
                            );
                          }
                        },
                        child: Text('Salvar'),
                      ),
                    ],
                  );
                },
              );

              if (updatedStudent != null) {
                // Atualizar o aluno na lista
                students[index] = updatedStudent;
                // Atualizar a interface
                setState(() {});
              }
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          // Adicionar novo produto
          Produto newStudent = await showDialog(
            context: context,
            builder: (context) {
              TextEditingController _nomeController = TextEditingController();
              TextEditingController _emailController = TextEditingController();

              // Adicionar novo produto
              return AlertDialog(
                title: Text('Novo Produto'),
                content: Column(
                  children: [
                    TextField(
                      controller: _nomeController,
                      decoration: InputDecoration(labelText: 'Nome'),
                    ),
                    TextField(
                      controller: _emailController,
                      decoration: InputDecoration(labelText: 'Preço'),
                    ),
                  ],
                ),
                // Cancelar operação
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text('Cancelar'),
                  ),
                  // Validar e adicionar o novo produto
                  TextButton(
                    onPressed: () {
                      if (_nomeController.text.isNotEmpty &&
                          _emailController.text.isNotEmpty) {
                        Navigator.pop(
                          context,
                          Produto(
                            nome: _nomeController.text.trim(),
                            preco: _emailController.text.trim(),
                          ),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                              content: Text(
                                  'Preencha todos os campos corretamente')),
                        );
                      }
                    },
                    child: Text('Adicionar'),
                  ),
                ],
              );
            },
          );
          // Verificar espaço a ser alocado para a adição do novo produto
          if (newStudent != null) {
            // Adicionar o novo produto à lista
            students.add(newStudent);

            // Atualizar a tela
            setState(() {});
          }
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
