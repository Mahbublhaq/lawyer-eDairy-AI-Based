from flask import Flask, render_template, request, redirect, url_for, session, jsonify 
import mysql.connector
import threading
import google.generativeai as palm

app = Flask(__name__)
app.secret_key = 'your_secret_key'


# Database connectio
db = mysql.connector.connect(
    host="localhost",
    user="root",
    password="",
    database="lawyer_edairy"
)
cursor = db.cursor()

@app.route('/api/cases', methods=['GET'])
def get_cases():
   
   
    data = get_case_details()
    cases = []
    for case in data:
        case_dict = {
            'case_no': case[0],
            'case_title': case[1],
            'judge_name': case[2],
            'lawyer_name': case[3],
            'description': case[4]
        }
        cases.append(case_dict)

    return jsonify(cases)
   

@app.route('/')
def welcome():
    return render_template('welcome.html')


def get_case_details():
    
    cursor.execute("SELECT * FROM case_details")
    data = cursor.fetchall()
    return data



@app.route('/add_case.html')
def add_case():
    return render_template('add_case.html')

@app.route('/add_note')
def add_note():
    return render_template('add_note.html')

@app.route('/add_note', methods=['POST'])
def insert_note():
    if 'user_id' not in session:
        return redirect(url_for('login'))

    user_id = session['user_id']
    category = request.form['category']
    user_name = request.form['user_name']
    case_no = request.form['case_no']
    case_title = request.form['case_title']
    case_date = request.form['case_date']
    judge_name = request.form['judge_name']
    description = request.form['description']

    query = "INSERT INTO notes (user_id, category, user_name, case_no, case_title, case_date, judge_name, description) VALUES (%s, %s, %s, %s, %s, %s, %s, %s)"
    values = (user_id, category, user_name, case_no, case_title, case_date, judge_name, description)
    cursor.execute(query, values)
    db.commit()

    return redirect(url_for('lawyer_dashboard'))



@app.route('/view_notes', methods=['GET'])
def view_notes():
    
    if 'user_id' not in session:
        return redirect(url_for('login'))

    user_id = session['user_id']
    query = "SELECT * FROM notes WHERE user_id = %s"
    cursor.execute(query, (user_id,))
    notes = cursor.fetchall()

    return render_template('view_notes.html', notes=notes)



@app.route('/login')
def login():
    return render_template('login.html')

@app.route('/signup', methods=['GET', 'POST'])
def signup():
    if request.method == 'POST':
        name = request.form['name']
        email = request.form['email']
        password = request.form['password']
        phone = request.form['phone']
        favorite_color = request.form['favourite_color']
        address = request.form['address']
        role = request.form['role']
        specialization = request.form.get('specialization')  # Get specialization if it exists

        # Insert the user data into the database
        if role == 'users':
            query = "INSERT INTO users (name, email, password, phone, favourite_color, address) VALUES (%s, %s, %s, %s, %s, %s)"
            values = (name, email, password, phone, favorite_color, address)
        else:
            query = "INSERT INTO lawyers (name, email, password, phone, favourite_color, address, specialization) VALUES (%s, %s, %s, %s, %s, %s, %s)"
            values = (name, email, password, phone, favorite_color, address, specialization)
        
        cursor.execute(query, values)
        db.commit()

        # Redirect to the login page after successful signup
        return redirect(url_for('login'))
    else:
        return render_template('signup.html', message="")


# Routes for the chatbot
@app.route('/chat')
def chatbot():
    return render_template('chat.html')


# Configure generative AI
palm.configure(api_key='AIzaSyCVIBOYsS0dyjW2V92Ta3RoPe6rSIA8ggU')

# List available models and select one for text generation
models = [m for m in palm.list_models() if 'generateText' in m.supported_generation_methods]
model_name = models[0].name

# Function to generate text based on user prompt
def generate_text(prompt):
    completion = palm.generate_text(
        model=model_name,
        prompt=prompt,
        max_output_tokens=2024
    )
    return completion.result.replace('*', ' ')


@app.route('/generate', methods=['POST'])
def generate():
    data = request.json
    prompt = data.get('prompt')
    
    if not prompt:
        return jsonify({'error': 'No prompt provided'}), 400
    
    try:
        response_text = generate_text(prompt)
        return jsonify({'response': response_text}), 200
    except Exception as e:
        return jsonify({'error': str(e)}), 500




# User login routes
@app.route('/login', methods=['POST'])
def login_post():
    email = request.form['email']
    password = request.form['password']
    role = request.form['role']

    if role == 'users':
        query = "SELECT * FROM users WHERE email=%s AND password=%s"
        dashboard_route = 'user_dashboard'
    else:
        query = "SELECT * FROM lawyers WHERE email=%s AND password=%s"
        dashboard_route = 'lawyer_dashboard'

    cursor.execute(query, (email, password))
    user = cursor.fetchone()

    if user:
        session['user'] = user
        session['role'] = role
        session['user_id'] = user[0]  # Assuming user ID is the first field in the database table
        return redirect(url_for(dashboard_route))
    else:
        return "Invalid email or password"

@app.route('/user_dashboard')
def user_dashboard():
    if 'user' not in session:
        return redirect(url_for('index'))

    user_id = session.get('user_id')
    query = """
    SELECT messages.message_id, messages.message_content, messages.reply_content, messages.status, messages.user_name, users.phone, lawyers.name AS lawyer_name
    FROM messages
    JOIN users ON messages.user_id = users.user_id
    JOIN lawyers ON messages.lawyer_id = lawyers.lawyer_id
    WHERE messages.user_id = %s
    """
    cursor.execute(query, (user_id,))
    messages = cursor.fetchall()

    query = "SELECT lawyer_id, name, specialization FROM lawyers"
    cursor.execute(query)
    lawyers = cursor.fetchall()

    query = """
    SELECT appointments.appointment_id, lawyers.name AS lawyer_name, appointments.appointment_date, 
    appointments.appointment_time, appointments.appointment_status
    FROM appointments
    JOIN lawyers ON appointments.lawyer_id = lawyers.lawyer_id
    WHERE appointments.user_id = %s
    """
    cursor.execute(query, (user_id,))
    appointments = cursor.fetchall()

    return render_template('user_dashboard.html', lawyers=lawyers, messages=messages, appointments=appointments)
#delete message from user dashboard
@app.route('/delete', methods=['POST'])
def delete():
    message_id = request.form['message_id']

    query = "DELETE FROM messages WHERE message_id = %s"
    cursor.execute(query, (message_id,))
    db.commit()
    return redirect(url_for('user_dashboard'))




@app.route('/send_message', methods=['POST'])
def send_message():
    user_id = session.get('user_id')
    lawyer_id = request.form['lawyer_id']
    message_content = request.form['message_content']

    query = "SELECT name FROM users WHERE user_id = %s"
    cursor.execute(query, (user_id,))
    user_name = cursor.fetchone()[0]

    query = "SELECT name FROM lawyers WHERE lawyer_id = %s"
    cursor.execute(query, (lawyer_id,))
    lawyer_name = cursor.fetchone()[0]

    query = """
    INSERT INTO messages (user_id, lawyer_id, message_content, user_name, lawyer_name) 
    VALUES (%s, %s, %s, %s, %s)
    """
    
    
    cursor.execute(query, (user_id, lawyer_id, message_content, user_name, lawyer_name))
    db.commit()

    return redirect(url_for('user_dashboard'))





@app.route('/lawyer_dashboard')
def lawyer_dashboard():
    if 'user' not in session:
        return redirect(url_for('index'))

    lawyer_id = session.get('user_id')
    query = "SELECT * FROM appointments WHERE lawyer_id = %s"
    cursor.execute(query, (lawyer_id,))
    appointments = cursor.fetchall()

    query = """
    SELECT messages.message_id, messages.message_content, messages.reply_content, messages.status, messages.user_name, users.phone, messages.lawyer_name
    FROM messages
    JOIN users ON messages.user_id = users.user_id
    WHERE messages.lawyer_id = %s
    """
    cursor.execute(query, (lawyer_id,))
    messages = cursor.fetchall()
    
    
    #<div class="ap"> <h5 class="ap">Pending Appointments: {{ pending_appointments }}</h5></div>
    lawyer_id = session.get('user_id')
    query = "SELECT COUNT(*) FROM appointments WHERE lawyer_id = %s AND appointment_status = 'pending'"
    cursor.execute(query, (lawyer_id,))
    pending_appointments = cursor.fetchone()[0]
    
    # <h5 class="ap">Unread Messages: {{ unread_messages }}</h5>
    query = "SELECT COUNT(*) FROM messages WHERE lawyer_id = %s AND status = 'Pending'"
    cursor.execute(query, (lawyer_id,))
    unread_messages = cursor.fetchone()[0]
    
    
    return render_template('lawyer_dashboard.html', appointments=appointments, messages=messages, pending_appointments=pending_appointments, unread_messages=unread_messages)
    
   
    

@app.route('/delete_message', methods=['POST'])
def delete_message():
    message_id = request.form['message_id']

    query = "DELETE FROM messages WHERE message_id = %s"
    cursor.execute(query, (message_id,))
    db.commit()
    return redirect(url_for('lawyer_dashboard'))
    
    
    
    

@app.route('/update_appointment', methods=['POST'])
def update_appointment():
    appointment_id = request.form['appointment_id']
    appointment_status = request.form['appointment_status']
    appointment_date = request.form['appointment_date']
    appointment_time = request.form['appointment_time']

    query = """
    UPDATE appointments 
    SET appointment_status = %s, appointment_date = %s, appointment_time = %s 
    WHERE appointment_id = %s
    """
    cursor.execute(query, (appointment_status, appointment_date, appointment_time, appointment_id))
    db.commit()

    return redirect(url_for('lawyer_dashboard'))

@app.route('/delete_appointment', methods=['POST'])
def delete_appointment():
    appointment_id = request.form['appointment_id']

    query = "DELETE FROM appointments WHERE appointment_id = %s"
    cursor.execute(query, (appointment_id,))
    db.commit()

    return redirect(url_for('lawyer_dashboard'))

@app.route('/reply_message', methods=['POST'])
def reply_message():
    message_id = request.form['message_id']
    reply_content = request.form['reply_content']
    status = request.form['status']

    query = """
    UPDATE messages 
    SET reply_content = %s, status = %s 
    WHERE message_id = %s
    """
    cursor.execute(query, (reply_content, status, message_id))
    db.commit()

    return redirect(url_for('lawyer_dashboard'))

@app.route('/lawyer_appointment')
def lawyer_appointment():
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


@app.route('/forgetpass')
def forgot_password():
    return render_template('forgetpass.html')

@app.route('/forgetpass', methods=['POST'])
def reset_password():
    if request.method == 'POST':
        role = request.form['role']
        email = request.form['email']
        favourite_color = request.form['favourite_color']
        new_password = request.form['new_password']

        # Check which table to use based on the selected role
        table_name = 'users' if role == 'user' else 'lawyers'

        # Check if email and favorite color match in the corresponding table
        query = f"SELECT * FROM {table_name} WHERE email = %s AND favourite_color = %s"
        cursor.execute(query, (email, favourite_color))
        result = cursor.fetchone()

        if result:
            # Update the password
            #generate_password_hash
            hashed_password = (new_password)
            update_query = f"UPDATE {table_name} SET password = %s WHERE email = %s"
            cursor.execute(update_query, (hashed_password, email))
            db.commit()
            return redirect(url_for('login', password_reset=True))
        else:
            return "Error: Email and favorite color do not match our records."
        
        #profile page
@app.route('/profile')
def profile():
    return render_template('profile.html')


@app.route('/update_profile', methods=['POST'])
def update_profile():
    if request.method == 'POST':
        # Retrieve form data
        name = request.form.get('name')
        email = request.form.get('email')
        phone = request.form.get('phone')
        favorite_color = request.form.get('favourite-color')  # Corrected spelling
        address = request.form.get('address')
        role = request.form.get('role')
        specialization = request.form.get('specialization')

        # Check which table to use based on the selected role
        if role == 'users':
            table_name = 'users'
        else:
            table_name = 'lawyers'

        # Update the user data in the database
        query = f"UPDATE {table_name} SET name = %s, phone = %s, favourite_color = %s, address = %s"
        values = (name, phone, favorite_color, address)
        
        if role == 'lawyers':
            query += ", specialization = %s"
            values += (specialization,)

        query += " WHERE email = %s"
        values += (email,)

        cursor.execute(query, values)
        db.commit()

        return redirect(url_for('profile'))

#logout
@app.route('/logout')
def logout():
    session.pop('user', None)
    session.pop('role', None)
    session.pop('user_id', None)
    return redirect(url_for('login'))

@app.route('/add_case')
def add_case_form():
    return render_template('add_case.html')

@app.route('/add_case', methods=['POST'])
def insert_case():
    try:
        user_id=session['user_id'];
        case_no = request.form['case_no']
        case_title = request.form['case_title']
        judge_name = request.form['judge_name']
        lawyer_name = request.form['lawyer_name']
        description = request.form['description']

        # Insert the case data into the case_details table
        query = "INSERT INTO case_details (case_no, case_title, judge_name, lawyer_name, description,addcase_lawyer_id) VALUES (%s, %s, %s, %s, %s,%s)"
        values = (case_no, case_title, judge_name, lawyer_name, description,user_id)
        cursor.execute(query, values)
        db.commit()

        return redirect(url_for('lawyer_dashboard'))

    except KeyError as e:
        return f"Missing form field: {e.args[0]}", 400

   

@app.route('/case.html')
def case():
    return render_template('case.html')


    
    



if __name__ == '__main__':
    app.run(debug=True)