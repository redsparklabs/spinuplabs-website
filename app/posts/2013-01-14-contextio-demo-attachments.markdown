---
title: Context.io Demo - List Attachments
author: Brent Weber
email: bweber@redsparklabs.com
post-date: 2012-1-16
---

generate attachments controller

    rails g controller attachments index show

*restart server*

Add index method in controller/attachments

      def index
        data = $cio_connect.list_files(:account => $cio_acct)
        @attachments = JSON.parse(data.body)
      end

attachments/index.html.erb

    <h1>All Attachments</h1>

    <%= debug @attachments %>

Replace debug line

    <%= debug @attachments.first %>

Replace with content

    <% @attachments.each do |attachment| %>
      <p>
        <b><%= attachment["file_name"] %></b>
        [<%= attachment["addresses"]["from"]["email"] %>]<br />
      </p>
    <% end %>

setup attachments routes

    get "attachments" => "attachments#index"

    match 'attachments/show/:file_id' => 'attachments#show'

*relaunch server*

edit show method in contacts controller

      def show
        data = $cio_connect.get_contact(:account => $cio_acct, :file_id => params[:file_id])
        @contact = JSON.parse(data.body)
      end

add link to contacts/index.html.erb

      <%= link_to 'Contact Details','show/'+contact['email'] %><br />

attachments/show.html.erb

    <h1>Attachment</h1>

    <%= debug @attachment %>

replace debug line

    File Name: <%= @attachment["file_name"] %><br />
    File Size: <%= (@attachment["size"].to_f/2**20).round(2) %>MB<br />
    File Type: <%= @attachment["type"] %><br />
    Received: <%= Time.at(@attachment["date_received"]).to_date %><br />
    <img src="<%= @attachment['personInfo'][@attachment['addresses']['from']['email']]['thumbnail'] %>" height="100"><br />
    From: <%= @attachment["addresses"]["from"]["email"] %><br />
