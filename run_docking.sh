#!/bin/bash

source env.sh
source var.sh
source manage_resource.sh

# exhaustiveness = number of threads
rscid=$1
protein_file=$2
ligand_file=$3
NTHREADS=$4
EXHAUSTIVENESS=$5

protein_name=`basename ${protein_file} | sed 's/\.[^\.]*$//'`
ligand_name=`basename ${ligand_file} | sed 's/\.[^\.]*$//'`
mkdir -p ${OUTPUTDIR}/${protein_name}
mkdir -p ${LOGDIR}/${protein_name}

${BINARY} --receptor ${protein_file} --ligand ${ligand_file} \
  --center_x -8.654 --center_y 2.229 --center_z 19.715 --size_x 24.0 --size_y 26.25 --size_z 22.5 \
  --cpu ${NTHREADS} --exhaustiveness ${EXHAUSTIVENESS} \
  --seed 10 \
  --num_modes 9 \
  --out ${OUTPUTDIR}/${protein_name}/${ligand_name}.pdbqt \
  --log ${LOGDIR}/${protein_name}/${ligand_name}.log

push_resource $rscid
