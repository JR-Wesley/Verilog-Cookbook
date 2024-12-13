# Refactoring version of 《FPGA应用开发和仿真》

## Overview

**Purpose**:
This repository is dedicated to refactoring the codebase to improve its structure and modularity.
The original code is written primarily for publication without a good coding style.
After learning the book and using the code for development, I decide to organize the code for better maintainability and re-usability.

**Key Feature:**
- Avoiding using behavior description. RTL Code reflects what circuit looks like.
- Replace synchronous reset with asynchronous `rst_n`.
- Reorganized Code into logical modules for better separation of concerns. One Module in one file. And better file hierarchy.
- Formatted with `Verible` and `Verilator` linting. Compilation commands using `iverilog`, `Verilator` in Linux.
- Comments on the compiler or platform dependency.

**Status**:
This branch is under active development. You are welcomed to follow and contribute.
More details or the principle of digital design can be referred to this book.


## 说明

此仓库中的主要内容为《FPGA应用开发和仿真》（机械工业出版社2018年第1版 ISBN:9787111582786）的源码。在书本出版后，仍陆续进行了一些bug修复、优化和增加了一些其他有关内容。

The major content in this repository are the source code and errata for the book *FPGA Application Development and Simulation* (CHS, ISBN:9787111582786). After the publication of the book, some bug fixes, code optimizations and other related content have been added one after another.

所有SystemVerilog模块均可综合，除了：

1. Testbench模块；
2. 多数FPGA开发工具不支持let表达，可替换为任务;
3. 一些FPGA开发工具不支持参数表达式的解算(比如较老版本的Quartus)，可自行计算后替换。

All modules are synthesizable, EXCEPT:

1. Modules for testbenches;
2. Most FPGA Dev. tools does not support "let" construct, which can be converted to task;
3. Some FPGA Dev. tools (i.e.: old versions of quartus) does not support the evaluation of real parameter expressions, you may calculate and replace them by yourself.

## 源码说明

源码内有Modelsim工程，其工程文件（mpf文件，实为文本文件）内对源文件等的引用采用的是绝对路径，如需要打开mpf工程复现仿真过程，需要先用文本编辑器打开mpf文件，查找替换文件路径至您下载解压后的文件路径。

There ara Modelsim projects(created by ModelSim PE Student Edition 10.4a) in the source code. References to the source files in those project file (".mpf" file, a kind of text file) are absolute paths.
If you need to open a mpf project to reproduce the simulation process, you have to open the mpf file with a text editor, find and replace those file paths to the paths of the files in your computer.

## 书本内容简介(Brief Introduction of The Text Book)

本书前四章首先讲述FPGA应用设计相关的数字电路基础知识，而后介绍了可综合SystemVerilog语法和常用测试平台语法，之后讲解了常用基本数字逻辑功能的Verilog描述和仿真，这些是后续几章的基础。

第五章和第六章讲解常用外部总线功能和SoC内部互联功能的实现，第七章和第八章则是数字信号处理应用和数字通信应用。

全书Verilog模块均是从实际教学和工程应用中提炼而来，参考价值高，可重用性好，自第四章起，模块依赖层层递进，自成一体。本书可作为本、专科学生学习FPGA的主要参考书，也可作为相关研究生、工程师的参考资料。

## 书本前言(Foreword of The Text Book)

笔者2004年开始学习FPGA，从此被其强大的灵活性吸引，从此一切成本不敏感的项目，能用FPGA的，不会考虑其它。从简单的逻辑控制、MCU替代到高速的信号处理、网络与通信应用，没有一片FPGA（或含有处理器核）不能驾驭的，“一片不行，那就两片！”在成本不敏感的领域，如科研、产品或芯片原型研发和验证中，FPGA扮演了极其重要的角色，因为在这些领域中，往往包含大量特殊的、创新的定制逻辑和功能，或者具备极其高的数据传输带宽，并非MCU、MPU（DSP是MPU的一种）或应用处理器所能胜任。

即使是MCU或MPU能够胜任的工作，使用FPGA来完成，你可以肆意挥洒自己的创意，构建符合自己习惯的逻辑接口和功能，创造符合特殊要求的功能模块和处理器外设，而不必像使用通用MCU或MPU那样，去学习为了功能通用而设置的纷繁复杂的接口、控制寄存器或API函数。当然，前提是项目成本不敏感，并且你具备深厚的FPGA开发功力——这比MCU或MPU开发要难很多。但终端产品领域，是FPGA尚无法触及的，主要限制是成本、功耗和开发难度。在成本和功耗上，FPGA灵活的本质决定了它无法与MCU或MPU抗衡，同时终端产品往往出货量也很大，因而在高带宽或特殊定制逻辑方面，也可以由ASIC胜任——ASIC在量大时，成本极低。

而开发难度大则源于多个方面。在理论方面，想要用好FPGA，甚至说，想要入门FPGA，都必须掌握扎实的数字逻辑基础知识。在语言方面，用于FPGA开发的硬件描述语言（HDL）描述的数字逻辑电路是并行运行的，与人类思维的串行性（即一步一步的思考）不符，而MCU等开发使用的程序语言则符合人类思维的串行性，相对易于入门和掌握。依笔者浅见，“程序”一词含有“依序执行的过程”之意，与可综合的硬件描述语言的并行性不符，因而本书中尽量避免使用“程序”一词指代可综合的硬件描述语言代码。

开发困难还源于FPGA技术近年来的快速发展和FPGA相关教育的滞后。

笔者自六年前开始面向华中科技大学启明学院电工电子科技创新中心（以下简称“创新中心”）学生开设FPGA应用相关的选修课，并为他们设计开发板，无论课程内容还是开发板，每年都可能会变动以便跟进新的技术发展。

创新中心学生主要来自全校各电类相关院系，并经过严格的考核选入，都是理论成绩和实践能力兼优、并对电子技术有着浓烈兴趣的学生。但笔者依然感受到FPGA应用教学的困难，特别是在引导和帮助他们使用FPGA实现具备一定难度和深度的功能的时候，或者在实现一个完备的电子电路系统，比如将FPGA用作大学生电子设计竞赛作品主控，或者各类研究、双创项目的主要实现平台的时候。

笔者以为，FPGA应用教学的困难直接反映了数字电路应用教学的困难，这与传统数字电路课程设置不无关系。在电子技术子领域日趋细分、国内大学电类专业日趋细分的当代，侧重数字电路应用的专业（如通信、电气、自动化等）仍然在深入学习SR锁存器的电路构成、深入学习如何用74系列IC设计异步时序逻辑电路。笔者并不认为这些不重要，但以为这些应该是侧重数字电路理论的专业（如电子、电信等）才需要深入学习的内容，毕竟侧重数字电路应用的专业的学生以后一般不需要设计IC；不需要在数字逻辑电路中做晶体管级的优化；也不需要为少数关键路径而动用异步逻辑、锁存器逻辑。相应地，在侧重数字电路应用的专业中，现代数字电路应用中的同步时序逻辑内容并没有提升到应有的地位，与之相关的时钟概念和知识、常用的时序逻辑功能单元、基础的时序分析概念和知识也是比较缺失的。

本书中，笔者提炼和扩展了传统数字电路课程中与FPGA应用相关的部分，形成了本书的第一章，便于读者快速强化FPGA应用设计所需的数字电路基础知识，尚未学习数字电路课程的低年级读者也可以通过学习第一章来入门数字电路基础。

第二章则是SystemVerilog（IEEE1800-2012）简明语法讲解，主要侧重可综合（即可以在FPGA中实现）的语法，最新的IEEE1800-2012标准较早期版本引入了不少漂亮的语法元素，让笔者急切地想与读者分享，后果是少数理应可综合的语法在目前主流开发工具中尚不支持，或许它们还需要一点时间来跟进，遇到这些特例，书中均会给出解决方法。

第三章是使用ModelSim进行Verilog功能仿真的简单教程。

第四章是Verilog的基本应用，这一章主要介绍各种数字逻辑基本功能单元的描述，并着重介绍了时钟、使能的概念和跨时钟域处理。从这一章起，我们正式开始了FPGA应用设计之旅。

第五章介绍IO规范，首先通识性地介绍了IO连接的常识和常见电平规范，而后以四种常见外部逻辑接口规范为例，介绍了通用接口逻辑的设计和实现。希望读者能在学习过程中领会到此类设计的一般思路和处理方法。

第六章介绍片上系统的内部互连。片上系统（SoC）结合了通用处理器和FPGA逻辑的优势，实现了软硬件协同设计，是当下FPGA应用技术的热门。而要充分利用SoC的优势，发挥软硬件协同的潜力，处理器系统与FPGA逻辑的高速互连至关重要。此章从一种简单的互连接口入手，逐步过渡到介绍目前应用最为广泛的AXI互连协议。

第七章介绍Verilog在数字信号处理中的基本应用，主要介绍了一些基础数字信号处理算法的实现，包括频率合成、FIR和IIR滤波器、采样率变换、傅里叶变换和常见于数字控制系统的PID控制器。

第八章介绍Verilog在数字通信中的基本应用，主要介绍了基带编解码、各类基础调制解的实现。

这些章节的依赖关系如下图所示。

<img src="foreword.png" alt="chapter_relations" style="zoom:67%;" />

本书侧重Verilog在FPGA中的应用基础，对于特定FPGA芯片、特定开发工具、特定外部连接和具体系统案例，请关注即将出版的此书的另外两篇。

本书特别注重理论与工程实现的结合，以实现为主，以相关理论的结论为指导，读者应着重理解理论与实现的对应关系，注意培养将理论转换为工程实现的能力。

本书中的代码均为可综合代码，均是从笔者多年教学和工程实践中实际应用过的代码中提炼而来，具备极高的实践参考价值，并大量采用参数化设计方法，大量采用生成块和常量表达式/函数，具备极高的可重用性。书中不可综合的代码只有：明确说明为测试平台；明确说明有些开发工具尚不支持的某些新语法，但一般会给出修改方法。

本书是笔者多年FPGA开发和教学经验的总结，弥补了多年来面向创新中心学生讲授FPGA应用课程时的教材缺失——虽然优秀教材有很多，但并没有特别吻合笔者思路和对学生要求的。希望本书能对正在学习FPGA应用技术的本、专科学生给予有力的帮助，也希望能给正在使用FPGA进行项目开发的在校研究生、在业工程师一点借鉴和提示。

书中涉及到少数较新的英文术语，因未见到广泛统一或权威的翻译，笔者尝试对其进行了翻译并在文中保留了英文，便于读者对照理解。

笔者水平有限，书中难免有偏颇谬误之处，欢迎广大读者批评指正！

最后，感谢创新中心尹仕、肖看老师和电气与电子工程学院实验教学中心的同事们！感谢我的父母、女友！感谢创新中心605实验室的同学们！是在他们的支持和帮助下，本书才得以顺利完成。特别感谢姜鑫同学通读了书稿，并协助我完成了部分审校工作；特别感谢我的女友帮我绘制了书中电路图的国标版本。
