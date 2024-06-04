#!/bin/bash

source var.sh

for f in `ls ${PROTEINDIR}`
do
    echo "docking simulation for the protein data $f"
    sed -e "s/PROTEINFILENAME/${f}/g" run_tmpl.sh > run.sh
    chmod 755 run.sh
    pjsub run.sh
    sleep 1
done
