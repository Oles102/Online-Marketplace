# Shelter - Online Marketplace for Handmade Pet Products

This project is an online marketplace called **Shelter** for handmade pet products. 

Created with:
- Ruby 3.0.1
- Ruby on Rails 7


Tools used in this project:
1. [Devise](https://betterprogramming.pub/devise-auth-setup-in-rails-7-44240aaed4be) - User authentication
2. Rolify - Role-based authorization
3. Pundit - User authorization
4. Sidekiq - Background job processing
5. Redis - In-memory data store
6. Postgres - Database
7. ActiveAdmin - Admin interface builder

## Installation and Setup

To get started with the **Shelter** project, follow these steps:

1. Clone the repository:
```
git clone https://github.com/Oles102/Online-Marketplace.git
```
2. Navigate to the project directory:
```
cd My_project
```
3. Add the required gems to your Gemfile:
```
```ruby
gem "pg"
gem "redis"
gem "sassc-rails"
gem "factory_bot_rails"
gem "letter_opener"
gem "devise"
gem "image_processing"
gem "rolify"
gem "pundit"
gem "sidekiq"
```
4.Install the gems:
```
bundle install
```
5.Set up the database:
```
rails db:create
rails db:migrate
```
6.Start the development server:
```
rails s
```
7.Open the application in your browser at http://localhost:3000.

# Contributing

## We welcome contributions from the community! If you would like to contribute to the Shelter project, please follow these steps:

Fork the repository.
Create a new branch for your changes:
```
git checkout -b feature/your-feature-name
```
Make the necessary changes and commit:
```
git commit -m "Add your commit message"
```
Push your changes to your fork:

```
git push origin feature/your-feature-name
```

Open a pull request in our repository so that we can review your changes.

Please feel free to modify the content according to your project and requirements.




