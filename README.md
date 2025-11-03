# 🛒 E-Commerce Order Tracking System

This is a simple and practical project built using SQL and PL/SQL.  
It shows how an e-commerce platform can manage customers, orders, payments, and deliveries through a database.
I created this to learn how real systems work behind the scenes — from placing an order to tracking it until it’s delivered.

📘 What This Project Does

The main idea is to handle everything related to online orders in one place.  
It automatically generates IDs, tracks payments, and keeps the data accurate through triggers and relationships.  
Basically, it’s like a small version of how real online stores manage their data.

🧩 How It Works

1. Database Design – I designed all the tables and connections between them  
2. Table Creation – Wrote SQL scripts to create tables for customers, orders, and payments  
3. Data Insertion – Added some sample data for testing  
4. PL/SQL Logic – Added triggers and procedures for automation  
5. Reports and Views – Created summary reports like total revenue and pending deliveries  

📂 Project Structure

E-Commerce-Order-Tracking-System/
│
├── 01_Database_Design/
│ ├── ER_Diagram.png
│ └── Schema_Diagram.png
│
├── 02_SQL_Scripts/
│ ├── Tables.sql
│ ├── Data.sql
│
├── 03_PLSQL_Logic/
│ ├── Triggers.sql
│ ├── Procedures.sql
│
├── 04_Reports_Views/
│ ├── Customer_Summary.sql
│ ├── Monthly_Revenue.sql
│ ├── Pending_Deliveries.sql
│
└── 05_Output_Snapshots/
├── customer_summary_output.png
├── monthly_revenue_output.png
├── pending_deliveries_output.png

💡 Highlights

1. Automatically generates IDs using Oracle identity columns  
2. Tracks orders and payments in real time  
3. Keeps the data consistent with triggers and constraints  
4. Shows easy-to-read summary reports  
5. Clean folder structure so it’s simple to follow  

🧰 Tools Used

- Oracle Database 21c  
- SQL / PL/SQL  
- Visual Studio Code  
- GitHub for version control
  
🧾 Sample Outputs

- Customer Summary Report  
- Monthly Revenue Report  
- Pending Deliveries Report  

📸 You can check the screenshots inside the `/05_Output_Snapshots/` folder.

🎯 What I Learned

This project helped me understand how real-world databases work.  
I learned to:

- Design proper database tables and relations  
- Use identity columns for auto ID generation  
- Write triggers and procedures to automate things  
- Create reports using views  
- Manage a project in a clean and structured way  

⚙️ How to Run

1. Open Oracle SQL Developer 
2. Run the scripts in this order:

   sql
   Tables.sql
   Data.sql
   Procedures.sql
   Triggers.sql
   Reports_Views.sql

Then check the outputs or run the reports manually.

👤 Author

J. Anitha
LinkedIn Profile
