#!/usr/bin/env bashio
WAIT_PIDS=()

CONFIG_PATH='/usr/src/frpc.ini'

SERVER_IP=$(bashio::config 'serverAddr')
SERVER_PORT=$(bashio::config 'serverPort')
AUTH_TOKEN=$(bashio::config 'authToken')
LOCAL_PORT=$(bashio::config 'localPort')
REMOTE_PORT=$(bashio::config 'remotePort')

function stop_frpc() {
    bashio::log.info "Shutdown frpc client"
    kill -15 "${WAIT_PIDS[@]}"
}

# Check if frpc.ini exist. If not create with template
if [ ! -f $CONFIG_PATH ]; then
    echo "Creating frpc.ini"
    echo "[common]" > $CONFIG_PATH
    echo "server_addr = ${SERVER_IP}" >> $CONFIG_PATH
    echo "server_port = ${SERVER_PORT}" >> $CONFIG_PATH

    # If token is filled then add it
    if [ ! -z "${AUTH_TOKEN}" ]; then
        echo "token = ${AUTH_TOKEN}" >> $CONFIG_PATH
    fi

    echo "" >> $CONFIG_PATH
    echo "[hass]" >> $CONFIG_PATH
    echo "type = tcp" >> $CONFIG_PATH

    echo "local_ip = 127.0.0.1 " >> $CONFIG_PATH
    echo "local_port = ${LOCAL_PORT}" >> $CONFIG_PATH
    echo "remote_port = ${REMOTE_PORT}" >> $CONFIG_PATH

    echo "Creating frpc.ini done"
fi

bashio::log.info "Starting frp client"

cat $CONFIG_PATH

cd /usr/src
./frpc -c $CONFIG_PATH & WAIT_PIDS+=($!)

trap "stop_frpc" SIGTERM SIGHUP
wait "${WAIT_PIDS[@]}"
