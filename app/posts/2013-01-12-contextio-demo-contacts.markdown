---
title: Context.io Demo - List Contacts
author: Brent Weber
email: bweber@redsparklabs.com
image: samples/04_300x180.jpg
---

[Updated - This demo is using the contextio 0.4.0 rubygem]

<img src="/assets/samples/04_300x180.jpg" class="right" alt="Image">
This is a quick and dirty demo of how to pull a list of contacts from your imap account using the Context.io API.

First sign up for an account on http://context.io, then add an email account to it.

Since Rails is one of the easiest ways to quickly prototype something, I am going to use it.  I have made the assumption that you are working on a Mac with ruby and rails installed and working.

First either create a new rails app or skip down one step to add to an existing app.

Terminal

    rails new cio-demo

    cd cio-demo

We need to include the Context.IO gem as well as the oauth gem.

Gemfile

    # Context.io Specific
    gem 'contextio', '0.4.0'
    gem 'oauth'

Once we save the Gemfile, we want to bundle those gems into our app

Terminal

    bundle install

I am sure there are other ways to do this, and maybe even better, but this is the way I did it for simplicity sake right now.  We need to store our API keys and Email account key in an initializer.  I am also setting up a persistent connection to the API.  For this demo I am setting the email account id as a global variable, since we are using a single mailbox. Obviously replace the keys with your own.

The keys can be retrieved from [https://console.context.io/#settings](https://console.context.io/#settings)

config/initializers/contextio.rb

    # Global Context.IO Account ID
    $cio_acct = '[your_email_account_id]'

    #Context.IO Key
    contextio_key = '[your_api_key]'
    #Context.IO Secret
    contextio_secret = '[your_api_secretkey]'
    # Context.IO Persistent Connection Object
    $cio_connect = ContextIO::Connection.new(contextio_key,contextio_secret)

We need to create our contacts controller.

Terminal

    rails g controller contacts index show

Then setup our index method.  We are retrieving a list of contacts, then parsing the JSON and passing it into our view.

app/controllers/contacts_controller.rb

    def index
      data = $cio_connect.list_contacts(:account => $cio_acct)
      @contacts = JSON.parse(data.body)
    end

I am setting up the routes here, just so I can access the contacts controller without having to specify the method.  I am also setting up the route for the show method, so we can pass an email address in the querystring.

config/routes.rb

    get "contacts" => "contacts#index"
    get "contacts/index" => "contacts#index"

    match 'contacts/show/:email' => 'contacts#show', :constraints => { :email => /[^\/]+/ }

Now launch your rails server and test.

Terminal

    rails s

You can access your contacts controller at [http://localhost:3000/contacts/](http://localhost:3000/contacts/)

Now I setup a basic heading for our contacts/index view, and just echo out the data I am receiving from the API using debug @contacts.

app/views/contacts/index.html.erb

    <h1>List of Contacts</h1>

    <%= debug @contacts %>

You should see a bunch of data with two main pieces (query, matches).  Matches is what we are interested in.  Since the data returned for each contact is the same structure, I only want to echo out the first set.

app/views/contacts/index.html.erb

    <h1>List of Contacts</h1>

    <%= debug @contacts["matches"].first %>

Now I can see what data is being returned.  For this demo I want to pull in the gravatar thumbnail, name and email address for each contact.  I will print them out in a simple list.

app/views/contacts/index.html.erb

    <h1>List of Contacts</h1>

    <% @contacts['matches'].each do |contact| %>
       <p>
       <img src="<%= contact['thumbnail'] %>"><br />
       Name: <%= contact['name'] %><br />
       Email: <%= contact['email'] %><br />
       <%= link_to 'Contact Details','contacts/show/'+contact['email'] %><br />
       </p>
    <% end %>

Notice the link to the contact details page.  We need to create the contacts/show method which retrieves the information for the specific email address.

app/controllers/contacts_controller.rb

      def show
        data = $cio_connect.get_contact(:account => $cio_acct, :email => params[:email])
        @contact = JSON.parse(data.body)
      end

Now we setup our show view.  As we did above I want to create a simple heading as well as echoing out the data that is returned from the API call.

app/views/contacts/show.html.erb

    <h1>Contact</h1>

    <%= debug @contact %>

If you view the contact details page for a contact, you will see that we are only retreiving the data for a single contact.  I want to show the gravatar thumbnail, name, last email recieved, last email sent and any emails address associated with this contact.

app/views/contacts/show.html.erb

    <h1>Contact</h1>

    <img src="<%= @contact['thumbnail'] %>" height="100"><br />
    Name: <%= @contact["name"] %><br />

      <% if @contact["last_received"] %>
        Last Receipt: <%= Time.at(@contact["last_received"]).to_date %><br />
      <% end %>

      <% if @contact["last_sent"] %>
        Last Send: <%= Time.at(@contact["last_sent"]).to_date %><br />
      <% end %>

      Email Addresses:
      <ul>
      <% @contact["emails"].each do |email| %>
         <li><%= email %></li>
      <% end %>
      </ul>

Now viewing our contact list at [http://localhost:3000/contacts/](http://localhost:3000/contacts/) we can click through to the contact details and see more information about each contact.  We could even easier pull that contact list and invite them to use our app or compare it to existing users to find friends who already use our app.  Context.io makes this data super easy to access and use in your app.
