#!/bin/bash

echo "请选择操作："
echo "1. 安装环境并运行节点"
echo "2. 查看当前日志"
read -p "输入选项（1或2）：" option

case $option in
  1)
    echo "正在安装 pm2..."
    npm i -g pm2
    echo "创建目录并进入..."
    mkdir -p al && cd al
    echo "下载并设置节点运行文件..."
    wget -O aleo-pool-prover https://github.com/zkrush/aleo-pool-client/releases/download/v1.5-testnet-beta/aleo-pool-prover && chmod +x aleo-pool-prover
    read -p "请输入节点名称：" node_name
    echo "启动节点..."
    pm2 start ./aleo-pool-prover --name "aleo-pool-prover" -- --pool wss://aleo.zkrush.com:3333 --account $node_name --worker-name $node_name
    ;;
  2)
    echo "查看日志..."
    pm2 logs aleo-pool-prover
    ;;
  *)
    echo "无效选项，请重新运行脚本选择正确的选项。"
    exit 1
    ;;
esac

