# Project Summary

## Title

AI-Driven Aging-Aware Adaptive Time Quantum Scheduling

## Short Description

This project investigates whether CPU scheduler time quantum selection can be improved by combining
classical queue-state information with hardware-aware feedback such as temperature, utilization stress,
and aging estimates.

Rather than optimizing only waiting time or turnaround time, the proposed approach studies a broader
objective that includes:

- scheduler performance
- thermal behavior
- hardware aging and projected lifetime

## Core Idea

Traditional dynamic quantum scheduling and hardware aging control are usually studied separately.
This project brings them together by asking whether a scheduler can make more intelligent runtime
decisions when it is aware of both workload behavior and hardware health.

## Proposed System

The proposed system is an aging-aware adaptive scheduler that may control:

- time quantum
- task migration
- optional DVFS actions

using inputs such as:

- ready queue length
- burst statistics
- per-core utilization
- temperature
- thermal gradients
- cumulative aging score

## Methodology

The work is structured in stages:

1. Fixed and classical dynamic Round Robin baselines
2. Heuristic aging-aware hybrid scheduler
3. Physics-informed supervised learning for quantum prediction
4. Contextual bandit or reinforcement learning based policy exploration

## Main Evaluation Goal

The study aims to determine whether the proposed scheduler can achieve one of the following:

- same performance, less aging
- same aging budget, better performance

## Important Note

The project is intentionally framed objectively. It does not assume the new scheduler will always
outperform classical methods. It also studies the situations in which policy overhead, migration cost,
or aggressive aging protection may reduce the expected benefit.
