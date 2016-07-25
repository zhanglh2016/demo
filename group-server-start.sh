#!/bin/bash
# Set language environment

EMV=`pwd`

LANG=zh_CN.GBK
export LANG

LC_ALL=zh_CN.GBK
export LC_ALL

# Set classpath

JAR_LIB=${EMV}/group-server-lib
export JAR_LIB

CLASSPATH=${EMV}/config.properties

##根据程序依赖lib生成CLASSPATH
for file in  `ls ${JAR_LIB}|awk '{print $1}'`
do
  CLASSPATH=${CLASSPATH}:${JAR_LIB}/$file
done

 CLASSPATH=${CLASSPATH}:${EMV}/group-server.jar

echo $CLASSPATH

export CLASSPATH


# Set standard commands for invoking Java.
RUNJAVA="/usr/bin/java -Xmx204m"


usage()
{
	echo "Usage: ./start.sh start | restart | stop "
}

if [ $# -lt 1 ]; then
	usage
	exit 0
fi

PIDS=`ps -ef | grep "cn.migu.shanpao.main.GroupServerApp" | grep -v grep | awk '{print $2}'`

if [ $1 = "start" ]; then
	if [ "X$PIDS" != "X" ]; then
		echo GroupServerApp has been started, the PID = "${PIDS}"
	else
		# Start programe
		echo Use CLASSPATH: "${CLASSPATH}"
		echo Now Loading the programme, please wait some seconds......
		$RUNJAVA cn.migu.shanpao.main.GroupServerApp &
	fi
fi

if [ $1 = "restart" ]; then
	if [ "X$PIDS" != "X" ]; then
		kill -9 $PIDS
		echo GroupServerApp has been killed, PID="${PIDS}"!
	fi
	# Start programe
	echo Use CLASSPATH: "${CLASSPATH}"
	echo Now loading the programme, please wait some seconds......
	$RUNJAVA cn.migu.shanpao.main.GroupServerApp &
fi

if [ $1 = "stop" ]; then
	if [ "X$PIDS" != "X" ]; then
		kill -9 $PIDS
		echo GroupServerApp has been killed, PID="${PIDS}"!
	else
		echo GroupServerApp has not been started, the stop command do nothing.
	fi
fi





