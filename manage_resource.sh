#!/bin/bash

rsc_list='/dev/shm/resource_list.txt'

function init_resource_list()
{
    num_rsc=$1
    rsc_end=`expr ${num_rsc} - 1`
    echo "0" > ${rsc_list}
    for i in `seq ${rsc_end}`
    do
        echo ${i} >> ${rsc_list}
    done
}

function pop_resource()
{
    rsc_id=`head -n 1 ${rsc_list}`
    flock ${rsc_list} sed -i '1d' ${rsc_list}
    echo $rsc_id
    return $rsc_id
}

function push_resource()
{
    flock ${rsc_list} echo $1 >> ${rsc_list}
}

function delete_resource_list()
{
    rm $rsc_list
}

function get_num_resources()
{
    nrsc=`cat ${rsc_list} | wc -l`
    echo $nrsc
    return $nrsc
}
