import 'package:flutter/material.dart';
import '../../services/notification_service.dart';

class AlarmeScreen extends StatefulWidget {
  const AlarmeScreen({super.key});

  @override
  State<AlarmeScreen> createState() => _AlarmeScreenState();
}

class _AlarmeScreenState extends State<AlarmeScreen> {
  TimeOfDay? selectedTime;
  bool alarmeAtivo = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Alarme de Medicamento')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // 🟦 CARD HORÁRIO
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Colors.blue, Colors.green],
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  const Text(
                    'Horário selecionado',
                    style: TextStyle(color: Colors.white),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    selectedTime == null
                        ? '--:--'
                        : selectedTime!.format(context),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // ⏰ ESCOLHER HORÁRIO
            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                onPressed: () async {
                  final time = await showTimePicker(
                    context: context,
                    initialTime: TimeOfDay.now(),
                  );

                  if (time != null) {
                    setState(() {
                      selectedTime = time;
                    });
                  }
                },
                child: const Text('Selecionar horário'),
              ),
            ),

            const SizedBox(height: 10),

            // 🔔 ATIVAR ALARME
            SwitchListTile(
              title: const Text('Ativar alarme no dispositivo'),
              value: alarmeAtivo,
              onChanged: (value) {
                setState(() {
                  alarmeAtivo = value;
                });
              },
            ),

            const SizedBox(height: 10),

            // 💾 SALVAR
            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                onPressed: () {
                  if (selectedTime != null && alarmeAtivo) {
                    NotificationService.scheduleNotification(
                      hour: selectedTime!.hour,
                      minute: selectedTime!.minute,
                    );

                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Alarme agendado! Pode sair do app 😎'),
                      ),
                    );

                    Navigator.pop(context);
                  }
                },
                child: const Text('Salvar alarme'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
