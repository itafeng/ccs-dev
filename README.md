# ccs-dev
CloudComSpace

This is a pilot project to get my feet wet in Azure Cloud Services development. A web role and a worker role are used in this cloud service solution. Here is how it works:

1. Web role creates a message and places it in the storage queue named "message" when it starts.
2. Worker role keeps polling the message queue. If a message is available, it will retrieve system data and put it into a storage table named "system" and remove the message from the queue.
3. When the page (http://ccs-pilot.cloudapp.net/home/contact) is requested, the controller will query the "system" table and get the data and return the result in HTML5 format to the browser. 
