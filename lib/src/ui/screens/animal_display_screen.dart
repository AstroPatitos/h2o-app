import "dart:io";

import "package:flutter/material.dart";
import "package:h2o_app/src/ui/components/colors.dart";
import "package:h2o_app/src/ui/screens/map_screen.dart";
import "package:h2o_app/src/ui/widgets/circular_progress.dart";

final List<Map<String, String>> fishData = [
    {"name": "Pargo Rojo:", "description": "Vital para el ecosistema del Golfo, el pargo rojo contribuye a mantener el equilibrio de las poblaciones marinas.","imagen": "https://thumbs.dreamstime.com/b/atlantic-salmon-pink-white-background-red-fishing-river-northern-fish-137435457.jpg"},
    {"name": "Mero Goliath", "description": "Pescado emblemático del Golfo, el mero goliath necesita protección para preservar su rol en el ecosistema.", "imagen": "https://media.istockphoto.com/id/157349709/es/foto/mero-goliath.jpg?s=612x612&w=0&k=20&c=TbmCvzVoEUAekMpsqZ2gY5bYmBrbJ90DowpVmuuBRvQ="},
    {"name": "Tiburón Toro", "description": "Depredador esencial que regula poblaciones, el tiburón toro juega un papel fundamental en la cadena alimentaria.", "imagen": "https://www.kooxdiving.com/wp-content/uploads/2018/09/bullshark1-1024x819.jpg"},
    {"name": "Raya de Aguas Dulces", "description": "Esta especie única del Golfo requiere medidas de conservación para mantener su diversidad.", "imagen": "https://www.google.com/url?sa=i&url=https%3A%2F%2Fes.wikipedia.org%2Fwiki%2FXiphias_gladius&psig=AOvVaw2Hrn6CQYBHiMRfxcBEJWLp&ust=1696872876065000&source=images&cd=vfe&opi=89978449&ved=0CA8QjRxqFwoTCPCkk5r-5oEDFQAAAAAdAAAAABAD"},
    {"name": "Peces Espada", "description": "Importantes para la salud marina, los peces espada necesitan una gestión sostenible para su supervivencia.", "imagen": ""},
  ];

class AnimalDisplayScreen extends StatelessWidget {
  const AnimalDisplayScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Fauna Local"),
      ),
      body: ListView.builder(
        itemCount: fishData.length,
        itemBuilder: (context, index) {
          final fish = fishData[index];
          final fishName = fish["name"];
          final fishDescription = fish["description"];
          final image = fish["imagen"];

          return InkWell(
            onTap: () {
              // Aquí puedes manejar la acción cuando se toque un elemento de la lista
            },
            child: Card(
              margin: EdgeInsets.all(8),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    // Agregar la imagen desde la URL
                    Container(
                      width: 100,
                      height: 130,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: NetworkImage(fish["imagen"]!),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    SizedBox(width: 16), // Espacio entre la imagen y el texto
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            fishName ?? "",
                            style: TextStyle(
                              fontSize: 18, // Tamaño del título
                              fontWeight: FontWeight.bold, // Texto en negrita
                            ),
                          ),
                          Text(
                            fishDescription ?? "",
                            style: TextStyle(
                              fontSize: 16, // Tamaño de la descripción
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
