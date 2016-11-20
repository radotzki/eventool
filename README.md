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
* [Login] (https://github.com/radotzki/eventool_server/wiki/API:-Login)
* [Production](https://github.com/radotzki/eventool/wiki/API:-Production)
* [User](https://github.com/radotzki/eventool/wiki/API:-User)
* [Client](https://github.com/radotzki/eventool/wiki/API:-Client)
* [Event](https://github.com/radotzki/eventool/wiki/API:-Event)
* [Client Comment](https://github.com/radotzki/eventool/wiki/API:-Client-Comment)
* [Client Friendship](https://github.com/radotzki/eventool/wiki/API:-Client-Friendship)
* [Event Price](https://github.com/radotzki/eventool/wiki/API:-Event-Price)
* [Client Ticket](https://github.com/radotzki/eventool/wiki/API:-Client-Ticket)

## DB:
* [Tables Descriptions] (https://github.com/radotzki/eventool/wiki/DB:-Tables)
* [ERD] (https://github.com/radotzki/eventool/wiki/DB:-ERD)

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
