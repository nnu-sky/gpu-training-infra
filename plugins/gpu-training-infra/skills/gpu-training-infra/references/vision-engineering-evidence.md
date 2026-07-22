# 视觉训练工程证据与实现选择

仅在设计视觉优化实验、引入新数据后端或查找实现依据时读取。以项目锁定版本的实际文档为准。

## 第一优先级：PyTorch 官方

- 性能调优指南：DataLoader、页锁定内存、AMP、`channels_last`、cuDNN 自动调优、梯度清零和 DDP。
  `https://docs.pytorch.org/tutorials/recipes/recipes/tuning_guide.html`
- 页锁定内存与非阻塞传输：核对异步拷贝成立的条件与测量方法。
  `https://docs.pytorch.org/tutorials/intermediate/pinmem_nonblock.html`
- 自动混合精度：`autocast`、`bf16`、`fp16` 与梯度缩放。
  `https://docs.pytorch.org/tutorials/recipes/recipes/amp_recipe.html`
- `torch.compile`：默认模式、`reduce-overhead`、首次编译、图断裂和缓存。
  `https://docs.pytorch.org/tutorials/intermediate/torch_compile_tutorial.html`
- PyTorch Profiler：CPU/CUDA 算子、显存、受控等待、预热和活动窗口。
  `https://docs.pytorch.org/docs/stable/profiler.html`
- TorchVision 分类参考：ResNet 训练、多卡、AMP、增强与验证实现。
  `https://github.com/pytorch/vision/tree/main/references/classification`
- TorchVision v2 变换：张量图像、批量变换和视觉增强接口。
  `https://docs.pytorch.org/vision/stable/transforms.html`
- DDP 文档：每卡一进程、分布式采样、NCCL、梯度桶和静态图选项。
  `https://docs.pytorch.org/docs/stable/generated/torch.nn.parallel.DistributedDataParallel.html`

## 数据管线候选

- FFCV：记录格式、缓存、预加载、异步传输与即时编译；适合已经证明存在数据瓶颈的 ImageNet 类任务。
  `https://github.com/libffcv/ffcv`
- FFCV 论文：Leclerc 等，CVPR 2023，《FFCV: Accelerating Training by Removing Data Bottlenecks》。
  `https://openaccess.thecvf.com/content/CVPR2023/html/Leclerc_FFCV_Accelerating_Training_by_Removing_Data_Bottlenecks_CVPR_2023_paper.html`
- NVIDIA DALI：GPU／CPU 解码与增强、异步执行和多 GPU 数据管线。
  `https://docs.nvidia.com/deeplearning/dali/user-guide/docs/`

## 工程案例

- NVIDIA DeepLearningExamples 的卷积分类代码包含 ResNet 性能与精度报告；借鉴测量和实现，不复用旧硬件结果。
  `https://github.com/NVIDIA/DeepLearningExamples/tree/master/PyTorch/Classification/ConvNets`
- PyTorch Image Models 包含成熟的视觉训练、验证、增强与分布式脚本；区分训练配方和纯性能设置。
  `https://github.com/huggingface/pytorch-image-models`
- CIFAR10 AirBench 展示极限小图像训练的整批数据、GPU 增强和编译思路，只作为灵感；其数据集、目标精度和配方与 CIFAR100 不等价。
  `https://github.com/KellerJordan/cifar10-airbench`

## 选择规则

1. 先使用 PyTorch 与 TorchVision 原生能力，取得可解释基线。
2. 只有 Profiler 和分段计时证明输入受限时，才引入 FFCV 或 DALI。
3. 新后端先做样本、标签、归一化与增强分布核对，再做速度测试。
4. 公开项目中的绝对吞吐只用于理解方法，不与本地测量直接比较。
5. 不安装来源不明的训练优化技能；把经过验证的官方做法沉淀到本技能和具体项目测试中。
6. 外部项目用于借鉴实现与测量口径；本地未复现的绝对提速不得写成默认能力。
