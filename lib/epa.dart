/*import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

const Color darkBlue = Color.fromARGB(255, 18, 32, 47);

// Drop-down de tipo sanguineo
const tipoSanguineoDropDown = [
  DropdownMenuItem<TipoSanguineo>(
    value: TipoSanguineo.aNegativo,
    child: Text("A-"),
  ),
  DropdownMenuItem<TipoSanguineo>(
    value: TipoSanguineo.aPositivo,
    child: Text("A+"),
  ),
  DropdownMenuItem<TipoSanguineo>(
    value: TipoSanguineo.bPositivo,
    child: Text("B+"),
  ),
  DropdownMenuItem<TipoSanguineo>(
    value: TipoSanguineo.bNegativo,
    child: Text("B-"),
  ),
  DropdownMenuItem<TipoSanguineo>(
    value: TipoSanguineo.oPositivo,
    child: Text("O+"),
  ),
  DropdownMenuItem<TipoSanguineo>(
    value: TipoSanguineo.oNegativo,
    child: Text("O-"),
  ),
  DropdownMenuItem<TipoSanguineo>(
    value: TipoSanguineo.abPositivo,
    child: Text("AB+"),
  ),
  DropdownMenuItem<TipoSanguineo>(
    value: TipoSanguineo.abNegativo,
    child: Text("AB-"),
  ),
];

const nomes = <String>[
  "João",
  "Maria",
  "Estevão",
  "Roberto",
  "Antônio",
  "Joana",
  "Gabriel",
  "Jonathan",
  "Felipe",
  "Matheus",
  "Guilherme",
  "Igor",
  "Larissa",
  "Sofia",
  "Eliana"
];

const sobrenomes = <String>[
  "Souza",
  "Soares",
  "Neto",
  "Nascimento",
  "Pires",
  "Santos",
  "Padia",
  "Correa",
  "Schneider",
  "Pereira",
  "Reiter",
  "França"
];

Pessoa novaPessoaAleatoria() {
  final random = Random();
  final nome = nomes[random.nextInt(nomes.length)];
  final sobrenome = sobrenomes[random.nextInt(sobrenomes.length)];
  final telefone =
      "${random.nextInt(9001) + 1000}-${random.nextInt(9001) + 1000}";

  final nomeReduzido = nome.semAcentos.toLowerCase();
  final sobrenomeReduzido = sobrenome.semAcentos.toLowerCase();

  return Pessoa(
      nome: "$nome $sobrenome",
      email: "${nomeReduzido}_"
          "$sobrenomeReduzido@gmail.com",
      telefone: telefone,
      github: "https://github.com/${nome}_$sobrenome",
      tipoSanguineo:
          TipoSanguineo.values[random.nextInt(TipoSanguineo.values.length)]);
}

void main() {
  runApp(ChangeNotifierProvider(
    create: (context) {
      // Gera algumas pessoas aleatoriamente
      final estado = EstadoListaDePessoas();
      for (int i = 0; i < 50; i++) {
        estado.incluir(novaPessoaAleatoria());
      }

      return estado;
    },
    child: const MyApp(),
  ));
}

enum TipoSanguineo {
  aPositivo,
  aNegativo,
  bPositivo,
  bNegativo,
  oPositivo,
  oNegativo,
  abPositivo,
  abNegativo,
}

class Pessoa {
  Pessoa({
    required this.nome,
    required this.email,
    required this.telefone,
    required this.github,
    required this.tipoSanguineo,
  });

  String nome;
  String email;
  String telefone;
  String github;
  TipoSanguineo tipoSanguineo;

  @override
  int get hashCode => Object.hash(nome, email, telefone, github, tipoSanguineo);

  @override
  bool operator ==(Object other) {
    return other is Pessoa &&
        nome == other.nome &&
        email == other.email &&
        telefone == other.telefone &&
        github == other.github &&
        tipoSanguineo == other.tipoSanguineo;
  }

  @override
  String toString() {
    return "Nome: $nome, Email: $email, Telefone: $telefone, GitHub: $github, Tipo Sangue: ${tipoSanguineoToString(tipoSanguineo)}";
  }
}

class EstadoListaDePessoas with ChangeNotifier {
  EstadoListaDePessoas() {
    _pesquisaController.addListener(() {});
  }

  final TextEditingController _pesquisaController = TextEditingController();

  final _listaDePessoas = <Pessoa>[];
  final _listaDePessoasFiltrada = <Pessoa>[];

  List<Pessoa> get pessoas => List.unmodifiable(_listaDePessoas);
  List<Pessoa> get pessoasFiltrada =>
      List.unmodifiable(_listaDePessoasFiltrada);

  void incluir(Pessoa pessoa) {
    _listaDePessoas.add(pessoa);
    notifyListeners();
  }

  void excluir(Pessoa pessoa) {
    _listaDePessoas.remove(pessoa);
    notifyListeners();
  }

  String? editar(Pessoa pessoa,
      {String? nome,
      String? email,
      String? telefone,
      String? github,
      TipoSanguineo? tipoSanguineo}) {
    // Verifica se a pessoa existe na lista
    final index = _listaDePessoas.indexOf(pessoa);
    if (index == -1) {
      return "Pessoa não consta na lista";
    }

    // Atualiza campos se houve mudança
    bool atualizou = false;
    if (nome != null && _listaDePessoas[index].nome != nome) {
      _listaDePessoas[index].nome = nome;
      atualizou = true;
    }
    if (email != null && _listaDePessoas[index].email != email) {
      _listaDePessoas[index].email = email;
      atualizou = true;
    }
    if (telefone != null && _listaDePessoas[index].telefone != telefone) {
      _listaDePessoas[index].telefone = telefone;
      atualizou = true;
    }
    if (github != null && _listaDePessoas[index].github != github) {
      _listaDePessoas[index].github = github;
      atualizou = true;
    }
    if (tipoSanguineo != null &&
        _listaDePessoas[index].tipoSanguineo != tipoSanguineo) {
      _listaDePessoas[index].tipoSanguineo = tipoSanguineo;
      atualizou = true;
    }

    if (atualizou) {
      // Notifica mudanças para modificar as informações na tela de listagem
      notifyListeners();
      return null;
    }

    // Se não houve mudança, não fazer nada
    return "Não houve mudanças nas informações da pessoa";
  }

  List<Pessoa> filtrarPor(FilterType tipoFiltro, dynamic pesquisa) {
    final listaFiltrada = <Pessoa>[];

    // Checar se a pesquisa é válida de acordo com o tipo de filtro
    if ((tipoFiltro == FilterType.tipoSanguineo &&
            pesquisa is! TipoSanguineo) ||
        (tipoFiltro != FilterType.tipoSanguineo && pesquisa is! String)) {
      return listaFiltrada;
    }

    // Se for uma pesquisa vazia, retorna a lista inteira
    if (pesquisa == null || pesquisa == "") {
      return pessoas;
    }

    // Pesquisa melhorada para melhores resultados
    dynamic pesquisaMelhorada = tipoFiltro == FilterType.tipoSanguineo
        ? pesquisa as TipoSanguineo
        : (pesquisa as String).semAcentos.toLowerCase();

    for (final pessoa in _listaDePessoas) {
      switch (tipoFiltro) {
        case FilterType.nome:
          // Verifica se o nome contém a pesquisa
          if (pessoa.nome.semAcentos
              .toLowerCase()
              .contains(pesquisaMelhorada)) {
            listaFiltrada.add(pessoa);
          }
          break;
        case FilterType.email:
          // Verifica se o email contém a pesquisa
          if (pessoa.email.semAcentos
              .toLowerCase()
              .contains(pesquisaMelhorada)) {
            listaFiltrada.add(pessoa);
          }
          break;
        case FilterType.telefone:
          // Verifica se o telefone contém a pesquisa
          if (pessoa.telefone.semAcentos
              .toLowerCase()
              .contains(pesquisaMelhorada)) {
            listaFiltrada.add(pessoa);
          }
          break;
        case FilterType.github:
          // Verifica se o github contém a pesquisa
          if (pessoa.github.semAcentos
              .toLowerCase()
              .contains(pesquisaMelhorada)) {
            listaFiltrada.add(pessoa);
          }
          break;
        case FilterType.tipoSanguineo:
          // Verifica se o tipo sanguineo é o mesmo
          if (pessoa.tipoSanguineo == pesquisaMelhorada) {
            listaFiltrada.add(pessoa);
          }
          break;
      }
    }

    return List.unmodifiable(listaFiltrada);
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: darkBlue,
      ),
      debugShowCheckedModeBanner: false,
      routes: {
        "/": (context) => const InitialPage(),
        "/list": (context) => const PeopleListingPage(),
        "/create": (context) => const CreatePersonPage(),
        "/edit": (context) => EditPersonPage(
            person: ModalRoute.of(context)!.settings.arguments as Pessoa),
      },
    );
  }
}

class InitialPage extends StatelessWidget {
  const InitialPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Gerenciador de pessoas")),

      // Botão de incluir pessoa
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green,
        elevation: 5,
        onPressed: () {
          Navigator.of(context).pushNamed("/create");
        },
        child: const Icon(Icons.add, size: 35, color: Colors.white),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Icon(Icons.person, size: 100),
            const Text(
              "Aplicativo de gerenciamento de pessoas",
              style: TextStyle(fontSize: 17),
            ),
            ElevatedButton.icon(
              label: const Text("Listar"),
              icon: const Icon(Icons.list),
              onPressed: () => Navigator.of(context).pushNamed("/list"),
            )
          ],
        ),
      ),
    );
  }
}

class PeopleListingPage extends StatefulWidget {
  const PeopleListingPage({super.key});

  @override
  State<PeopleListingPage> createState() => _PeopleListingPageState();
}

class _PeopleListingPageState extends State<PeopleListingPage> {
  FilterType tipoFiltro = FilterType.nome;
  dynamic pesquisa = "";

  final TextEditingController pesquisaController = TextEditingController();

  @override
  void initState() {
    super.initState();
    pesquisaController.addListener(() {
      setState(() {
        pesquisa = pesquisaController.text;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    pesquisaController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<EstadoListaDePessoas>(
      builder: (context, listaPessoas, child) => Scaffold(
        appBar: AppBar(title: const Text("Listagem de pessoas")),

        // Botão de incluir pessoa
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.green,
          elevation: 5,
          onPressed: () {
            Navigator.of(context).pushNamed("/create");
          },
          child: const Icon(Icons.add, size: 35, color: Colors.white),
        ),

        body: Column(
          children: [
            // Linha contendo tipo de filtro
            Row(
              children: [
                // Texto
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text("Filtrar por:", style: TextStyle(fontSize: 17)),
                ),

                // Tipo de filtro
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15.0, vertical: 8),
                    child: DropdownButton<FilterType>(
                      isExpanded: true,
                      value: tipoFiltro,
                      hint: const Text("Filtrar por:"),
                      elevation: 6,
                      onChanged: (FilterType? value) {
                        setState(() {
                          // Se tava filtrando por tipoSanguineo, muda para
                          // pesquisa vazia
                          if (tipoFiltro == FilterType.tipoSanguineo) {
                            pesquisa = "";
                          }
                          tipoFiltro = value!;
                        });
                      },
                      items: const [
                        DropdownMenuItem<FilterType>(
                          value: FilterType.nome,
                          child: Text("Nome"),
                        ),
                        DropdownMenuItem<FilterType>(
                          value: FilterType.email,
                          child: Text("Email"),
                        ),
                        DropdownMenuItem<FilterType>(
                          value: FilterType.telefone,
                          child: Text("Telefone"),
                        ),
                        DropdownMenuItem<FilterType>(
                          value: FilterType.github,
                          child: Text("GitHub"),
                        ),
                        DropdownMenuItem<FilterType>(
                          value: FilterType.tipoSanguineo,
                          child: Text("Tipo Sanguíneo"),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            // Menu de busca
            if (tipoFiltro == FilterType.tipoSanguineo)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: DropdownButton<TipoSanguineo>(
                  value: pesquisa is TipoSanguineo ? pesquisa : null,
                  isExpanded: true,
                  hint: const Text("Tipo Sanguíneo"),
                  elevation: 6,
                  onChanged: (TipoSanguineo? value) {
                    setState(() {
                      pesquisa = value!;
                    });
                  },
                  items: tipoSanguineoDropDown,
                ),
              )
            else
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: pesquisaController,
                  // onChanged: (String value) {},
                  decoration: InputDecoration(
                      labelText: "Pesquisa",
                      hintText: "Pesquisa",
                      prefixIcon: const Icon(Icons.search),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25))),
                ),
              ),

            // Listagem das pessoas
            Expanded(
              child: ListView.builder(
                itemCount: listaPessoas.filtrarPor(tipoFiltro, pesquisa).length,
                itemBuilder: (context, index) {
                  // Objeto pessoa
                  final pessoa =
                      listaPessoas.filtrarPor(tipoFiltro, pesquisa)[index];

                  // Cor do tipo sanguineo
                  final corTipoSanguineo =
                      tipoSanguineoToColor(pessoa.tipoSanguineo);

                  return ListTile(
                    minVerticalPadding: 15,

                    // Informações
                    title: Text(pessoa.nome),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          pessoa.email,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          pessoa.telefone,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          pessoa.github,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ]
                          .map((widget) => Padding(
                              padding: const EdgeInsets.symmetric(vertical: 3),
                              child: widget))
                          .toList(),
                    ),

                    // Tipo sanguíneo
                    leading: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: corTipoSanguineo,
                      ),
                      child: Center(
                        child: Text(
                          tipoSanguineoToString(pessoa.tipoSanguineo),
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: corTipoSanguineo.computeLuminance() > .5
                                ? Colors.black
                                : Colors.white,
                          ),
                        ),
                      ),
                    ),

                    // Menu de ações
                    trailing: PersonPopupButton(
                      person: pessoa,
                      onRemove: () => listaPessoas.excluir(pessoa),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CreatePersonPage extends StatelessWidget {
  const CreatePersonPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(title: const Text("Adicionar nova pessoa")),
      body: const Center(child: PersonForm()),
    );
  }
}

class EditPersonPage extends StatelessWidget {
  const EditPersonPage({required this.person, super.key});

  final Pessoa person;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(title: const Text("Editar pessoa")),
      body: Center(child: PersonForm(person: person)),
    );
  }
}

// Formulário que serve tanto para criar nova pessoa ou editar existente
class PersonForm extends StatefulWidget {
  const PersonForm({this.person, super.key});

  // Pessoa a ser editada
  final Pessoa? person;

  @override
  State<PersonForm> createState() => _PersonFormState();
}

class _PersonFormState extends State<PersonForm> {
  // Chave do formulario
  final _formKey = GlobalKey<FormState>();

  // Novas informações
  late String nome, email, telefone, github;
  late TipoSanguineo? tipoSanguineo;

  @override
  void initState() {
    super.initState();

    // Inicia novas informações com os dados atuais da pessoa
    nome = widget.person?.nome ?? "";
    email = widget.person?.email ?? "";
    telefone = widget.person?.telefone ?? "";
    github = widget.person?.github ?? "";
    tipoSanguineo = widget.person?.tipoSanguineo;
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Campo nome
            TextFormField(
              initialValue: nome,
              onChanged: (value) => nome = value,
              decoration: const InputDecoration(
                labelText: "Nome",
              ),
              validator: (String? value) {
                if (value == null ||
                    value.length < 3 ||
                    value[0].toUpperCase() != value[0]) {
                  return "Precisa ter ao menos 3 letras, sendo a primeira maiúscula";
                }

                return null;
              },
            ),

            // Campo email
            TextFormField(
              initialValue: email,
              onChanged: (value) => email = value,
              decoration: const InputDecoration(
                labelText: "Email",
              ),
              validator: (String? value) {
                if (value == null || !emailRegex.hasMatch(value)) {
                  return "Precisa ser um email válido";
                }

                return null;
              },
            ),

            // Campo telefone
            TextFormField(
              initialValue: telefone,
              onChanged: (value) => telefone = value,
              decoration: const InputDecoration(
                labelText: "Telefone",
              ),
              validator: (String? value) {
                if (value == null || value.length != 9) {
                  return "Precisa ser um número no formato xxxx-xxxx";
                }

                // Verifica se é válido
                for (int i = 0; i < 4; i++) {
                  if (int.tryParse(value[i]) == null) {
                    return "Precisa ser um número no formato xxxx-xxxx";
                  }
                }
                for (int i = 5; i < 9; i++) {
                  if (int.tryParse(value[i]) == null) {
                    return "Precisa ser um número no formato xxxx-xxxx";
                  }
                }

                return null;
              },
            ),

            // Campo github
            TextFormField(
              initialValue: github,
              onChanged: (value) => github = value,
              decoration: const InputDecoration(
                labelText: "GitHub",
              ),
              validator: (String? value) {
                if (value == null || value == "") {
                  return "Precisa um nome/link váido do GitHub";
                }

                return null;
              },
            ),

            // Campo tipo sanguineo
            DropdownButtonFormField<TipoSanguineo>(
                validator: (tipo) =>
                    tipo == null ? "Selecione o tipo sanguíneo" : null,
                onChanged: (TipoSanguineo? value) => setState(() {
                      tipoSanguineo = value;
                    }),
                isExpanded: true,
                value: tipoSanguineo,
                items: tipoSanguineoDropDown),

            // Botão de enviar
            Padding(
              padding: const EdgeInsets.only(top: 25.0),
              child: ElevatedButton(
                onPressed: () {
                  if (!_formKey.currentState!.validate()) return;

                  // Se o campo person não é null, então é para editar
                  String? resultado;
                  if (widget.person != null) {
                    // Envia informações para editar
                    resultado = Provider.of<EstadoListaDePessoas>(context,
                            listen: false)
                        .editar(
                      widget.person!,
                      nome: nome,
                      email: email,
                      telefone: telefone,
                      github: github,
                      tipoSanguineo: tipoSanguineo,
                    );
                  } else {
                    // Envia informações para incluir
                    Provider.of<EstadoListaDePessoas>(context, listen: false)
                        .incluir(Pessoa(
                      nome: nome,
                      email: email,
                      telefone: telefone,
                      github: github,
                      tipoSanguineo: tipoSanguineo!,
                    ));
                  }

                  // Botão de ok
                  Widget okButton = TextButton(
                    onPressed: () {
                      // Primeiro pop para sair da tela de diálogo
                      Navigator.of(context).pop();

                      // Segundo pop para voltar à página de listagem
                      Navigator.of(context).pop();
                    },
                    child: const Text("Ok"),
                  );

                  // Texto da caixa de diálogo
                  late String dialogText;
                  if (widget.person != null) {
                    // Tela de edição
                    dialogText = resultado ??
                        "As informações da pessoa "
                            "foram atualizados com sucesso!";
                  } else {
                    // Tela de criação
                    dialogText = "Pessoa incluída com sucesso!";
                  }

                  // Informa ao usuário que foi atualizado
                  showDialog(
                    useRootNavigator: false,
                    context: context,
                    builder: (context) => AlertDialog(
                      title: Text(resultado == null ? "Sucesso" : "Erro"),
                      content: Text(dialogText),
                      actions: [okButton],
                    ),
                  );
                },
                child: Text(widget.person != null ? 'Editar' : 'Incluir'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PersonPopupButton extends StatelessWidget {
  const PersonPopupButton(
      {required this.onRemove, required this.person, super.key});

  final void Function() onRemove;
  final Pessoa person;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      // O widget PopupMenuButton faz um Navigator.pop() automático quando
      // um valor é selecionado, então pra poder chamar outra rota é preciso
      // usar o onSelected, que ocorre após o Navigator.pop() do PopupMenuButton
      onSelected: (result) {
        if (result == "Edit") {
          Navigator.of(context).pushNamed("/edit", arguments: person);
        }
      },
      tooltip: "Opções",
      itemBuilder: (context) {
        return [
          const PopupMenuItem<String>(
            value: "Edit",
            child: Row(
              children: [
                Icon(Icons.edit, color: Colors.blue),
                Padding(
                  padding: EdgeInsets.only(left: 8.0),
                  child: Text("Editar"),
                ),
              ],
            ),
          ),
          PopupMenuItem<String>(
            value: "Remove",
            onTap: onRemove,
            child: const Row(
              children: [
                Icon(
                  Icons.delete,
                  color: Colors.red,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 8.0),
                  child: Text("Remover"),
                )
              ],
            ),
          )
        ];
      },
    );
  }
}

enum FilterType { nome, email, telefone, github, tipoSanguineo }

// Função para remover acentos
// https://stackoverflow.com/questions/30844353/how-to-remove-diacritics-accents-from-a-string
extension RemoverAcentos on String {
  static const acentos =
      'ÀÁÂÃÄÅàáâãäåÒÓÔÕÕÖØòóôõöøÈÉÊËèéêëðÇçÐÌÍÎÏìíîïÙÚÛÜùúûüÑñŠšŸÿýŽž';
  static const naoAcentos =
      'AAAAAAaaaaaaOOOOOOOooooooEEEEeeeeeCcDIIIIiiiiUUUUuuuuNnSsYyyZz';

  String get semAcentos {
    String str = this;
    for (int i = 0; i < acentos.length; i++) {
      str = str.replaceAll(acentos[i], naoAcentos[i]);
    }

    return str;
  }
}
*/