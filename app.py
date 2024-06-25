from flask import Flask, render_template, request, redirect, url_for
import psycopg2
from psycopg2 import Error

app = Flask(__name__)

# PostgreSQL bağlantı bilgileri
DB_HOST = 'localhost'
DB_NAME = 'proje'
DB_USER = 'postgres'
DB_PASSWORD = '1420'

# Veritabanı bağlantısı fonksiyonu
def get_db_connection():
    conn = None
    try:
        conn = psycopg2.connect(
            dbname=DB_NAME,
            user=DB_USER,
            password=DB_PASSWORD,
            host=DB_HOST
        )
        print("PostgreSQL Database connected successfully")
    except Error as e:
        print(f"Error connecting to PostgreSQL database: {e}")
    return conn

# Kullanıcı doğrulama fonksiyonu
def authenticate(username, password):
    conn = get_db_connection()
    if conn:
        try:
            cursor = conn.cursor()
            cursor.execute("SELECT * FROM doktorlar WHERE kullaniciadi = %s AND sifre = %s", (username, password))
            user = cursor.fetchone()
            cursor.close()
            conn.close()
            if user:
                return True
        except Error as e:
            print(f"Error querying PostgreSQL database: {e}")
    return False

@app.route('/')
def login():
    return render_template('login.html')

@app.route('/login', methods=['POST'])
def login_post():
    username = request.form.get('username')
    password = request.form.get('password')
    
    if authenticate(username, password):
        return redirect(url_for('index'))
    else:
        return "Kullanıcı Adı veya Şifre Hatalı"

@app.route('/index')
def index():
    return render_template('index.html')

@app.route('/teshis')
def teshis():
    return render_template('teshis.html')

@app.route('/makale')
def makale():
    return render_template('makale.html')

# Hastaları getiren fonksiyon
def get_patients():
    conn = get_db_connection()
    patients = []
    if conn:
        try:
            cursor = conn.cursor()
            cursor.execute("SELECT * FROM hastalar WHERE doktorid = 1")
            patients = cursor.fetchall()
            cursor.close()
            conn.close()
        except Error as e:
            print(f"Error querying PostgreSQL database: {e}")
    return patients

@app.route('/hastalar')
def view_patients():
    patients = get_patients()
    return render_template('hastalar.html', patients=patients)

# Yeni hasta kaydı sayfası
@app.route('/new_patient', methods=['GET'])
def new_patient():
    return render_template('hastakayit.html')

# Hasta kaydetme işlemi
@app.route('/save_patient', methods=['POST'])
def save_patient():
    if request.method == 'POST':
        hastatc = request.form['hastatc']
        ad = request.form['ad']
        soyad = request.form['soyad']
        dogumtarihi = request.form['dogumtarihi']
        cinsiyet = request.form['cinsiyet']
        kangrubu = request.form['kangrubu']

        try:
            conn = get_db_connection()
            cursor = conn.cursor()
            cursor.execute("INSERT INTO hastalar (doktorid, hastatc, ad, soyad, dogumtarihi, cinsiyet, kangrubu) VALUES (%s,%s, %s, %s, %s, %s, %s)",
                           (1,hastatc, ad, soyad, dogumtarihi, cinsiyet, kangrubu))
            conn.commit()
            cursor.close()
            conn.close()
            return redirect(url_for('new_patient'))  # Başarılı kayıt sonrası formu temizle
        except Error as e:
            print(f"Error inserting patient: {e}")
            return "Hasta kaydı sırasında bir hata oluştu."
        finally:
            if conn:
                conn.close()

@app.route('/update_patient', methods=['GET', 'POST'])
def update_patient_submit():
    patients = get_patients()  # Veritabanından hastaları alın

    if request.method == 'POST':
        patient_id = request.form['hasta_id']
        hastatc = request.form['hastatc']
        ad = request.form['ad']
        soyad = request.form['soyad']
        dogumtarihi = request.form['dogumtarihi']
        cinsiyet = request.form['cinsiyet']
        kangrubu = request.form['kangrubu']
        
        try:
            conn = get_db_connection()
            cursor = conn.cursor()
            cursor.execute("UPDATE hastalar SET hastatc = %s, ad = %s, soyad = %s, dogumtarihi = %s, cinsiyet = %s, kangrubu = %s WHERE hastaid = %s",
                           (hastatc, ad, soyad, dogumtarihi, cinsiyet, kangrubu, patient_id))
            conn.commit()
            cursor.close()
            conn.close()
            return redirect(url_for('update_patient_submit'))
        except Error as e:
            print(f"Error updating patient: {e}")
            return "Hasta güncelleme sırasında bir hata oluştu."
        finally:
            if conn:
                conn.close()

    return render_template('hastaguncelle.html', patients=patients)



if __name__ == '__main__':
    app.run(debug=True)
