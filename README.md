Pre-requisite for running Application locally:
1. Must have docker installed

Steps to run Application:
1. Execute `docker build -t coffee_shop .`, docker image will be created using this command.
2. Execute `docker run -d --rm -it -p 3000:3000 --env RAILS_MASTER_KEY=f36da57347304f48fefbf5f913ddcd13 coffee_shop`
3. Application will start on port 3000

Postman Collection Url:
https://www.postman.com/winter-spaceship-2247/workspace/interview/request/1283802-3d25a093-1f57-4e6b-866d-075c3878d473

Cloud Url:
DEV_HOST: http://localhost:3000
PROD_HOST: http://3.91.232.179

Important Points before testing Application
1. There are 2 types of users: Admin, Customer
2. All apis are authenticated and need Authorization token for accessing the API
3. Some api's are admin authenticated and some are user authenticated, APIs which has (admin) suffix needs admin Authorization token.
4. User can be created using create_user API, and in order to create Admin user (role: "admin") needs to be passed in API



