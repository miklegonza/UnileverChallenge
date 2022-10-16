# Sabana Hack - UNILEVER challenge - Team CodeKillers

Insert description [here]

## Pre-requisites

-   [NodeJS](https://nodejs.org/en/)
-   [MySQL 5.7](https://dev.mysql.com/downloads/)

## Getting started

-   Clone the repository

```bash
git clone https://github.com/miklegonza/RetoUnilever.git
```

-   Install dependencies

```bash
cd RetoUnilever
npm install
```

-   Create the database with the SQL Script under the `db-script/` folder

-   Create a new file named **.env** and add the following structure

    -   These will be the environmet variables used for connecting with the database. Fill them with your host info

```
DB_HOST = localhost
DB_USER = your-user
DB_PASS = your-password
DB_NAME = unilever
DB_PORT = 3306

PORT = 3000
```

-   Run

```bash
npm start
```

-   Test

```bash
npm test
```

Now you can use the API

## API Reference

| Method | URL | Action                                   |
| ------ | --- | ---------------------------------------- |
| GET    | /   | get 'Hello world' to prove that it works |

## Project Structure

| Name             | Description                                                          |
| ---------------- | -------------------------------------------------------------------- |
| db-script/db.sql | SQL Script to create the Database                                    |
| index.js         | Entry point to Express app                                           |
| src/configs      | Configuration files like db connection                               |
| src/controllers  | Middle points between the HTTP requests and the SQL statements logic |
| src/middlewares  | Additional bussiness logic                                           |
| src/routes       | Routes of the HTTP requests                                          |
| src/services     | DB connection and SQL statements                                     |
| src/utils        | Classes to assist some functionalities                               |
| test             | Folder dedicated to unit tests                                       |
| package.json     | Contains npm dependencies                                            |

# Contributors

-   Alexander Martínez - [@Alexmart2001](https://github.com/Alexmart2001)
-   Michael González - [@miklegonza](https://github.com/miklegonza)
-   David Rojas - [@DRJ44](https://github.com/DRJ44)
-   Samir Zapata - [@samirZapata](https://github.com/samirZapata)
-   Isabela Borrero
