## User Registration App

Imagine that you are part of a team that is creating a new library from scratch 
to capture user registration details and store them in a repository.

The library is intended to be consumed by different front-end applications (including web).

We need to capture and the following user details:

	- Username
	- PostCode
	- Email Address

Please see the table below for the email business rules:

    Domain Allowed       Email Addresses
    com-en (English)     .org.uk, co.uk, .biz
	  com-br (Brazilean)   .org.br, .info
	  com-es (Spanish)     .acrede-es, .acrede

- The repository to store user data is an xml data store that will be
replaced in the next 6 – 12 months by a database. Therefore we
should be able to seamlessly switch from one data source to another at
some point in the future. Please take this into account when designing
the solution. (In case you find XML tough you can use HSQL).
