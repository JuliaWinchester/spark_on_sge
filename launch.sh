#!/bin/bash

# Launches a set of Spark master and worker processes on Sun Grid Engine (SGE)
# cluster architecture. The Spark standalone cluster manager is used to
# coordinate driver and worker nodes. Worker processes are launched manually as 
# SGE qsub jobs, allowing the cluster to efficiently manage resources. This
# script should generally not be run on its own as it does not include any
# ability to exit launched spark processes. Instead, the script spark_run.sh
# should be run, since it automates spark environment launch, spark application
# submission, and spark process/qsub job clean-up.

function check_free_port () {
	if [[ $(netstat -lnt | awk '$6 == "LISTEN" && $4 ~ ".{$MASTER_PORT}"') ]]; then
		MASTER_PORT = "shuf -i 7001-7099 -n 1"
		check_free_port
	else
		return
	fi
}

. "conf/sge.sh"
. "conf/spark-env.sh"

SPARK_MASTER_HOST = $(hostname -i)
SPARK_MASTER_PORT = $(shuf -i 7001-7099 -n 1)
check_free_port

. "${SPARK_HOME}/sbin/start-master.sh"

for i in $(seq 1 $NUM_QSUB_JOBS)
do
	command
done


