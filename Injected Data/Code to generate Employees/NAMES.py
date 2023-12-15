import random

# Define lists of first and last names
F_NAMES = ['Ahmed', 'Fatima', 'Mohammed', 'Aisha', 'Omar', 'Layla', 'Ali', 'Sara', 'Hassan', 'Hana', 'Khalid',
               'Yara', 'Abdullah', 'Zainab', 'Musa', 'Leila', 'Ibrahim', 'Nour', 'Saeed', 'Jasmine', 'Yousef', 'Rana',
               'Mustafa', 'Amina', 'Jaber', 'Zahra', 'Faisal', 'Safia', 'Yassin', 'Samira', 'Salim', 'Lina', 'Mira',
               'Amira', 'Mahmoud', 'Maya', 'Tariq', 'Huda', 'Nasser', 'Mariam', 'Hamza', 'Nadia', 'Sami', 'Rania',
               'Adnan', 'Dina', 'Rashid', 'Mona', 'Tala', 'Farah']

L_NAMES = ['AbuAmara', 'AbuGhazaleh', 'AbuKharma', 'AbuKhater', 'AbuSaad', 'AbuShawish', 'AbuShkeir',
              'Shtayyeh', 'AbuZaid', 'Abed', 'AbedRabbo', 'AboShehada', 'AbuSalah', 'Aweidah', 'Badawi',
              'Daher', 'Elayan', 'Farah', 'Hammad', 'Hamoudeh', 'Hasan', 'Ibrihaim', 'Jaber', 'Khalaf', 'Mahameed',
              'Mansour', 'Masri', 'Najjar', 'Nassar', 'Odeh', 'Qasim', 'Qattan', 'Rahman', 'Saleh', 'Salman',
              'Sarsour', 'Shalabi', 'Shamasneh', 'Sulaiman', 'Taha', 'Tamimi', 'Younis', 'Zaanin',
               'Zayed', 'Zeidan', 'Zuaiter', 'Jabr', 'Hamad', 'Jamous']

# Define a function to get a random first name
def get_first_name():
    return random.choice(F_NAMES)

# Define a function to get a random last name
def get_last_name():
    return random.choice(L_NAMES)