SHELL=/bin/bash
TMP_FILE_NAME=price
LOG=/tmp/${TMP_FILE_NAME}.log
MD=/tmp/${TMP_FILE_NAME},md
GOOD=5303d
CONDITION=雷朋
SCKEY=SCU31080T5747dd558f09b5ecab28adf0b081d80b5b7cdf2331e11
TITLE=search taobao

all: get trans push

get:
	@./scripts/get-info.py -g ${GOOD} -c ${CONDITION} -o ${LOG}

trans:
	@./scripts/trans-from-txt-to-md.sh -f ${LOG} -t ${MD}

push: export TIME=`date -d today +'%Y-%m-%d %H:%M:%S'`
push: export THE_TITLE=${TITLE} - ${TIME}
push:
	@./scripts/note.sh -k ${SCKEY} -t "${THE_TITLE}" -f ${MD}

chk1: export CHK=500
chk1: chk

chk2: export CHK=450
chk2: chk

chk3: export CHK=1000
chk3: chk


cat:
	@cat ${LOG}

md:
	@cat ${MD}

chk: get
	@./scripts/chk.sh -p ${CHK} -f ${LOG}

