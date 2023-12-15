import csv
import random
import NAMES

# Define the headers for the CSV file
headers = ['Employee_ID', 'Employee_Name', ' Employee_Email', 'Employee_Salary', 'Attendance_Type_ID','Position_ID']
ArraySalary = [2200, 2400, 2600, 2800, 3000 , 3200, 3400, 3600, 3800, 4000]


# Generate random data for 1000 employees
rows = []
for i in range(1000):
    employee_id = i + 1
    first_name = NAMES.get_first_name()
    last_name = NAMES.get_last_name()
    email = f'{first_name.lower()}.{last_name.lower()}@gmail.com'
    position_id=random.randint(1, 10)
    salary = ArraySalary[position_id - 1]
    attendance_id=random.randint(1, 2)
    rows.append([employee_id, first_name+' '+last_name,email,salary,attendance_id,position_id])

# Save the data to a CSV file
with open('Employees.csv', 'w', newline='') as f:
    writer = csv.writer(f)
    writer.writerow(headers)
    writer.writerows(rows)
