#!/bin/bash
#PJM -L "node=1"
#PJM -L "rscgrp=small"
#PJM -L "elapse=0:20:00"
#PJM -x PJM_LLIO_GFSCACHE=/vol0004:/vol0006:/vol0003
#PJM -g xxxxxxxx
#PJM --rsc-list "retention_state=0"
#PJM -j

source env.sh
source var.sh

cd ${WORKINGDIR}/qvina
make -j 40
