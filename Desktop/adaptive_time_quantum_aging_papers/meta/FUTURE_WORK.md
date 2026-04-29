# Future Work

## Near-Term Tasks

1. Finalize the simulation environment for baseline Round Robin variants
2. Implement a simple thermal estimator and aging proxy model
3. Reproduce fixed RR and dynamic RR baseline metrics
4. Implement the heuristic aging-aware scheduler
5. Define the combined performance-reliability objective function

## Mid-Term Research Tasks

1. Generate labeled data for supervised quantum prediction
2. Train and compare Random Forest, XGBoost, and LightGBM models
3. Add migration-aware policy variants
4. Integrate optional DVFS-aware actions into the scheduler model
5. Run ablation studies across queue-only, queue+thermal, and queue+thermal+aging settings

## Long-Term Extensions

1. Explore contextual bandit and reinforcement learning based scheduler policies
2. Improve the aging model with separate BTI, HCI, EM, and thermal-cycling proxies
3. Move from a simple simulator to a more detailed architecture simulator if needed
4. Study real trace-driven workloads instead of only synthetic workloads
5. Compare simulator findings with practical implementation constraints in real systems

## Open Questions

1. How much scheduler overhead is acceptable before the reliability benefit becomes insignificant?
2. Which hardware signals are the most informative for quantum selection?
3. Does RL truly outperform lightweight heuristic or supervised models in this problem?
4. Under which workload families is aging-aware quantum control most beneficial?
5. How well do simulation-based gains transfer to real hardware or kernel-level implementations?
