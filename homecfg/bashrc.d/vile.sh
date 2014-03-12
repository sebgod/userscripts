#!/bin/sh

VILEINIT="
~if &rd \"./.vilerc\"
	source \"./.vilerc\"
~else
	~if &rd \"$HOME/.vilerc\"
		source \"$HOME/.vilerc\"
	~endif
~endif"
export VILEINIT
