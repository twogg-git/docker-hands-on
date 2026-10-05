# Virtualization & Containers

![virtualization](/utils_srcs/rsc_virtualization.png)

## What Is Virtualization?

Virtualization is a technology that allows you to create simulated, software-based representations of physical hardware—including CPUs, memory, storage, and network interfaces. It decouples the operating system and applications from the underlying physical host machine, enabling a single physical server to execute multiple isolated virtual environments (Virtual Machines or VMs) simultaneously.

## Why Do We Need It?

- Hardware Utilization: Traditional physical deployments often run at only 10–15% CPU capacity. Virtualization consolidates multiple workloads onto a single physical host, driving utilization up to 70–80%.

- Isolation and Fault Tolerance: Each VM operates in complete software isolation. A crash, security breach, or kernel panic inside one VM does not impact neighboring VMs on the same physical host.

- Rapid Provisioning & Flexibility: Deploying a new server shifts from ordering and racking physical hardware (weeks) to cloning a VM image (seconds/minutes).

- Environment Consistency: VMs allow exact snapshots and migrations across different bare-metal hosts without requiring software modifications.

## Ways to Do Virtualization

Virtualization relies on a piece of software called a Hypervisor (or Virtual Machine Monitor), which manages hardware allocation and enforces isolation:
```
+---------------------------------+  +---------------------------------+
|  Type 1: Bare-Metal Hypervisor   |  |   Type 2: Hosted Hypervisor     |
+---------------------------------+  +---------------------------------+
| [VM 1]  [VM 2]  [VM 3]          |  | [VM 1]  [VM 2]                  |
| [Hypervisor (e.g., ESXi/KVM)]   |  | [Hypervisor (e.g., VirtualBox)] |
| [Bare-Metal Hardware]           |  | [Host OS (Linux/macOS/Windows)] |
+---------------------------------+  | [Bare-Metal Hardware]           |
                                     +---------------------------------+
```

## Type 1 (Bare-Metal) Hypervisors:

Installs directly onto the raw host hardware without an intervening host operating system.

**Examples:** VMware ESXi, KVM (Kernel-based Virtual Machine), Proxmox VE, Microsoft Hyper-V.

**Use Case:** Enterprise datacenters and production cloud environments where low overhead and high performance are required.


## Type 2 (Hosted) Hypervisors:

Runs as an application layer on top of a conventional host operating system.

**Examples:** Oracle VirtualBox, VMware Workstation, Parallels Desktop.

**Use Case:** Local desktop development, testing, and legacy application execution on personal machines.


---

# Containers

## Intro & Definition

Containers are lightweight, standalone units of software that package application code alongside all of its dependencies, libraries, configuration files, and runtime binaries. Unlike virtualization, containers do not virtualize the underlying hardware; instead, they virtualize the host operating system, sharing a single OS kernel while maintaining execution environment isolation.

## Brief History

- 1979 - chroot: Introduced in Unix for changing the root directory of a process, establishing early file-system isolation.

- 2000 - FreeBSD Jails: Expanded isolation by partitioning file systems, network interfaces, and user spaces.

- 2007 - cgroups (Control Groups): Developed at Google and merged into the Linux kernel to limit, account for, and isolate resource usage (CPU, memory, disk I/O) of process groups.

- 2008 - LXC (Linux Containers): Combined Linux cgroups and namespaces (PID, NET, IPC, MNT, UTS) to provide full OS-level containerization.

- 2013 - Docker: Standardized container image formatting, runtime execution, and developer tools, transforming containers from complex low-level Linux primitives into a scalable software delivery standard.

- 2014+ - Kubernetes: Introduced container orchestration to manage automated deployment, scaling, and high availability across container clusters.

## Types of Containers

Application Containers: Designed to run a single primary process or microservice (e.g., a Flask API, Nginx web server, or MongoDB instance). They are ephemeral, stateless by design, and spin up in milliseconds.

- Examples: Docker, OCI-compliant runtimes (containerd, CRI-O).

- System Containers: Designed to behave like a lightweight Virtual Machine, running an entire operating system environment including system initialization (systemd), multiple services, and management utilities inside a single container boundary.

- Examples: LXC/LXD, Systemd-nspawn.

## How We Use Containers Now

Modern infrastructure relies on containers as the foundational unit of application deployment:

- Microservices Architecture: Decoupling monolithic applications into independent, containerized services that scale independently.

- CI/CD Pipelines: Building immutable container artifacts during automated testing and shipping identical images directly to production.

- Cloud-Native Orchestration: Deploying containerized workloads at scale across cloud platforms using Kubernetes (EKS, GKE, AKS) for automated self-healing, rolling updates, and dynamic resource allocation.

## Reference Matrix

| Container Type | Key Runtimes | Isolation Mechanism | Primary Use Case |
| :--- | :--- | :--- | :--- |
| **MicroVM / Sandbox** | Kata Containers, AWS Firecracker, gVisor | Lightweight KVM / User-space Syscall Interception | Multi-tenant clouds, Serverless (AWS Lambda, Fargate), untrusted code execution |
| **System** | LXC / LXD | Host OS Kernel Namespaces | Running full Linux distributions (like lightweight VMs) without hypervisor overhead |
| **HPC (Supercomputing)** | Apptainer (Singularity), Charliecloud | Unprivileged Rootless User Namespaces | Scientific computing, GPU clusters, shared HPC infrastructure |
| **WebAssembly (Wasm)** | WasmEdge, Wasmtime, Wasmer | Sandboxed Bytecode Execution | Edge computing, ultra-fast serverless with sub-millisecond cold starts.|
| **Windows** | Docker (Windows), Hyper-V Runtimes | Windows Kernel / Hyper-V VM Boundary | Native .NET Framework and legacy Windows enterprise workloads |

---

# Strategic Selection & Coexistence Patterns


## When to Deploy Virtual Machines:

- Hard multi-tenancy requirements or strict regulatory compliance boundaries.

- Running non-Linux or heterogeneous operating system workloads (e.g., Windows Server alongside Linux).

- Monolithic legacy applications with complex system dependencies.


## When to Deploy Containers:

- Ephemeral, highly scalable microservices architectures.

- Rapid CI/CD integration and reproducible local-to-production deployment environments.

- Resource-constrained edge deployments requiring maximum process density.

- The Hybrid Standard: Running container runtimes inside Virtual Machines to combine hard infrastructure isolation with lightweight process orchestration.


## Virtualization vs. Containers Comparison

| Dimension | Virtualization (Virtual Machines) | Containers (OS-Level Isolation) |
| :--- | :--- | :--- |
| **Abstraction Level** | Hardware-level abstraction | OS Kernel-level abstraction |
| **Guest OS Requirement** | **Mandatory.** Every VM runs a full guest OS with its own kernel. | **None.** Shares the host machine's OS kernel directly. |
| **Resource Overhead** | High (Gigabytes of RAM and disk space reserved per OS). | Minimal (Megabytes of RAM; images contain only application code and dependencies). |
| **Startup Time** | Minutes (requires full OS boot sequence). | Milliseconds to Seconds (executes like a standard host process). |
| **Isolation Boundary** | **Strong.** Hardware-level execution boundary enforced by hypervisor extensions (VT-x/AMD-V). | **Process-Level.** Enforced by Linux kernel `namespaces` and `cgroups`. |
| **Portability** | Limited by hypervisor format compatibility and large disk image sizes (GBs). | **High.** Standardized OCI images run identically on any runtime/OS with a compatible kernel. |
| **Density** | Low to moderate VMs per physical host server. | High to very high containers per physical host server. |
| **Primary Use Case** | Running completely different OS kernels on one host, legacy monolithic apps, or multi-tenant hard isolation. | Cloud-native microservices, modern web apps, CI/CD pipelines, and rapid auto-scaling workloads. |

![docker_flow](utils_srcs/rsc_docker_flow.png)
