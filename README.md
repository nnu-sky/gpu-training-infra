# GPU Training Infra

让 Codex 用短时、端到端的性能证据定位训练首要瓶颈，并验证真正减少总耗时的优化。

## 核心思路

不同训练项目的慢点可能来自基础设施、执行调度、数值计算、项目特有算法或它们之间的等待关系。固定优化清单容易错过真正热点，也容易在非瓶颈处投入时间。

本技能采用同一套通用流程：

1. 读取项目规则、入口、配置和已有日志；
2. 做最小基础检查，排除运行异常；
3. 用最短可代表窗口建立端到端时间图；
4. 继续拆分无法解释的高耗时路径；
5. 按总耗时贡献、可优化余量、风险和维护成本排序；
6. 一次验证一个首要改动；
7. 重新剖析，确认收益没有转移成新的等待。

流程不会预设数据、模型或某种数学实现一定是瓶颈，也不会默认穷举常见框架开关。项目特有路径只有进入实际热点后才会深入分析。

## 验收口径

每个被接受的改动都需要同时说明：

- 端到端时间和局部时间变化；
- 吞吐或有效工作量变化；
- 峰值显存及其他资源代价；
- 必要的数值、梯度、状态或任务指标检查；
- 适用范围和停止继续优化的理由。

默认只做短时分析与短基准。完整训练、配方搜索和多随机种子实验只有在用户明确要求时才执行。

## 快速开始

作为插件安装：

```bash
codex plugin marketplace add nnu-sky/gpu-training-infra
```

也可以只安装技能：

```text
https://github.com/nnu-sky/gpu-training-infra/tree/main/plugins/gpu-training-infra/skills/gpu-training-infra
```

安装后可以对 Codex 说：

```text
使用 $gpu-training-infra 对这个训练项目做短时端到端性能分析，定位首要热点并验证一个高价值优化。
```

## 仓库结构

```text
plugins/gpu-training-infra/
├── .codex-plugin/plugin.json
└── skills/gpu-training-infra/
    ├── SKILL.md
    ├── agents/openai.yaml
    └── references/performance-playbook.md
```

## 安全

仓库不包含服务器地址、账号、密钥、个人路径或私有项目配置。修改训练代码或执行项目脚本前，应先遵守目标项目的规则并核对运行范围。

## 许可证

MIT
