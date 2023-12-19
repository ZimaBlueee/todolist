#!/bin/bash

# 定义项目根目录
PROJECT_ROOT="/opt/project/todolist"

# 进入项目目录
cd $PROJECT_ROOT || exit 1

# 从 Git 拉取最新代码
echo "更新git代码===>"
git pull --rebase || exit 1

# 设置 Docker Compose 文件的路径
COMPOSE_FILE=./docker/docker-compose.yml

# 构建 Docker 镜像
echo "制作docker镜像===>"
docker compose -f $COMPOSE_FILE build || exit 1

# 检查并停止已运行的容器
echo "停止已运行的容器===>"
docker compose -f $COMPOSE_FILE down || exit 1

# 启动新的容器
echo "开始部署容器===>"
docker compose -f $COMPOSE_FILE up -d || exit 1

