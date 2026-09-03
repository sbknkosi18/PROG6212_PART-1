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

## Category Endpoints

| HTTP Method | Route | Description | Role Required | Request Body | Expected Response |
|-------------|-------|-------------|---------------|--------------|-------------------|
| GET | /events/{eventId}/categories | Get all categories for an event | Any (Logged In) | None | 200 OK - Array of category objects <br> 404 Not Found - Event not found |
| GET | /categories/{id} | Get a specific category by ID | Any (Logged In) | None | 200 OK - Category object <br> 404 Not Found - Category not found |
| POST | /events/{eventId}/categories | Create a new category for an event | Organiser only | { "name", "description", "distance", "fee" } | 201 Created - Created category object <br> 400 Bad Request - Validation errors <br> 403 Forbidden - Insufficient permissions <br> 404 Not Found - Event not found |
| PUT | /categories/{id} | Update a category | Organiser only | { "name", "description", "distance", "fee" } | 200 OK - Updated category object <br> 400 Bad Request - Validation errors <br> 403 Forbidden - Insufficient permissions <br> 404 Not Found - Category not found |
| DELETE | /categories/{id} | Delete a category | Organiser only | None | 204 No Content - Category deleted <br> 403 Forbidden - Insufficient permissions <br> 404 Not Found - Category not found |

## Enrolment Endpoints

| HTTP Method | Route | Description | Role Required | Request Body | Expected Response |
|-------------|-------|-------------|---------------|--------------|-------------------|
| GET | /enrolments | Get current user's enrolments | Any (Logged In) | None | 200 OK - Array of enrolment objects <br> 401 Unauthorized - Not authenticated |
| GET | /events/{eventId}/enrolments | Get all enrolments for an event | Organiser only | None | 200 OK - Array of enrolment objects with participant details <br> 403 Forbidden - Insufficient permissions <br> 404 Not Found - Event not found |
| POST | /events/{eventId}/enrol | Enrol a participant in an event category | Participant only | { "categoryId" } | 201 Created - Enrolment object <br> 400 Bad Request - Already enrolled or category full <br> 403 Forbidden - Insufficient permissions <br> 404 Not Found - Event or category not found |
| DELETE | /enrolments/{id} | Cancel an enrolment | Participant (own) or Organiser | None | 204 No Content - Enrolment cancelled <br> 403 Forbidden - Insufficient permissions <br> 404 Not Found - Enrolment not found |

## Results Endpoints

| HTTP Method | Route | Description | Role Required | Request Body | Expected Response |
|-------------|-------|-------------|---------------|--------------|-------------------|
| GET | /events/{eventId}/results | Get all results for an event | Any (Logged In) | None | 200 OK - Array of result objects with rankings <br> 404 Not Found - Event not found |
| GET | /enrolments/{id}/result | Get specific result for an enrolment | Any (Logged In) | None | 200 OK - Result object <br> 404 Not Found - Result not found |
| GET | /participants/{id}/results | Get all results for a specific participant | Participant (own) or Organiser | None | 200 OK - Array of result objects <br> 403 Forbidden - Insufficient permissions <br> 404 Not Found - Participant not found |
| POST | /enrolments/{id}/result | Capture a result for an enrolment | Organiser only | { "time", "position" } | 201 Created - Result object <br> 400 Bad Request - Validation errors <br> 403 Forbidden - Insufficient permissions <br> 404 Not Found - Enrolment not found |
| PUT | /results/{id} | Update a result | Organiser only | { "time", "position" } | 200 OK - Updated result object <br> 400 Bad Request - Validation errors <br> 403 Forbidden - Insufficient permissions <br> 404 Not Found - Result not found |

## HTTP Status Codes Used
- **200 OK**: Successful GET, PUT requests
- **201 Created**: Successful POST requests
- **204 No Content**: Successful DELETE requests
- **400 Bad Request**: Validation errors, malformed requests
- **401 Unauthorized**: Not authenticated
- **403 Forbidden**: Insufficient permissions
- **404 Not Found**: Resource not found
- **409 Conflict**: Resource conflict (e.g., already enrolled)
- **500 Internal Server Error**: Server-side errors
