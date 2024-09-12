import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'custom_app_bar.dart';

void main() => runApp(const RadioExampleApp());

class RadioExampleApp extends StatelessWidget {
  const RadioExampleApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: CustomAppBar(
          title: 'Método de Pagamento',
          backgroundColor: Color.fromARGB(255, 217, 70, 119),
        ),
        body: const Center(
          child: RadioExample(),
        ),
      ),
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: Colors.pink,
        ).copyWith(
          secondary: Color(0xFFD155A8),
        ),
      ),
    );
  }
}

enum MetodoDePagamento { credito, pix }

class RadioExample extends StatefulWidget {
  const RadioExample({Key? key});

  @override
  State<RadioExample> createState() => _RadioExampleState();
}

class _RadioExampleState extends State<RadioExample> {
  MetodoDePagamento? _metodo = MetodoDePagamento.credito;

  void _navigateToPixScreen() {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => PixScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ListTile(
          title: const Text('Cartão de Crédito'),
          subtitle: const Text('Pague com Cartão de Crédito. Pagamento confirmado na hora.'),
          leading: Radio<MetodoDePagamento>(
            value: MetodoDePagamento.credito,
            groupValue: _metodo,
            onChanged: (MetodoDePagamento? value) {
              setState(() {
                _metodo = value;
              });
            },
          ),
        ),
        ListTile(
          title: const Text('PIX'),
          subtitle: const Text('Pague com PIX. Pagamento confirmado em até 30 minutos.'),
          leading: Radio<MetodoDePagamento>(
            value: MetodoDePagamento.pix,
            groupValue: _metodo,
            onChanged: (MetodoDePagamento? value) {
              setState(() {
                _metodo = value;
              });
            },
          ),
        ),
        ElevatedButton(
          onPressed: () async {
            if (_metodo == MetodoDePagamento.credito) {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => CredcardScreen()),
              );
            } else if (_metodo == MetodoDePagamento.pix) {
              _navigateToPixScreen();
            }
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Color.fromARGB(255, 217, 70, 119), // Cor de fundo do botão
          ),
          child: Text("Continuar"),
        )
      ],
    );
  }
}

class CredcardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
          title: 'Cartão de Crédito',
          backgroundColor: Color.fromARGB(255, 217, 70, 119),
        ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextFormField(
              decoration: InputDecoration(labelText: 'Nome'),
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'CPF/CNPJ'),
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'Número do Cartão'),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: TextFormField(
                    decoration: InputDecoration(labelText: 'Validade MM/AA'),
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: TextFormField(
                    decoration: InputDecoration(labelText: 'CVV'),
                  ),
                ),
              ],
            ),
            DropdownButtonFormField<int>(
              decoration: InputDecoration(labelText: 'Parcelas'),
              items: [1, 2, 3, 4, 5].map((int value) {
                return DropdownMenuItem<int>(
                  value: value,
                  child: Text('$value parcela(s)'),
                );
              }).toList(),
              onChanged: (int? value) {
                // Handle the selected number of parcels here.
              },
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                _showPaymentSuccessDialog(context);
              },
              style: ElevatedButton.styleFrom(
                primary: Color.fromARGB(255, 217, 70, 119),
              ),
              child: Text("Concluir Pagamento"),
            ),
          ],
        ),
      ),
    );
  }
}

void _showPaymentSuccessDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text("Pagamento bem-sucedido"),
        content: Text("Seu pagamento com cartão de crédito foi realizado com sucesso!"),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text("Fechar"),
          ),
        ],
      );
    },
  );
}

class PixScreen extends StatelessWidget {
  const PixScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
          title: 'Pix',
          backgroundColor: Color.fromARGB(255, 217, 70, 119),
        ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Código PIX',
              style: TextStyle(
                fontSize: 34,
              ),
            ),
            QrImageView(
              data: 'SEU_CODIGO_PIX_AQUI', // Substitua pelo seu código PIX
              version: QrVersions.auto,
              size: 200,
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
