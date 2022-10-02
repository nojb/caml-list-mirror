import-local:
	public-inbox-init caml-list caml-list.git https://inbox.ocaml.org/caml-list caml-list@inria.fr
	perl import.pl

import:
	if [ -d caml-list-archive ]; then git -C caml-list-archive pull; else git clone https://github.com/nojb/caml-list-archive; fi
	if [ -d caml-list.git ]; then echo "caml-list.git already exists"; exit 2; fi
	cd public-inbox && docker build -t public-inbox . && docker run -v $(PWD):/root/work -it public-inbox make -C /root/work import-local
