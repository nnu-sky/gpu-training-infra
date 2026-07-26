#!/usr/bin/env bash
set -euo pipefail

duration="${1:-15}"
if [[ ! "$duration" =~ ^[0-9]+$ ]] || (( duration < 1 || duration > 300 )); then
  echo "用法：$0 [1-300 秒]" >&2
  exit 64
fi

if ! command -v nvidia-smi >/dev/null 2>&1; then
  echo "未安装 nvidia-smi，无法采集 GPU 基线。" >&2
  exit 69
fi

printf '主机：%s\n' "$(hostname)"
printf '时间：%s\n' "$(date '+%Y-%m-%dT%H:%M:%S%z')"
printf '采样：%s 秒\n' "$duration"

printf '\nGPU 概览：\n'
nvidia-smi --query-gpu=index,name,driver_version,memory.used,memory.total,utilization.gpu,utilization.memory,temperature.gpu,power.draw --format=csv,noheader

printf '\nGPU 计算进程：\n'
nvidia-smi --query-compute-apps=gpu_uuid,pid,process_name,used_memory --format=csv,noheader 2>/dev/null || true

printf '\n按秒采样：\n'
nvidia-smi dmon -s pucvmet -d 1 -c "$duration"
