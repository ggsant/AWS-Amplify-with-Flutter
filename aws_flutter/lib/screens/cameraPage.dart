import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

import 'package:path/path.dart';

class CameraPage extends StatefulWidget {
  // Para tirar uma foto, precisaremos obter uma instância de CameraDescription que será fornecido pelo CameraFlow.
  final CameraDescription camera;
  // Este ValueChanged fornecerá o CameraFlow com o caminho local para a imagem que é capturada pela câmera.
  final ValueChanged didProvideImagePath;

  CameraPage({Key key, this.camera, this.didProvideImagePath})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  CameraController _controller;
  Future<void> _initializeControllerFuture;

  @override
  void initState() {
    super.initState();
    // Para garantir que tenhamos uma instância do CameraController, precisamos inicializá-lo no método initState e inicializar _initializeControllerFuture quando for concluído.
    _controller = CameraController(widget.camera, ResolutionPreset.medium);
    _initializeControllerFuture = _controller.initialize();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<void>(
        future: _initializeControllerFuture,
        builder: (context, snapshot) {
          // O FutureBuilder observará quando o Futuro reserva e mostrará uma demonstração do que a câmera vê ou um CircularProgressIndicator.
          if (snapshot.connectionState == ConnectionState.done) {
            return CameraPreview(this._controller);
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
      // O FloatingActionButton acionará _takePicture() quando pressionado.
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color.fromRGBO(92, 225, 230, 1),
        child: Icon(
          Icons.control_camera,
        ),
        onPressed: _takePicture,
      ),
    );
  }

  // Este método construirá um caminho temporário para o local da imagem e o transmitirá ao CameraFlow por meio do didProvideImagePath.
  void _takePicture() async {
    try {
      await _initializeControllerFuture;

      final tmpDirectory = await getTemporaryDirectory();
      final filePath = '${DateTime.now().millisecondsSinceEpoch}.png';
      final path = join(tmpDirectory.path, filePath);

      await _controller.takePicture(path);

      widget.didProvideImagePath(path);
    } catch (e) {
      print(e);
    }
  }

  // Finalmente, precisamos garantir o descarte do CameraController após o descarte da página.
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
