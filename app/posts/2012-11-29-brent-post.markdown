---
title: Ruby and MSCRM On-Premise
author: Brent Weber
email: bweber@redsparklabs.com
keywords: Microsoft CRM, Ruby, Rails, Portal, Customer, XRM
description: Simple script showing how easy it is to create a Ruby on Rails app with a MSCRM backend.
post-date: 2012-11-22
---

### Ruby is easier than PHP for lots of stuff ###
Playing with MSCRM and figured out how easy it is to talk to Microsoft CRM On-Premise with Ruby.

Install the gems
	gem install rest_client
	gem install curb

This simple piece of code get's it done.
	@ntlm_url = "http://[Server]:[Port]/[Organization_Name]/XRMServices/2011/OrganizationData.svc/"
	@ntlm_username = '[domain]\[username]'
	@ntlm_password = '[password]'

	resource = Curl::Easy.new
	resource.url = @ntlm_url
	resource.username = @ntlm_username
	resource.password = @ntlm_password
	resource.http_auth_types = :ntlm
	resource.perform
	puts resource.body_str

Simple as pie.  Compared to the struggles of connecting to CRM with PHP and SOAP or OData, this is a breeze.
