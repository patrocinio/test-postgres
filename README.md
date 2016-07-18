Sample: postgresql-nodejs
===
This repository contains a sample Node.JS application that can use the PostgreSQL service in BlueMix.




Downloading this sample
---
You can clone this sample by the following command: 

    git clone https://github.com/patrocinio/test-postgres




Running this sample
---
Create a user-defined service called postgres by running the following command:

	create-service.sh postgres <Postgres Connection string>
	
You can set up SSL connection, by passing "ssl=true" in the connection string, like the example below:

	create.service.sh postgres postgres://admin:<password>@aws-us-east-1-portal.16.dblayer.com:11074/compose?ssl=true

Then run the test:

	test-postgres.sh