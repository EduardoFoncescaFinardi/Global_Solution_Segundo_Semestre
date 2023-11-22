#fazer a instalação das bibliotecas abaixo

from flask import Flask, render_template, request
from keras.models import load_model
import cv2
import numpy as np
import base64
import os

app = Flask(__name__)

# Obter o diretório do script atual
script_dir = os.path.dirname(os.path.abspath(__file__))

# Construir o caminho para o modelo Keras
model_path = os.path.join(script_dir, "keras_model.h5")

# Carregar modelo Keras
model = load_model(model_path, compile=False)

# Carregar as labels
labels_path = os.path.join(script_dir, "labels.txt")
class_names = open(labels_path, "r").readlines()

@app.route('/', methods=['GET', 'POST'])
def upload_file():
    predicted_class = None
    confidence_score = None
    encoded_image = None

    if request.method == 'POST':
        if 'file' not in request.files:
            return render_template('basico.html', message='Arquivo nao selecionado')

        file = request.files['file']

        if file.filename == '':
            return render_template('basico.html', message='Arquivo nao selecionado')

        try:
            # Converter a imagem em base64 para exibição no HTML
            encoded_image = base64.b64encode(file.read()).decode('utf-8')

            # Realizar a previsão usando o modelo Keras
            image = cv2.imdecode(np.fromstring(base64.b64decode(encoded_image), dtype=np.uint8), cv2.IMREAD_COLOR)

            # Verificar se a imagem é válida
            if image is None or image.size == 0:
                return render_template('basico.html', message='Invalida!')

            # Redimensionar para 224x224 pixels (para atender às expectativas do modelo)
            image = cv2.resize(image, (224, 224), interpolation=cv2.INTER_AREA)
            image = np.asarray(image, dtype=np.float32).reshape(1, 224, 224, 3)
            image = (image / 127.5) - 1

            prediction = model.predict(image)
            index = np.argmax(prediction)
            predicted_class = class_names[index][2:]
            confidence_score = np.round(prediction[0][index] * 100)

        except Exception as e:
            return render_template('basico.html', message=f'Processamento de imagem encontrou um problema!: {str(e)}')

    return render_template('basico.html', predicted_class=predicted_class, confidence_score=confidence_score, encoded_image=encoded_image)

if __name__ == '__main__':
    app.run(debug=True)



