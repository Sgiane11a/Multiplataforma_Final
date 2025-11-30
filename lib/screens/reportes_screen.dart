import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../database/database_helper.dart';

class ReportesScreen extends StatefulWidget {
  const ReportesScreen({Key? key}) : super(key: key);

  @override
  State<ReportesScreen> createState() => _ReportesScreenState();
}

class _ReportesScreenState extends State<ReportesScreen> {
  late Future<Map<String, dynamic>> _estadisticasF;
  final _db = DatabaseHelper();

  @override
  void initState() {
    super.initState();
    _cargarDatos();
  }

  void _cargarDatos() {
    _estadisticasF = _db.obtenerEstadisticas();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final _moneda = NumberFormat.currency(symbol: '\$', decimalDigits: 2);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Reportes y Estadísticas'),
        backgroundColor: Colors.teal.shade700,
        elevation: 0,
      ),
      body: FutureBuilder<Map<String, dynamic>>(
        future: _estadisticasF,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          final data = snapshot.data ?? {};
          final totalProductos = data['totalProductos'] as int? ?? 0;
          final totalCategorias = data['totalCategorias'] as int? ?? 0;
          final totalMovimientos = data['totalMovimientos'] as int? ?? 0;
          final valorInventario = data['valorInventario'] as double? ?? 0.0;

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Resumen del Inventario',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 24),
                // Tarjetas de estadísticas
                GridView.count(
                  crossAxisCount: 2,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 16,
                  childAspectRatio: 1.2,
                  children: [
                    _buildStatCard(
                      icon: Icons.inventory_2,
                      color: Colors.blue,
                      title: 'Productos',
                      valor: totalProductos.toString(),
                    ),
                    _buildStatCard(
                      icon: Icons.category,
                      color: Colors.purple,
                      title: 'Categorías',
                      valor: totalCategorias.toString(),
                    ),
                    _buildStatCard(
                      icon: Icons.history,
                      color: Colors.orange,
                      title: 'Movimientos',
                      valor: totalMovimientos.toString(),
                    ),
                    _buildStatCard(
                      icon: Icons.attach_money,
                      color: Colors.green,
                      title: 'Valor Total',
                      valor: _moneda.format(valorInventario),
                      fontSize: 16,
                    ),
                  ],
                ),
                const SizedBox(height: 32),
                // Información detallada
                Card(
                  elevation: 4,
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Detalles',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 16),
                        _buildDetailRow(
                          'Total de Productos',
                          totalProductos.toString(),
                          Colors.blue,
                        ),
                        _buildDetailRow(
                          'Total de Categorías',
                          totalCategorias.toString(),
                          Colors.purple,
                        ),
                        _buildDetailRow(
                          'Total de Movimientos',
                          totalMovimientos.toString(),
                          Colors.orange,
                        ),
                        _buildDetailRow(
                          'Valor del Inventario',
                          _moneda.format(valorInventario),
                          Colors.green,
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                // Botón de actualizar
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: _cargarDatos,
                    icon: const Icon(Icons.refresh),
                    label: const Text('Actualizar Datos'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.teal.shade700,
                      padding: const EdgeInsets.all(16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildStatCard({
    required IconData icon,
    required MaterialColor color,
    required String title,
    required String valor,
    double fontSize = 20,
  }) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          gradient: LinearGradient(
            colors: [color.shade100, color.shade50],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 40, color: color.shade700),
              const SizedBox(height: 12),
              Text(
                title,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey.shade700,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                valor,
                style: TextStyle(
                  fontSize: fontSize,
                  fontWeight: FontWeight.bold,
                  color: color.shade700,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String valor, MaterialColor color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(fontSize: 14, color: Colors.grey)),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: color.shade100,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              valor,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: color.shade700,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
