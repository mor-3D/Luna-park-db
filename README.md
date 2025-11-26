# Luna-park-db
Database structure and SQL queries for the Luna Park management system.
🎡 Luna Park Database Project

A complete SQL-based database system designed for managing an amusement park, including tables, constraints, queries, stored procedures, functions, triggers, and transactions.

📘 Project Overview

This project simulates an information system for “Luna Kef”, a large amusement park located in Tel Aviv.
The system manages rides, employees, customers, orders, activities, scheduling, and financial calculations.

The goal is to provide the park's management with reliable, organized, and efficient access to operational and business data.

🎯 Project Objectives

Efficient calculation of employee salaries

Monitoring rides with high wait times

Analyzing annual and quarterly profitability

Identifying the most profitable locations for opening new branches

Displaying daily shows and park activities

Understanding customer demographics and preferences

👥 System Users

Manager

Secretary

Accountant

Customers

🗂 What This Project Includes

Full database schema

Entity relationships and dependencies

Data integrity constraints

Business and operational SQL queries

Views (virtual tables)

Stored procedures

User-defined functions

Trigger logic

Transactions for salary processing

🏢 Organization Description

Luna Kef is a large amusement park featuring various attractions for all ages. The park employs adults aged 18 and above and operates numerous rides and daily activities.
This database supports efficient management of employees, customer activity, revenue tracking, and operational improvements.

🔐 Data Constraints (Examples)

Employees must be at least 18 years old

ID number must contain exactly 9 digits

Ride names must contain English letters

Bonus must be less than 1000

Hourly pay rate between 30–200

Customers’ phone number must be 9–10 digits

Maximum 6 rides in the park

📊 Main Tables

employee – Employee information

customers – Customer details

luna – Ride information

orders – Ticket orders

activities – Daily park activities

employee_pay – Salary and bonus calculations

The full ERD and diagrams are included in the presentation.

🔍 Key Queries Included

Finding the busiest months

Rides with yearly revenue above 10,000

The city with the highest number of customers

Virtual tables for revenue calculations

🧩 Functions

Annual and quarterly profit comparison

Average customer age per ride

Days an employee did not work

Finding available employees for a specific date

🔧 Stored Procedures

Deleting employees who have not worked for over a year

Reducing ride activity time when wait time exceeds one hour

Listing employees under a specific supervisor

Automatic daily employee scheduling for the entire month

Adding an order while verifying age suitability for the ride

🚨 Trigger

Automatically displays the activities taking place on the date of a new order.

💰 Transaction

Calculates salary based on seniority by adding 1 currency unit for each year of employment, including salary and bonus processing.

📦 Included Files
File	Description
LunaPark.sql	Full SQL script: tables, constraints, queries, stored procedures, functions, triggers
LunaParkPresentation.pptx	Full project presentation with ERD and explanations
▶️ How to Run the Project

Load the SQL file into SQL Server Management Studio (SSMS) or another SQL platform.

Execute the table creation scripts.

Apply constraints and relations.

Run functions and stored procedures.

Use provided queries to test the system.
