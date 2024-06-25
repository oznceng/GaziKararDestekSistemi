import tensorflow as tf
from django.shortcuts import render, redirect
from .forms import UploadImageForm
from django.conf import settings
import os
import requests
from requests.exceptions import RequestException

# Load your .h5 model
model = tf.keras.models.load_model("C:\\Users\\Lenovo\\breast_cancer_classification\\CNN_model.h5")

def preprocess_image(image_path):
    img = tf.keras.preprocessing.image.load_img(image_path, target_size=(224, 224))  # Adjust target size as per your model
    img_array = tf.keras.preprocessing.image.img_to_array(img)
    img_array = tf.expand_dims(img_array, 0)  # Create a batch
    img_array = tf.keras.applications.mobilenet_v2.preprocess_input(img_array)  # Adjust preprocessing function as per your model
    return img_array

def index(request):
    if request.method == 'POST':
        form = UploadImageForm(request.POST, request.FILES)
        if form.is_valid():
            image = form.cleaned_data['image']
            # Save image to media directory
            image_path = os.path.join(settings.MEDIA_ROOT, image.name)
            with open(image_path, 'wb+') as destination:
                for chunk in image.chunks():
                    destination.write(chunk)
            
            # Preprocess the image and make prediction
            img_array = preprocess_image(image_path)
            predictions = model.predict(img_array)
            score = predictions[0][0]  # Since predictions is a 2D array

            if score < 0.5:  # Assuming a binary classifier with threshold 0.5
                result = "Sağlikli."
                articles = []
            else:
                result = "Meme Kanseri Tespit Edildi. İşte İlgili Makeleler:"
                articles = get_pubmed_articles()
            
            return render(request, 'result.html', {'result': result, 'articles': articles})
    else:
        form = UploadImageForm()
    return render(request, 'index.html', {'form': form})

def get_pubmed_articles():
    search_url = "https://eutils.ncbi.nlm.nih.gov/entrez/eutils/esearch.fcgi"
    summary_url = "https://eutils.ncbi.nlm.nih.gov/entrez/eutils/esummary.fcgi"
    query_params = {'db': 'pubmed', 'term': 'breast cancer', 'retmax': 5, 'sort': 'relevance', 'retmode': 'json'}
    
    try:
        search_response = requests.get(search_url, params=query_params)
        search_response.raise_for_status()  # Raise an HTTPError if the HTTP request returned an unsuccessful status code
        
        search_data = search_response.json()
        ids = search_data.get('esearchresult', {}).get('idlist', [])
        
        if not ids:
            return []

        # Fetch the summaries for the article IDs
        summary_params = {'db': 'pubmed', 'id': ','.join(ids), 'retmode': 'json'}
        summary_response = requests.get(summary_url, params=summary_params)
        summary_response.raise_for_status()
        
        summary_data = summary_response.json()
        articles = []

        for id in ids:
            article_data = summary_data.get('result', {}).get(id, {})
            if article_data:
                articles.append({
                    'title': article_data.get('title', 'No title available'),
                    'authors': ', '.join([author['name'] for author in article_data.get('authors', [])]),
                    'keywords': article_data.get('keywords', 'No keywords available'),
                    'abstract': article_data.get('abstract', 'No abstract available'),
                    'link': f"https://pubmed.ncbi.nlm.nih.gov/{id}/"
                })
                
        return articles
    except (RequestException, ValueError) as e:
        print(f"Error during PubMed search request: {e}")
        return []
