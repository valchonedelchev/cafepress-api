# Cafepress API

[http://www.cafepress.co.uk/cp/developers/docs/index.aspx](http://www.cafepress.co.uk/cp/developers/docs/index.aspx)

# Getting started

* Sign in or register a new account with Cafepress.com.
* Get a new app key.
* Build cool stuff. The Cafepress.com API puts a factory at your fingertips. 
* Use with care and creativity.

# Usage

    use Cafepress::Api;
    
    my $api = Cafepress::Api->new(key=>$CPAPIKEY);
    
    my $token = $api->call(
      'authentication.getUserToken.cp',
      email    => 'you@example.com',
      password => 'P4ssW0r7'
      )->{value}->{text}
      or die $api->error;

    
    print ' * ' . $_->{name} . $/
      foreach
      @{ $api->call( 'store.listStores.cp', 'userToken' => $token )->{stores}
        ->{store} };


# Core Concepts

#### Authentication and Authorization

Any Cafepress API method that accesses a user's data requires authentication. The CafePress API follows a model similar to other public APIs, requiring an application key to give your application access to the CafePress API methods and a user token to allow your application to access and modify the data of a particular user. User tokens grant your application temporary permission to manipulate the private data of a particular user. User tokens are not the same thing as user names and passwords, although one of the methods of obtaining a user token does use the user name and password.

#### Prerequisites

Before you can use these methods, you have to have an appKey.

#### Main Use Cases

There are really three ways to obtain a user token:

* Logging a user in behind the scenes using their user name and password
* Redirecting a user to Cafepress where they enter their user name and password
* Asking for an "anonymous" user token (mostly for one-time purchases)

#### Logging a user in behind the scenes

In this method, the user has trusted your application enough to give their Cafepress user name and password to you. You then (securely) store these credentials and then use them in the background to generate a user token. If you provide a valid email and password with your application key, you will receive a userToken in XML as follows:

#### Raw HTTP

    Request: http://open-api.cafepress.com/authentication.getUserToken.cp?v=3&appKey=1234&email=XXXX&password=XXXX
    Response: <value>017c0cf7-4135-4037-8e82-cc19f061849e</value>

#### Redirecting User to Login

In this scenario, the user doesn't trust your application and doesn't want to give you their user name and password. Who can blame them! But you're not lost. What you can do instead is redirect them to a Cafepress hosted login page and after they log in there Cafepress will redirect them back to your application with a user token in hand. For those familiar with OAuth, this method is very similar to (but not identical to) OAuth.

Specifically, the login steps are:

1. Ask the Cafepress API for a loginToken and store it in a session variable
2. Redirect the user to Cafepress.com with that loginToken in hand
3. User logs in on Cafepress.com
4. Cafepress.com redirects user back to your application with userToken in hand

#### Login Token Raw HTTP

    Request: http://open-api.cafepress.com/authentication.getLoginToken.cp?v=3&appKey=1234&
    Response: <value>60f818da-e4b0-4810-bf61-15ce2fd1e268</value>

#### Redirect Raw HTTP

    Request: https://www.cafepress.com/cp/members/login.aspx?loginToken=60f818da-e4b0-4810-bf61-15ce2fd1e268&goto=http://my_api_application.com

Response: After the user logs in, Cafepress will redirect back to the url you passed in, for example: http://my_api_application.com?userToken=017c0cf7-4135-4037-8e82-cc19f061849e

#### Using an "Anonymous" User Token

Anonymous user tokens can be used to upload designs and create products. These are typically only used for "one-off" products that you don't intend to be made generally available later. One example of this use is to quickly create a custom product with a user's name on it and let them purchase it without having to create a Cafepress user account for that visitor.

#### Raw HTTP

    Request: http://open-api.cafepress.com/authentication.getAnonymousUserToken.cp?v=3&appKey=APPKEY
    Response: <value>e7991ac6-a28e-4e07-952c-bd68af925f38</value>

