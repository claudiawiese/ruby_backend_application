## ruby_backend_application
This app is a pure Ruby Backend Application without using Ruby on Rails. It deals with car rentals data and has 5 levels.
Level 1 generates a json with rental prices for each car rental
Level 2 generates a json with discounted rental prices for each car rental
Level 3 generates a json with commissions for each rental 
Level 4 generates a json with rentals amount distributed to creditors and debitors 
Level 5 same as level 4 but takes into account different types of options and their prices as well 


### Run main.rb for level separatly
You need docker in order to run your_level/main.rb
    
First: Build app with docker

    docker build -t ruby_backend_application .  

Second: Choose level you want to run main.rb via docker
    
    docker run --rm -v $(pwd):/usr/src/app -w /usr/src/app ruby_backend_application ruby level1/main.rb 

(You can also launch the bash console of your container, navigate to your level and then run ruby main.rb)


Third: Go to your level/data/output.json and check out the data that has been generated

Example: 

    level1/data/output.json

    {
        "rentals": [
        {
            "id": 1,
            "price": 7000
        },
        {
            "id": 2,
            "price": 15500
        },
        {
            "id": 3,
            "price": 11250
        }
      ]
    }


### Architecture

    project_root/
    │
    ├── level1/
    │   ├── data/ (json_files)
    │   └── main.rb
    │
    ├── level2/
    │   ├── data/ (json_files)
    │   └── main.rb
    │
    ├── level3/
    │   ├── data/ (json_files)
    │   └── main.rb
    │
    ├── level4/
    │   ├── data/ (json_files)
    │   └── main.rb
    │
    ├── level5/
    │   ├── data/ (json_files)
    │   └── main.rb
    │
    ├── shared_folder/
    │   ├── models/ (car, option, rental models)
    │   ├── services/ (commission, credit, pricing services)
    │   └── data/ (load and save data classes)
    │
    ├── spec/
    │   ├── (test files and subdirectories for models and services tests)
    │
    ├── Dockerfile
    ├── Gemfile
    ├── Gemfile.lock
    ├── LICENSE
    └── README.md

The models initiate the Car, Rental and Option classes. 

The services manage rental pricing, calculate commissions and dispatched debit and credit amounts 


### Run tests

First: launch bash console 

    docker run -it --rm -v $(pwd):/app ruby_backend_application /bin/bash  

Second: run rspec

    bundle exec rspec 