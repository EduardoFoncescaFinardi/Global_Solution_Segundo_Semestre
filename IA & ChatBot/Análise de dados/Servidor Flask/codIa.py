from flask import Flask, request, jsonify
import numpy as np
import pickle
from sklearn.linear_model import LogisticRegression
    
app = Flask(__name__)

#modelo de exemplo - substitua isso pelo seu modelo rteinado
#aqui estamos carregando o modelo ja treinado que está no arquivo JobLib
with open(r"C:\Users\lucca\OneDrive\Área de Trabalho\pasta\meu_modelo.serializado.pickle", 'rb') as f:
    modelo = pickle.load(f)

#Rota pra receber os dados e fazer previsoes
@app.route('/prever', methods = ['GET'])
def prever():
    #obter parametros da solicitacao GET
    parametro1=float(request.args.get('1'))
    parametro2=float(request.args.get('2')) 
    parametro3=float(request.args.get('3'))
    parametro4=float(request.args.get('4'))
    parametro5=float(request.args.get('5'))
    parametro6=float(request.args.get('6'))
    parametro7=float(request.args.get('7'))
    parametro8=float(request.args.get('8'))
    parametro9=float(request.args.get('9'))
    parametro10=float(request.args.get('10'))
    parametro11=float(request.args.get('11'))
    parametro12=float(request.args.get('12'))
    parametro13=float(request.args.get('13'))
    

    #Fazer previsoes usando o modelo(substitua por sua proprias lógicas)
    entrada = np.array([[parametro1,parametro2,parametro3,parametro4,parametro5,parametro6,parametro7,parametro8,parametro9,parametro10,parametro11,parametro12,parametro13]])
    resultado = modelo.predict(entrada)
    # ({'prev': entrada.tolist()}),
    #retornar o resultado como JSON
    return jsonify({'entrada': entrada.tolist()}, {"saida": resultado.tolist()}) 

if __name__ == '__main__':
    print('Servidor Flask em execução')
    #executar o app Flask
    app.run(debug=True)