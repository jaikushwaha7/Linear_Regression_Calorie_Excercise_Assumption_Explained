# -*- coding: utf-8 -*-
"""
Created on Wed Jan 13 16:07:44 2021

@author: Jai Kushwaha
"""

import numpy as np
from flask import Flask, request, jsonify, render_template
import pickle

app = Flask(__name__)
model = pickle.load(open('lr.pkl', 'rb'))

@app.route('/')
def home():
    return render_template('index.html')


@app.route('/predict',methods=['POST'])
def predict():
    '''
    For rendering results on HTML GUI
    '''
    int_features = [int(x) for x in request.form.values()]
    final_features = [np.array(int_features)]
    prediction = model.predict(final_features)
    
    
    return render_template('index.html', prediction_text='Calories Burnt ::{}'.format(prediction))

if __name__ == "__main__":
    app.run(debug=True)

