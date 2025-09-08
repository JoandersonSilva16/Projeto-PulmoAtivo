import 'package:flutter/material.dart';
import 'DatabaseMedicamentos.dart';
class Medicamentos extends StatefulWidget {

  @override
  State<Medicamentos> createState() => _MedicamentosState();
}

class _MedicamentosState extends State<Medicamentos> {
  final dbHelper = DatabaseHelper.instance;
  List<Map<String, dynamic>> medicamentos = [];
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadMedicamentos();
  }

  Future<void> _loadMedicamentos() async {
    final meds = await dbHelper.getMedicamentos();
    setState(() {
      medicamentos = meds;
    });
  }

  Future<void> _addMedicamento() async {
    final nome = _controller.text.trim();
    if (nome.isNotEmpty) {
      await dbHelper.addMedicamento(nome);
      _controller.clear();
      await _loadMedicamentos();
    }
  }

  Future<void> _deleteMedicamento(int id) async {
    await dbHelper.deleteMedicamento(id);
    await _loadMedicamentos();
  }

  PreferredSizeWidget buildAppBar() {
    return AppBar(
      backgroundColor: Color(0xFF36b3b8),
      title:  Text(
        "Medicamentos",
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 24,
          color: Colors.white,
        ),
      ),
      centerTitle: true,
      actions: [
        CircleAvatar(
          backgroundColor: Colors.white,
          child: Image.network(
            "https://cdn-icons-png.flaticon.com/512/3135/3135715.png",
            fit: BoxFit.cover,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor:  Color(0xFFe9ffef),
        appBar: buildAppBar(),
        body: Padding(
          padding:  EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextField(
                controller: _controller,
                decoration:  InputDecoration(
                  labelText: 'Nome do medicamento',
                  border: OutlineInputBorder(),
                ),
                onSubmitted: (_) => _addMedicamento(),
              ),
               SizedBox(height: 10),
              ElevatedButton(
                onPressed: _addMedicamento,
                style: ElevatedButton.styleFrom(
                  backgroundColor:  Color(0xFF36b3b8),
                  padding:  EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                ),
                child:  Text(
                  'Adicionar Medicamento',
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
               SizedBox(height: 20),
              Expanded(
                child: medicamentos.isEmpty
                    ?  Center(
                  child: Text(
                    'Nenhum medicamento cadastrado.',
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                )
                    : ListView.builder(
                  itemCount: medicamentos.length,
                  itemBuilder: (context, index) {
                    final med = medicamentos[index];
                    return Card(
                      child: ListTile(
                        title: Text(med['nome']),
                        trailing: IconButton(
                          icon:  Icon(Icons.delete, color: Colors.red),
                          onPressed: () => _deleteMedicamento(med['id']),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
