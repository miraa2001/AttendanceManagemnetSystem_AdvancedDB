import csv
import random
import datetime

# Define the headers for the CSV file
headers = ['Daily_Attendance_ID', 'Employee_ID', 'Attendance_Date', 'Attendance_Day', 'Start_Time', 'End_Time']

# Generate random data for daily attendance
rows = []
attendance_id = 1
start_date = datetime.date(2023, 3, 1)  # Start date for the two-month period
end_date = start_date + datetime.timedelta(days=60)  # End date for the two-month period

# Define the employee count for different working hours
employee_count_with_weekend = 100
employee_count_without_weekend = 1000

# Generate daily attendance records
for _ in range(employee_count_with_weekend):
    employee_id = random.randint(1, 1000)
    for date in (start_date + datetime.timedelta(days=n) for n in range((end_date - start_date).days)):
        attendance_date = date.strftime('%d-%m-%Y')
        attendance_day = date.strftime('%A')
        if attendance_day in ['Friday', 'Saturday']:
            start_time = datetime.time(12,0)  # Start time for other days
            end_time = datetime.time(16,0)  # End time for other days
            rows.append([attendance_id, employee_id, attendance_date, attendance_day,  start_time.strftime('%H:%M'), end_time.strftime('%H:%M')])
            attendance_id += 1

for _ in range(employee_count_without_weekend):
    employee_id = random.randint(1, 1000)
    for date in (start_date + datetime.timedelta(days=n) for n in range((end_date - start_date).days)):
        attendance_date = date.strftime('%d-%m-%Y')
        attendance_day = date.strftime('%A')
        if attendance_day not in ['Friday', 'Saturday']:
            start_time = datetime.time(random.randint(7, 9), random.randint(0, 59))  # Start time for other days
            end_time = datetime.time(random.randint(15, 17), random.randint(0, 59))  # End time for other days
            rows.append([attendance_id, employee_id, attendance_date, attendance_day, start_time.strftime('%H:%M'), end_time.strftime('%H:%M')])
            attendance_id += 1

# Save the data to a CSV file
with open('DailyAttendance.csv', 'w', newline='') as f:
    writer = csv.writer(f)
    writer.writerow(headers)
    writer.writerows(rows)
