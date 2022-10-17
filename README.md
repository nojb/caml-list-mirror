# A caml-list mirror using public-inbox

Deployment instructions
-----------------------

`make deploy`, or:

1. `git clone https://github.com/nojb/caml-list-mirror`

2. `cd caml-list-mirror && git clone -b master https://github.com/nojb/caml-list`

3. `cd caml-list-mirror && docker-compose up`.

The HTTP server listens on port 8080 and the Postfix server on port 25.
