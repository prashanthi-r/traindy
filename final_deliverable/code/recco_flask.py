import flask
from flask import Flask,request, Response, jsonify, make_response
from flask_cors import CORS
import numpy as np
import pandas as pd
from flask import send_file 
import io
import ast
import os
import random
import json
import string
from model import CVAE, predict, get_top_n_products

app = Flask(__name__)
CORS(app)

article_map = pd.read_csv('article_map.csv')
cust_data = pd.read_csv('customers.csv')
bins = [16, 24, 30, 34, 40, 60, 100]
cust_data['age_binned'] = pd.cut(cust_data['age'], bins, labels=False).fillna(0).astype(int)
cust_data['fashion_news_frequency'] = cust_data['fashion_news_frequency'].replace(['None','NONE',np.nan],'None')
cust_data['club_member_status'] = cust_data['club_member_status'].replace(np.nan, 'None')
cust_data['Active'] = cust_data['Active'].replace(np.nan, 0)

cust_label = pd.read_csv('customer_class.csv')

@app.route('/user', methods= ['POST', 'GET'])
def post():
    request_data = request.get_json()
    user_profile= {
        'age': request_data["age"],
        'fn': request_data["fn"],
        'cms': request_data["cms"],
        'au': request_data["au"],
   }
    fn_map = {'Regularly':'Regularly', 'Monthly':'Monthly', 'Never':'None'}
    cms_map = {'Active':'ACTIVE', 'Pre-create':'PRE-CREATE','Left CLub':'LEFT CLUB','None':'None'}
    au_map = {'Yes':1, 'No':0}
    age_bin = [16, 24, 30, 34, 40, 60, 100]

    for i in range(len(age_bin)-1):
        if int(user_profile['age'])>=age_bin[i] and int(user_profile['age'])<age_bin[i+1]:
            user_age_bin = i
    user_fn = fn_map[user_profile['fn']] 
    user_cms = cms_map[user_profile['cms']]
    user_au = au_map[user_profile['au']]
    print(user_age_bin,user_fn,user_cms,user_au)
    for n in cust_data[(cust_data['age_binned']==user_age_bin) & (cust_data['fashion_news_frequency']==user_fn) & (cust_data['Active']==user_au) & (cust_data['club_member_status']==user_cms)]['customer_id'].to_list():
        if cust_label[cust_label['customer_id']==n]['class'].to_list():
            user_label = cust_label[cust_label['customer_id']==n]['class'].to_list()[0]
            break
    print(user_label)
    model = CVAE(3231, latent_size=200)
    batch_inputs = np.zeros((500,3231))
    batch_labels = np.zeros((500,4))
    model(batch_inputs,batch_labels)
    model.load_weights('my_model_4.h5')
    pred = predict(user_label, model, 200)
    top_n = get_top_n_products(20,pred)
    top_n = [['0'+str(i), article_map[article_map['article_id']==int(i)]['prod_name'].values[0]] for i in top_n]
    print(top_n)
    #top_n = [['0108775015', 'Strap top'], ['0174057022', 'FLEECE PYJAMA'], ['0120129001', 'Babette long'], ['0181160009', 'Eva chelsea boot']]
    response = jsonify(top_n)
    response.headers.add("Access-Control-Allow-Origin", "*")
    response.headers.add("Access-Control-Allow-Credentials", "true")
    return response

    



if __name__ == '__main__': 
        app.run(debug=True)