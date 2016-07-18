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

Then run the test:

	test-postgres.sh