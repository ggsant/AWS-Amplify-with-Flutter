import 'package:flutter/material.dart';

// GalleryPage simplesmente exibirá imagens; então, ele pode ser implementado como StatelessWidget.
class GalleryPage extends StatelessWidget {
  // Este VoidCallback se conectará ao método shouldLogOut em CameraFlow.
  final VoidCallback shouldLogOut;
  // Este VoidCallback atualizará o sinalizador _shouldShowCamera em CameraFlow.
  final VoidCallback shouldShowCamera;

  GalleryPage({Key key, this.shouldLogOut, this.shouldShowCamera})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(92, 225, 230, 1),
        title: Text('Galeria'),
        actions: [
          // O botão de logout é implementado como uma ação no AppBar e chama shouldLogOut quando tocam nele.
          // Log Out Button
          Padding(
            padding: const EdgeInsets.all(8),
            child: GestureDetector(
              child: Icon(Icons.logout),
              onTap: shouldLogOut,
            ),
          )
        ],
      ),
      // Este FloatingActionButton acionará a câmera para ser mostrada quando pressionado.
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.camera_alt),
        onPressed: shouldShowCamera,
      ),
      body: Container(child: _galleryGrid()),
    );
  }

  Widget _galleryGrid() {
    // Nossas imagens serão exibidas em uma grade com duas colunas. No momento, estamos codificando 3 itens nesta grade.
    return GridView.builder(
        gridDelegate:
            SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemCount: 4,
        itemBuilder: (context, index) {
          // Implementaremos um widget de carregamento de imagem no módulo Adicionar Armazenamento. Até lá, usaremos um espaço reservado para representar imagens.
          return Placeholder();
        });
  }
}
