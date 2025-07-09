#!/bin/bash

CMD="freeradius -f"
SERVICE_NAME=freeradius

#: -----------------------------------------------------------------
usage() {
  echo "Usage: $0 <command> [options]"
  echo ""
  echo "Commands:"
  echo "  up        Run container in background (daemon)"
  echo "  down      Stop and remove container"
  echo "  stop      Stop container only"
  echo "  start     Run container in foreground once"
  echo ""
  echo "Options:"
  echo "  -d        Debug mode (freeradius -f -X)"
  echo "  -x        Verbose debug mode (freeradius -f -xx)"
  echo "  -h        Show this help"
  echo ""
  echo "Examples:"
  echo "  $0 up -d       # Up with debug"
  echo "  $0 start -x    # One-time verbose run"
}

#: -----------------------------------------------------------------
# 추출: 커맨드와 나머지 옵션
COMMAND="$1"
shift || true

# 옵션 파싱
while getopts "dxh" opt; do
  case "$opt" in
    d) CMD="freeradius -f -X" ;;
    x) CMD="freeradius -f -xx" ;;
    h) usage; exit 0 ;;
    *) usage; exit 1 ;;
  esac
done

#: 명령 실행 분기
case "$COMMAND" in
  up)
    echo "[*] Starting container in background with: $CMD"
    docker-compose up -d --no-deps --force-recreate $SERVICE_NAME
    docker-compose exec -T $SERVICE_NAME $CMD
    ;;
  down)
    echo "[*] Stopping and removing container..."
    docker-compose down
    ;;
  stop)
    echo "[*] Stopping container..."
    docker-compose stop $SERVICE_NAME
    ;;
  start)
    echo "[*] Running container once with: $CMD"
    docker-compose run --rm $SERVICE_NAME $CMD
    ;;
  *)
    usage
    exit 1
    ;;
esac
