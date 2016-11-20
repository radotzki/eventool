# Eventool

Eventool is an event management application that computerized all production needs.
Producers can see all details about their events, like how many people came, how much they paid and who bring them. The application store details on all events, so producer can learn from his past events.

With one shared clients repository, promoters work gets better and more efficient. 
Follow a client, watch his events activity, see his friends, read some comments about him, and register tickets to upcoming events.

During the event cashiers search tickets to attending clients, as well add a client to the repository if he does not exist.

If you are a producer and you want to make your life easier and earn more many, join us!

<hr>

## Entities:
* **Production:** We work with productions. One production means one costumer for us. 
<br> Production has many users, clients and events. Each production is separated from the others - a user from one production can not see other productions details.
* **User:** Producer/Promoter/Cashier.
<br> When a new user created he need to choose his production. His default role is cashier and his account locked. In order to unlock the account, the producer need to confirm the account.
* **Producer:** The man who manage the production. It means that he is the boss of the promoters and cashiers.
Each production can have one or more producers.
    1. Confirm new users and choose their role (kind of user).
    2. Delete users.
    3. Create new events and decide what the prices of the tickets will be.
    4. See details about workers and events.
    5. Do all the stuff that the promoter can do.
* **Promoter:** His job is to talk to clients and convince them to come to events.
    1. Add new clients.
    2. Register tickets to clients.
    3. See clients details.
    4. Connect to clients to be friends.
    5. Write comments on clients.
    6. See his productivity on past events.
* **Cashier:** During the event cashiers welcome the attending clients and check if they have tickets. If client has no ticket he need to pay full price, as well the cashier add him to the repository.
    1. Search tickets for clients.
    2. Checkin client - mark as attended.
    3. Add new clients. 
    4. If client has some tickets (from different promoters), the cashier ask the client who registered ticket for him, and choose the right ticket.
* **Client:** Client is a human that has potential to come to events. User can search clients by name or phone number. 
<br> Each client has profile page that contains relevant details about him like:
    1. Tickets and events history.
    2. His friends.
    3. Basic info (phone number, birthdate, gender, etc..)
* **Event:** Event has datetime and name. When a producer create an event he need to also create prices for the event. 
* **Ticket:** Ticket assign to client for each event and contains the price the client need to pay to the specific event and the producer who register that ticket. Promoter can add reason to a ticket - why he registered that ticket to a client.
<br> Some promoters can register tickets to same client to same event. 


## API Descriptions:
* [Login] (https://github.com/radotzki/eventool-server#api-login)
* [Production](https://github.com/radotzki/eventool-server#api-production)
* [User](https://github.com/radotzki/eventool-server#api-user)
* [Client](https://github.com/radotzki/eventool-server#api-client)
* [Event](https://github.com/radotzki/eventool-server#api-event)
* [Client Comment](https://github.com/radotzki/eventool-server#api-client-comment)
* [Client Friendship](https://github.com/radotzki/eventool-server#api-client-friendship)
* [Event Price](https://github.com/radotzki/eventool-server#api-event-price)
* [Client Ticket](https://github.com/radotzki/eventool-server#api-client-ticket)

## DB:
* [Tables Descriptions] (https://github.com/radotzki/eventool-server#tables-descriptions)
* [ERD] (https://github.com/radotzki/eventool-server#erd)

## Environments:
There are 3 different environments: 
* Production - http://amitay.cloudapp.net
* Development - http://amitay.cloudapp.net:3000
* Test - http://eventool-test.herokuapp.com 
<br>In this environment the db must stay static. If you want to change something in the db please open an issue, do not change by yourself! 

## Cascade Policy:
* When delete a client all tickets will be deleted.
* When delete an event all tickets will be deleted.
* When delete an event price all tickets with that price will be deleted.

<hr>

### API: Login
```  	
POST   /api/v1/login
```
*   	**Description:** Check user authentication and return a token if user authenticate. 
                    <br> Requires: email, password. 
*   	**Permission:** Guest.

```
GET    /api/v1/current_user
```
*   	**Description:** Returns current user. 
*   	**Permission:** Producer, Promoter, Cashier.


### API: Production
```
GET /api/v1/productions
```
*   	**Description:** Returns all productions.
*   	**Permission:** Producer, Promoter, Cashier.

```
POST /api/v1/productions
```
*   	**Description:** Create a new production and a producer.
                    <br> Requires: name, first_name, last_name, email, password. 
                    <br> Optional: phone_number.
*   	**Permission:** Guest.

```
GET    /api/v1/productions/:id
```
*   	**Description:** Returns a specific production.
*   	**Permission:** Producer, Promoter, Cashier.

```
PUT /api/v1/productions/:id
```
*   	**Description:** Update a production. 
                     <br>Optionals: name.
*   	**Permission:** Producer can update his production.

```
DELETE /api/v1/productions/:id
```
*   	**Description:** Delete a production.
*   	**Permission:** Producer can delete his production.

### API: User
```  	
GET    http://eventool.herokuapp.com/api/v1/users
```
*   	**Description:** Return all users from logged in user's production.
*   	**Permission:** Producer, Promoter, Cashier (Production dependency).


```  	
POST   http://eventool.herokuapp.com/api/v1/users
```
*   	**Description:** Create a new user.
  	             <br>Requires: production_id, first_name, last_name, email, password, role.
              	     <br>Optionals: phone_number.
*   	**Permission:** Guest.

```  	
GET    http://eventool.herokuapp.com/api/v1/users/:id
```
*   	**Description:** Returns a specific user.
*   	**Permission:** Producer, Promoter, Cashier (Production dependency).

```  	
PUT    http://eventool.herokuapp.com/api/v1/users/:id
```
*   	**Description:** Update a user. 
                     <br>Optionals: first_name, last_name, email, password, phone_number.
*   	**Permission:** Producer (Production dependency).
                    <br>Promoter and Cashier can only update themself.

```  	
DELETE http://eventool.herokuapp.com/api/v1/users/:id
```
*   	**Description:** Delete a user.
*   	**Permission:** Producer (Production dependency).

```  	
GET    http://eventool.herokuapp.com/api/v1/users/:id/tickets
```  	
*   	**Description:** Returns all tickets that the user registered.
*   	**Permission:** Producer. Promoter can see only his tickets (Production dependency).

```  	
PUT    http://eventool.herokuapp.com/api/v1/users/:id/unlock
```  	
*   	**Description:** Unlock a user account.
*   	**Permission:** Producer (Production dependency).

```  	
PUT    http://eventool.herokuapp.com/api/v1/users/:id/lock
```  	
*   	**Description:** Lock a user account.
*   	**Permission:** Producer (Production dependency).

```  	
PUT    http://eventool.herokuapp.com/api/v1/users/:id/change_role
```  	
*   	**Description:** Change user's role.
                     <br>Requires: role.
*   	**Permission:** Producer (Production dependency).


### API: Client
```  	
GET    http://eventool.herokuapp.com/api/v1/clients
```
*   	**Description:** Returns all clients from logged in user's production.
*   	**Permission:** Producer, Promoter, Cashier (Production dependency).

```  	
POST   http://eventool.herokuapp.com/api/v1/clients
```
*   	**Description:** Create a new client under logged in user's production. 
                    <br> Requires: first_name, last_name, gender. 
                    <br> Optionals: phone_number, birthdate, city.
*   	**Permission:** Producer, Promoter, Cashier (Production dependency).

```  	
GET    http://eventool.herokuapp.com/api/v1/clients/:id
```
*   	**Description:** Returns a specific client.
*   	**Permission:** Producer, Promoter, Cashier (Production dependency).

```  	
PUT    http://eventool.herokuapp.com/api/v1/clients/:id
```
*   	**Description:** Update a client. 
                     <br>Optionals: first_name, last_name, gender, phone_number, birthdate, city.
*   	**Permission:** Producer, Promoter (Production dependency).

```  	
DELETE http://eventool.herokuapp.com/api/v1/clients/:id
```
*   	**Description:** Delete a client.
*   	**Permission:** Producer, Promoter (Production dependency).

```  	
GET    http://eventool.herokuapp.com/api/v1/clients/search
```
*   	**Description:** Search a client by name or phone number.
                    <br> Requires: search_param. 
*   	**Permission:** Producer, Promoter, Cashier (Production dependency).

```  	
GET    /api/v1/clients/:client_id/events/:id/count_friends_tickets
```  	
*   	**Description:** Return the number of tickets the client's friends have.
*   	**Permission:** Producer, Promoter (Production dependency).

### API: Event
```  	
GET    http://eventool.herokuapp.com/api/v1/events
```
*   	**Description:** Returns all events.
*   	**Permission:** Producer, Promoter, Cashier (Production dependency).

```  	
POST   http://eventool.herokuapp.com/api/v1/events
```
*   	**Description:** Create a new event. 
                    <br> Requires: name, when.
*   	**Permission:** Producer (Production dependency).

```  	
GET    http://eventool.herokuapp.com/api/v1/events/:id
```
*   	**Description:** Returns a specific event.
*   	**Permission:** Producer, Promoter, Cashier (Production dependency).

```  	
PUT    http://eventool.herokuapp.com/api/v1/events/:id
```
*   	**Description:** Update an event. 
                     <br>Optionals: name, when.
*   	**Permission:** Producer (Production dependency).

```  	
DELETE http://eventool.herokuapp.com/api/v1/events/:id
```
*   	**Description:** Delete an event.
*   	**Permission:** Producer (Production dependency).

```  	
GET    http://eventool.herokuapp.com/api/v1/events/:id/tickets
```
*   	**Description:** Returns all tickets for specific event. 
*   	**Permission:** Producer, Promoter, Cashier (Production dependency).

```  	
GET    /api/v1/events/upcoming
```
*   	**Description:** Returns all upcoming events with prices 
*   	**Permission:** Producer, Promoter (Production dependency).

### API: Client-comment
```  	
GET    http://eventool.herokuapp.com/api/v1/clients/:client_id/comments
```
*   	**Description:** Returns all comments for specific client.
*   	**Permission:** Producer, Promoter, Cashier (Production dependency).

```  	
POST   http://eventool.herokuapp.com/api/v1/clients/:client_id/comments
```
*   	**Description:** Create new comment to a client. 
                    <br> Requires: comment.
*   	**Permission:** Producer, Promoter, Cashier (Production dependency).

```  	
GET    http://eventool.herokuapp.com/api/v1/clients/:client_id/comments/:id
```
*   	**Description:** Returns a specific comment on specific client.
*   	**Permission:** Producer, Promoter, Cashier (Production dependency).

```  	
PUT    http://eventool.herokuapp.com/api/v1/clients/:client_id/comments/:id
```
*   	**Description:** Update a comment. 
                     <br>Optionals: comment.
*   	**Permission:** Producer, Promoter, Cashier (Production dependency).

```  	
DELETE http://eventool.herokuapp.com/api/v1/clients/:client_id/comments/:id
```
*   	**Description:** Delete a comment.
*   	**Permission:** Producer, Promoter (Production dependency).

### API: Client-friendship
```  	
GET    http://eventool.herokuapp.com/api/v1/clients/:client_id/friends
```
*   	**Description:** Return client's friends.
*   	**Permission:** Producer, Promoter (Production dependency).

```  	
GET    http://eventool.herokuapp.com/api/v1/clients/:client_id/friends/count
```
*   	**Description:** Return client's friends count.
*   	**Permission:** Producer, Promoter, cashier (Production dependency).

```  	
POST   http://eventool.herokuapp.com/api/v1/clients/:client_id/friends
```
*   	**Description:** Create a new frindships between two clients. 
                    <br> Requires: client_two_id.
*   	**Permission:** Producer, Promoter (Production dependency).

```  	
DELETE http://eventool.herokuapp.com/api/v1/clients/:client_id/friends/:id
```
*   	**Description:** Delete a friendship between two clients.
*   	**Permission:** Producer, Promoter (Production dependency).

### API: Event-price
```  	
GET    http://eventool.herokuapp.com/api/v1/events/:event_id/prices
```
*   	**Description:** Returns all prices for a specific event.
*   	**Permission:** Producer, Promoter, Cashier (Production dependency).

```  	
POST   http://eventool.herokuapp.com/api/v1/events/:event_id/prices
```
*   	**Description:** Create a new price for specific event. 
                    <br> Requires: price.
*   	**Permission:** Producer (Production dependency).

```  	
GET    http://eventool.herokuapp.com/api/v1/events/:event_id/prices/:id
```
*   	**Description:** Returns a price for an event.
*   	**Permission:** Producer, Promoter, Cashier (Production dependency).

```  	
PUT    http://eventool.herokuapp.com/api/v1/events/:event_id/prices/:id
```
*   	**Description:** Update a price. 
                     <br>Optionals: price.
*   	**Permission:** Producer (Production dependency).

```  	
DELETE http://eventool.herokuapp.com/api/v1/events/:event_id/prices/:id
```
*   	**Description:** Delete a price.
*   	**Permission:** Producer (Production dependency).

### API: Client-ticket
```  	
GET    /api/v1/clients/:client_id/tickets
```
*   	**Description:** Returns all tickets for specific client.
*   	**Permission:** Producer, Promoter, Cashier (Production dependency).

```  	
POST   /api/v1/clients/:client_id/tickets
```
*   	**Description:** Create a new ticket for specific client. 
                    <br> Requires: event_id, event_price_id. 
                    <br> Optionals: reason.
*   	**Permission:** Producer, Promoter (Production dependency).

```  	
GET    /api/v1/clients/:client_id/tickets/:id
```
*   	**Description:** Returns a ticket for a client.
*   	**Permission:** Producer, Promoter, Cashier (Production dependency).

```  	
PUT    /api/v1/clients/:client_id/tickets/:id
```
*   	**Description:** Update a ticket. 
                     <br>Optionals: event_id, event_price_id, reason.
*   	**Permission:** Producer. Promoter can update only his tickets. (Production dependency).

```  	
DELETE /api/v1/clients/:client_id/tickets/:id
```
*   	**Description:** Delete a ticket.
*   	**Permission:** Producer. Promoter can delete only his tickets. (Production dependency).

```  	
PUT    /api/v1/clients/:client_id/tickets/:id/checkin
```
*   	**Description:** Checkin a client to an event. (Mark client as arrived)
*   	**Permission:** Producer, Cashier (Production dependency).

```  	
PUT    /api/v1/clients/:client_id/tickets/:id/change_price
```
*   	**Description:** Change price for ticket (update)
*   	**Permission:** Producer. Promoter only his tickets. 

```
GET    /api/v1/clients/:client_id/tickets/current_event
```
*   	**Description:** Get all ticket for a client for event that occur in the range of 10 hours from current time (-10 < now < +10).
*   	**Permission:** Producer, Promoter, Cashier (Production dependency).

<hr>

### Tables Descriptions
## Productions
Description:
* Store the production that register to the application.
* Each production represent one unique company that does not connect to other productions.
* One production equal to one business client.

Relations:
* production has many users 
* production has many clients 
* production has many events 


## Users
Description:
* Store the users of the application. 
* User can be Producer, Promoter or Cashier. 
* Each user belongs to one production.
* Producer need to confirm new users, and change ‘lock’ attribute to ‘false’.

Relations:
* user belongs to production
* user has many comments 
* user has many events 
* user has many client_friendships 
* user has many tickets


## Clients:
Description:
* Store the clients of the productions. 
* Each client linked to one production.
* Client is a human who come to production’s events.

Relations:
* client belongs to production
* client has many comments 
* client has many friends
* client has many tickets 


## Events:
Description:
* Store all events for all production.
* Each event linked to one production.

Relations:
* event belongs to creator (user)
* event belongs to production
* event has many prices 
* event has many tickets


## Client_comments:
Description:
* Store comments about clients.
* Users can add comments about each client.

Relations:
* client_comment belongs to user
* client_comment belongs to client


## Client_friendships:
Description:
* Store friendships between clients.
* User can decide to connect between two 
* clients if they are friends of each other.
* That can help to Promoters in their job.

Relations:
* client_friendship belongs to user
* client_friendship belongs to client_one
* client_friendship belongs to client_two


## Event_prices:
Description:
* Store the prices for each event.
* User that create an event can 
* decide the prices for the event.

Relations:
* event_price belongs to event
* event_price has many tickets

 
## Tickets:
Description:
* Store all tickets for all events.
* Many Users can register ticket to same Client to same event.

Relations:
* ticket belongs to promoter
* ticket belongs to cashier
* ticket belongs to client
* ticket belongs to event
* ticket belongs to price

### ERD
![ERD](http://s16.postimg.org/hq2uldtph/db_erd.png)
