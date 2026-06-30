# MokeSell Marketplace Database System

This project was completed as part of the **Database Systems** module at **Ngee Ann Polytechnic**.

MokeSell is a relational database for a marketplace platform where buyers and sellers can interact. The database was designed from an Entity Relationship (ER) model and implemented in **Microsoft SQL Server** using SQL.

---

## Overview

The database supports features such as:

- Member management (buyers and sellers)
- Product listings
- Categories and subcategories
- Listing photos
- Buyer offers
- Chat messaging
- Reviews and ratings
- Likes and followers
- Listing bump promotions
- Customer feedback
- Staff, teams, and awards

---

## Technologies Used

- Microsoft SQL Server 2022
- SQL Server Management Studio (SSMS)
- SQL (DDL & DML)

---

## Database Features

- 21 normalized tables
- Primary and foreign keys
- CHECK and DEFAULT constraints
- One-to-one, one-to-many, and many-to-many relationships
- Sample data for testing
- Single SQL script to create and populate the database

---

## Database Design

### Entity Relationship Model

![ER Model](images/MokeSell%20ER%20Model.png)

### Logical Database Design

![Logical Design](images/MokeSell%20Logical%20Design.png)

---

## Repository Structure

```
.
├── images/
│   ├── MokeSell ER Model.png
│   └── MokeSell Logical Design.png
├── LICENSE
├── MokeSell_Database_Setup.sql
└── README.md
```

---

## How to Run

### Requirements

- Microsoft SQL Server 2022
- SQL Server Management Studio (SSMS)

### Steps

1. Open SQL Server Management Studio.
2. Connect to your SQL Server instance.
3. Open `MokeSell_Database_Setup.sql`.
4. Execute the script.

The script will:

- Create the database
- Create all tables
- Add constraints and relationships
- Insert sample data
- Run validation queries

---

## Role & Contributions

This project was completed as a **team of five**.

My main contributions included:

- Mapping the provided ER model into a normalized relational database
- Creating the data dictionary for all 21 database tables
- Implementing the database schema in Microsoft SQL Server
- Creating primary keys, foreign keys, and database constraints
- Running and validating the complete SQL database
- Contributing to the project documentation and report

---

## What I Learned

Through this project, I gained hands-on experience with:

- Relational database design
- Database normalization
- SQL Data Definition Language (DDL)
- SQL Data Manipulation Language (DML)
- Primary and foreign key relationships
- Database documentation
- Working on a database project as part of a team

---

## License

This project is licensed under the MIT License. See the LICENSE file for more information.

---

## Disclaimer

This repository is shared as part of my personal portfolio.

The project was originally completed as a team assignment for academic purposes. This repository showcases my individual contributions and is shared for learning and portfolio purposes.
