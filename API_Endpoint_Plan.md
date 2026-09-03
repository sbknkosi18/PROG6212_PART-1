# RaceDay API Endpoint Plan

## Base URL: /api

##Authentication Endpoints

| HTTP Method | Route | Description | Role Required | Request Body | Expected Response |
|-------------|-------|-------------|---------------|--------------|-------------------|

| POST | /auth/register | Register a new user account | None (Public) | { "username", "email", "password", "role" } | 201 Created - { "user": { "id", "username", "email", "role" }, "token": "jwt_token" } <br> 400 Bad Request - Validation errors |
| POST | /auth/login | Authenticate a user and return JWT token | None (Public) | { "username", "password" } | 200 OK - { "token": "jwt_token", "user": { "id", "username", "email", "role" } } <br> 401 Unauthorized - Invalid credentials |

