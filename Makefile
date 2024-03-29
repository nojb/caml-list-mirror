import.local:
	public-inbox-init caml-list caml-list.git https://inbox.ocaml.org/caml-list caml-list@inria.fr
	perl import.pl
	cd caml-list.git && public-inbox-index

import:
	if [ -d caml-list-archive ]; then git -C caml-list-archive pull; else git clone https://github.com/nojb/caml-list-archive; fi
	if [ -d caml-list.git ]; then echo "caml-list.git already exists"; exit 2; fi
	cd public-inbox && docker build -t public-inbox . && docker run --rm -v $(PWD):/root/work -it public-inbox make -C /root/work import.local | tee _log

serve:
	cd public-inbox && docker build -t public-inbox . && docker run --rm -p 8080:8080 -v $(PWD)/caml-list.git:/root/caml-list.git -it public-inbox public-inbox-httpd

process:
	cd public-inbox && docker build -t public-inbox . && docker run --rm -v $(PWD)/caml-list.git:/root/caml-list.git -i public-inbox public-inbox-mda --no-precheck

deploy:
	if ! [ -d caml-list.git ]; then \
	  git clone -b master --bare https://github.com/nojb/caml-list.git; \
	else \
	  git -C caml-list.git fetch; \
	fi
	docker-compose up
