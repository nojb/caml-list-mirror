# Import commands (to be executed once)

init:
	public-inbox-init caml-list caml-list.git https://inbox.ocaml.org/caml-list caml-list@inria.fr

clone:
	git clone https://github.com/nojb/caml-list-archive caml-list

import:
	perl import.pl
