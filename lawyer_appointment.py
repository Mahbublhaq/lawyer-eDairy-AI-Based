from flask import Flask, render_template, request, jsonify, session
import mysql.connector

app = Flask(__name__)
app.secret_key = 'your_secret_key'

# Database connection
db = mysql.connector.connect(
    host="localhost",
    user="root",
    password="",
    database="lawyer_edairy"
)
cursor = db.cursor()

@app.route('/')
def index():
    return render_template('lawyer_appointment.html')

@app.route('/search_lawyers', methods=['POST'])
def search_lawyers():
    specialization = request.json['specialization']

    query = "SELECT lawyer_id, name, specialization FROM lawyers WHERE specialization = %s"
    cursor.execute(query, (specialization,))
    lawyers = cursor.fetchall()

    lawyers_list = [{'id': lawyer[0], 'name': lawyer[1], 'specialization': lawyer[2]} for lawyer in lawyers]

    return jsonify({'lawyers': lawyers_list})

@app.route('/book_appointment', methods=['POST'])
def book_appointment():
    # Ensure user is logged in
    if 'user_id' not in session:
        return jsonify({'error': 'User not logged in'}), 401

    user_id = session['user_id']
    lawyer_id = request.form['lawyer_id']
    lawyer_name = request.form['lawyer_name']
    user_name = request.form['user_name']
    user_phone = request.form['user_phone']
    appointment_date = request.form['appointment_date']
    appointment_time = request.form['appointment_time']
    appointment_status = 'Pending'  # Default status

    # Insert the appointment into the database
    query = """
    INSERT INTO appointments (user_id, lawyer_id, lawyer_name, user_name, user_phone, appointment_date, appointment_time, appointment_status) 
    VALUES (%s, %s, %s, %s, %s, %s, %s, %s)
    """
    values = (user_id, lawyer_id, lawyer_name, user_name, user_phone, appointment_date, appointment_time, appointment_status)
    cursor.execute(query, values)
    db.commit()

    return jsonify({'message': 'Appointment booked successfully'})

# User login route
@app.route('/login', methods=['POST'])
def login():
    email = request.form['email']
    password = request.form['password']

    # Check credentials in the database
    query = "SELECT * FROM users WHERE email = %s AND password = %s"
    cursor.execute(query, (email, password))
    user = cursor.fetchone()

    if user:
        # Store user ID in session
        session['user_id'] = user[0]
        return jsonify({'message': 'Login successful'})
    else:
        return jsonify({'error': 'Invalid email or password'}), 401

if __name__ == '__main__':
    app.run(debug=True)
