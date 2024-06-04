#!/bin/bash
#PJM -N docking
#PJM -L "node=1"
#PJM -L "rscgrp=small"
#PJM -L "elapse=1:00:00"
#PJM -x PJM_LLIO_GFSCACHE=/vol0004:/vol0006:/vol0003
#PJM -g xxxxxxxx
#PJM -j
#PJM -S
#PJM --rsc-list "retention_state=0"


source env.sh
source var.sh
source manage_resource.sh

NTHREADS=24
EXHAUSTIVENESS=24
NRESOURCES=2

init_resource_list $NRESOURCES

protein_file=${PROTEINDIR}/PROTEINFILENAME

echo ${rscid}
for f in `ls ${LIGANDDIR}`
do
    ligand_file=${LIGANDDIR}/${f}
    while true
    do
        rscid=`pop_resource`
        if [ -n "$rscid" ]; then
            if [ $rscid -eq 0 ]; then
                NUMA="numactl --cpunodebind=4,5 --membind=4,5"
            else
                NUMA="numactl --cpunodebind=6,7 --membind=6,7"
            fi
            echo "rscid (${rscid}) is assinged to the simulation on ${NUMA}"
            time -p ${NUMA} ./run_docking.sh ${rscid} ${protein_file} ${ligand_file} ${NTHREADS} ${EXHAUSTIVENESS} &
            break
        else
	        sleep 5
        fi
    done
done

echo "All simulations have started."
while true
do
    nrsc=`get_num_resources`
    if [ $nrsc -eq ${NRESOURCES} ]; then
        break
    fi
    sleep 5
done
echo "Complete!"

delete_resource_list
