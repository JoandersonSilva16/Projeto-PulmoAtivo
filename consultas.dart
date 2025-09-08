import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'DatabaseConsultas.dart';
class Consultas extends StatefulWidget {
  const Consultas({super.key});
  @override
  State<Consultas> createState() => _ConsultasState();
}
class _ConsultasState extends State<Consultas> {
  int selectedIndex = 0;
  List<Map<String, dynamic>> consultas = [];
  final _dataController = TextEditingController();
  final _nomeController = TextEditingController();
  final _especialidadeController = TextEditingController();
  final _horaController = TextEditingController();
  final dbHelper = DatabaseHelperConsultas.instance;
  @override
  void initState() {
    super.initState();
    _loadConsultas();
  }
  @override
  void dispose() {
    _dataController.dispose();
    _nomeController.dispose();
    _especialidadeController.dispose();
    _horaController.dispose();
    super.dispose();
  }
  Future<void> _loadConsultas() async {
    final data = await dbHelper.getConsultas();
    setState(() {
      consultas = data;
    });
  }
  Future<void> _addConsulta() async {
    final data = _dataController.text.trim();
    final nome = _nomeController.text.trim();
    final especialidade = _especialidadeController.text.trim();
    final hora = _horaController.text.trim();
    if (data.isEmpty || nome.isEmpty || especialidade.isEmpty || hora.isEmpty) {
      ScaffoldMessenger.of(context as BuildContext).showSnackBar(
        SnackBar(content: Text('Preencha todos os campos para adicionar a consulta')),
      );
      return;
    }
    final novaConsulta = {
      'data': data,
      'nome': nome,
      'especialidade': especialidade,
      'hora': hora,
    };
    await dbHelper.addConsulta(novaConsulta);
    _dataController.clear();
    _nomeController.clear();
    _especialidadeController.clear();
    _horaController.clear();
    await _loadConsultas();
  }
  Future<void> _deleteConsulta(int id) async {
    await dbHelper.deleteConsulta(id);
    await _loadConsultas();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF36b3b8),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              'Todas as suas consultas\nem um único lugar\nsempre que precisar.',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    TextField(
                      controller: _dataController,
                      decoration: const InputDecoration(
                        labelText: 'Data (ex: 18 JUL)',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 8),
                    TextField(
                      controller: _nomeController,
                      decoration: const InputDecoration(
                        labelText: 'Nome do paciente',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 8),
                    TextField(
                      controller: _especialidadeController,
                      decoration: const InputDecoration(
                        labelText: 'Especialidade',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 8),
                    TextField(
                      controller: _horaController,
                      decoration: const InputDecoration(
                        labelText: 'Hora (ex: 14:00)',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: _addConsulta,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF15b5b0),
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text(
                        'Adicionar na Sua Lista De Consultas',
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Expanded(
                      child: consultas.isEmpty
                          ? const Center(
                        child: Text(
                          'Nenhuma consulta cadastrada.',
                          style: TextStyle(fontSize: 16, color: Colors.grey),
                        ),
                      )
                          : ListView.builder(
                        itemCount: consultas.length,
                        itemBuilder: (context, index) {
                          final c = consultas[index];
                          return buildConsultaItem(
                            id: c['id'],
                            data: c['data'],
                            nome: c['nome'],
                            especialidade: c['especialidade'],
                            hora: c['hora'],
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedIndex,
        onTap: (index) {
          setState(() {
            selectedIndex = index;
          });
        },
        backgroundColor: const Color(0xFF36b3b8),
        unselectedItemColor: Colors.white,
        selectedItemColor: Colors.white,
        selectedLabelStyle: const TextStyle(fontSize: 10),
        showUnselectedLabels: false,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.medical_services),
            label: "Medicamentos",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.assignment),
            label: 'Consulta',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_month),
            label: 'Agenda',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.support_agent),
            label: 'Ouvidoria',
          ),
        ],
      ),
    );
  }
  Widget buildConsultaItem({
    required int id,
    required String data,
    required String nome,
    required String especialidade,
    required String hora,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.grey.shade100,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                data,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.blueAccent,
                ),
              ),
              const Spacer(),
              Text(
                hora,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              IconButton(
                icon: const Icon(Icons.delete, color: Colors.red),
                onPressed: () => _deleteConsulta(id),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            nome,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            especialidade,
            style: const TextStyle(
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Confirmada',
            style: TextStyle(
              fontSize: 14,
              color: Colors.green,
            ),
          ),
          const SizedBox(height: 8),
          ElevatedButton(
            onPressed: () {
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF15b5b0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: const Text(
              'AGENDAR RETORNO',
              style: TextStyle(color: Colors.white, fontSize: 17),
            ),
          ),
        ],
      ),
    );
  }
}
