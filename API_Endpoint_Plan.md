# RaceDay API Endpoint Plan

## Base URL: /api

##Authentication Endpoints

| HTTP Method | Route | Description | Role Required | Request Body | Expected Response |
|-------------|-------|-------------|---------------|--------------|-------------------|

| POST | /auth/register | Register a new user account | None (Public) | { "username", "email", "password", "role" } | 201 Created - { "user": { "id", "username", "email", "role" }, "token": "jwt_token" } <br> 400 Bad Request - Validation errors |
| POST | /auth/login | Authenticate a user and return JWT token | None (Public) | { "username", "password" } | 200 OK - { "token": "jwt_token", "user": { "id", "username", "email", "role" } } <br> 401 Unauthorized - Invalid credentials |

## User Endpoints

| HTTP Method | Route | Description | Role Required | Request Body | Expected Response |
|-------------|-------|-------------|---------------|--------------|-------------------|
| GET | /users/profile | Get current user profile | Any (Logged In) | None | 200 OK - { "id", "username", "email", "role", "createdAt" } <br> 401 Unauthorized - Not authenticated |
| PUT | /users/profile | Update current user profile | Any (Logged In) | { "email", "username" } | 200 OK - Updated user object <br> 400 Bad Request - Validation errors <br> 404 Not Found - User not found |
| GET | /users/{id} | Get user by ID | Organiser only | None | 200 OK - User object <br> 403 Forbidden - Insufficient permissions <br> 404 Not Found - User not found |

## Event Endpoints

| HTTP Method | Route | Description | Role Required | Request Body | Expected Response |
|-------------|-------|-------------|---------------|--------------|-------------------|
| GET | /events | Get all events (filtered by date, location, type) | Any (Logged In) | None | 200 OK - Array of event objects <br> 500 Internal Server Error - Server error |
| GET | /events/{id} | Get a specific event by ID | Any (Logged In) | None | 200 OK - Event object with categories <br> 404 Not Found - Event not found |
| POST | /events | Create a new event | Organiser only | { "name", "description", "date", "location", "maxParticipants" } | 201 Created - Created event object <br> 400 Bad Request - Validation errors <br> 403 Forbidden - Insufficient permissions |
| PUT | /events/{id} | Update an existing event | Organiser only | { "name", "description", "date", "location", "maxParticipants" } | 200 OK - Updated event object <br> 400 Bad Request - Validation errors <br> 403 Forbidden - Insufficient permissions <br> 404 Not Found - Event not found |
| DELETE | /events/{id} | Delete an event | Organiser only | None | 204 No Content - Event deleted <br> 403 Forbidden - Insufficient permissions <br> 404 Not Found - Event not found |
