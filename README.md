# README

This App replicates an OOP REST API to process payments. Companies can create customers and charges.

* Ruby version
2.5.1

* Rails version
5.1.1

* Run the test suite: $bundel exec rspec

* Deploy by lifting the rails server: $rails s

## Usage examples

### Create a Company
curl -H "Content-type: application/json" \
     -X POST -d '{
        "name": "Envia Ya",
        "category": "delivery"
       }' http://localhost:3000/companies

### Create a Charge
curl -H "Content-type: application/json" \
     -X POST -d '{
        "amount": "1000",
        "payment_type": "oxxo"
       }' http://localhost:3000/companies/1/charges

### Create a Customer
curl -H "Content-type: application/json" \
     -X POST -d '{
        "name": "Jane Doe",
        "email": "jane@gmail.com"
       }' http://localhost:3000/companies/1/customers
