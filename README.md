> 统一维护入口：[nnu-sky/skills](https://github.com/nnu-sky/skills)。本仓库保留兼容安装包；新开发以统一仓库为准。

# GPU Training Infra

让 Codex 先完成训练流程的常规工程优化，再继续寻找当前项目独有的计算、状态与数值优化机会。

## 核心思路

训练性能通常不是只由一个环节决定。数据供给、主机与 GPU 协作、计算精度、内存、编译、同步、通信和周期性任务可以逐层形成收益；常规优化完成后，项目自己的算法与实现中还可能存在更值得处理的路径。

本技能采用两轮流程：

1. 理解训练入口、配置和已有记录；
2. 建立轻量基线并检查训练周期；
3. 根据实际情况完成常规工程优化；
4. 将有效改动逐步组合并重新观察；
5. 深入方法专属代码，寻找项目特有路径；
6. 允许实现改写、数值近似和替代算法；
7. 用与风险相称的短检查判断是否保留；
8. 简要报告单项、组合、显存和结果变化。

独立测试、推理和最终评价不是默认优化目标。训练优化完成后，只有用户希望继续或测试成本确实值得处理时，才进入测试优化。

## 使用特点

- 常规工程优化与项目专项探索都保留；
- 搜索方向用于启发判断，不要求机械执行固定清单；
- 不要求所有改动严格数学等价；
- 默认不运行完整训练、多随机种子实验或大规模搜索；
- 局部优化可以保留，但不会被表述成整个训练加速；
- 具体项目结论留在项目内，不写成其他项目的默认答案。

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
使用 $gpu-training-infra 先完成训练流程的常规工程优化，再探索项目特有路径和可接受近似，给出简短前后对比。
```

## 仓库结构

```text
plugins/gpu-training-infra/
├── .codex-plugin/
│   └── plugin.json
└── skills/gpu-training-infra/
    ├── SKILL.md
    ├── agents/
    │   └── openai.yaml
    ├── references/
    │   ├── baseline-and-profiling.md
    │   ├── optimization-playbook.md
    │   ├── batch-size-and-cost.md
    │   └── acceptance-and-reporting.md
    └── scripts/
        └── capture-training-baseline.sh
```

各部分职责：

- `SKILL.md`：定义训练优先、常规优化、专项探索和可选测试阶段的总体流程；
- `baseline-and-profiling.md`：建立轻量基线并理解训练周期；
- `optimization-playbook.md`：提供通用优化方向、组合方法、项目专项探索和近似方案；
- `batch-size-and-cost.md`：仅在需要时评估批量、显存和大致训练成本；
- `acceptance-and-reporting.md`：使用轻量对照，并区分局部和整体收益；
- `capture-training-baseline.sh`：可选的只读 GPU 状态快照。

技能不绑定某一种模型或任务，所有项目都沿用同一套通用思考流程。

## 安全

仓库不包含服务器地址、账号、密钥、个人路径或私有项目配置。修改训练代码或执行项目脚本前，应先遵守目标项目规则并核对运行范围。

## 许可证

MIT
